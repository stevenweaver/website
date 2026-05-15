#!/usr/bin/env bash
# Fetches ReviewBrah 2025 transcripts and extracts ratings via Claude CLI.
# Run from the website repo root: ./scripts/fetch-reviewbrah-2025.sh
#
# Prerequisites: yt-dlp, python3, claude CLI
# If rate-limited by YouTube, wait a few hours and retry.

set -euo pipefail

WORK_DIR="/tmp/reviewbrah_2025"
TRANSCRIPTS_DIR="$WORK_DIR/transcripts"
OUTPUT_FILE="$WORK_DIR/ratings_2025.md"

mkdir -p "$TRANSCRIPTS_DIR"

echo "=== Step 1: Getting 2025 video list ==="

# Get flat playlist (fast, no rate limit issues)
if [ ! -f "$WORK_DIR/flat_list.txt" ]; then
  yt-dlp -s --flat-playlist \
    --print "%(id)s %(title)s" \
    "https://www.youtube.com/@TheReportOfTheWeek/videos" \
    > "$WORK_DIR/flat_list.txt" 2>/dev/null
  echo "Got $(wc -l < "$WORK_DIR/flat_list.txt") total videos"
fi

echo "=== Step 2: Getting upload dates ==="

# Get upload dates for recent videos (this is the slow part)
if [ ! -f "$WORK_DIR/dated_list.txt" ]; then
  # Extract IDs from flat list, take first 80 (covers well past 2025)
  head -80 "$WORK_DIR/flat_list.txt" | awk '{print "https://www.youtube.com/watch?v=" $1}' \
    > "$WORK_DIR/urls_to_date.txt"

  echo "Fetching metadata for $(wc -l < "$WORK_DIR/urls_to_date.txt") videos..."
  echo "This will take ~10 minutes."

  yt-dlp --skip-download \
    --print "%(upload_date)s | %(title)s | %(id)s" \
    --batch-file "$WORK_DIR/urls_to_date.txt" \
    2>/dev/null > "$WORK_DIR/dated_list.txt"

  echo "Got dates for $(wc -l < "$WORK_DIR/dated_list.txt") videos"
fi

# Filter to 2025 only
grep '^2025' "$WORK_DIR/dated_list.txt" > "$WORK_DIR/videos_2025.txt" || true
VIDEO_COUNT=$(wc -l < "$WORK_DIR/videos_2025.txt")
echo "Found $VIDEO_COUNT videos from 2025"

echo "=== Step 3: Downloading transcripts ==="

# Download transcripts using YouTube's caption API via Python
python3 << 'PYEOF'
import urllib.request
import json
import re
import time
import os
import sys

TRANSCRIPTS_DIR = os.environ.get("TRANSCRIPTS_DIR", "/tmp/reviewbrah_2025/transcripts")
VIDEOS_FILE = os.environ.get("WORK_DIR", "/tmp/reviewbrah_2025") + "/videos_2025.txt"

headers = {
    "User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36",
    "Accept-Language": "en-US,en;q=0.9",
}

with open(VIDEOS_FILE) as f:
    lines = [l.strip() for l in f if l.strip()]

total = len(lines)
success = 0
skipped = 0
fail = 0

for i, line in enumerate(lines):
    parts = line.split(" | ")
    if len(parts) < 3:
        continue
    date, title, vid_id = parts[0], parts[1], parts[2].strip()

    out_file = os.path.join(TRANSCRIPTS_DIR, f"{vid_id}.txt")

    # Skip if already downloaded
    if os.path.exists(out_file) and os.path.getsize(out_file) > 100:
        skipped += 1
        continue

    # Step 1: Load video page to get caption track URL
    url = f"https://www.youtube.com/watch?v={vid_id}"
    req = urllib.request.Request(url, headers=headers)
    try:
        with urllib.request.urlopen(req, timeout=15) as resp:
            html = resp.read().decode("utf-8", errors="ignore")
            match = re.search(r'"captionTracks":\s*(\[.*?\])', html)
            if not match:
                print(f"[{i+1}/{total}] SKIP (no captions): {title[:50]}")
                fail += 1
                continue
            tracks = json.loads(match.group(1))
            if not tracks:
                fail += 1
                continue
            cap_url = tracks[0].get("baseUrl", "") + "&fmt=json3"
    except Exception as e:
        print(f"[{i+1}/{total}] ERROR (page): {e}")
        fail += 1
        time.sleep(5)
        continue

    # Step 2: Fetch caption text
    time.sleep(3)
    req2 = urllib.request.Request(cap_url, headers=headers)
    try:
        with urllib.request.urlopen(req2, timeout=15) as resp2:
            data = json.loads(resp2.read())
            events = data.get("events", [])
            text = " ".join(
                " ".join(seg.get("utf8", "") for seg in e.get("segs", []))
                for e in events if e.get("segs")
            )
            with open(out_file, "w") as f:
                f.write(text)
            success += 1
            print(f"[{i+1}/{total}] OK ({len(text)} chars): {title[:50]}")
    except urllib.error.HTTPError as e:
        if e.code == 429:
            print(f"[{i+1}/{total}] RATE LIMITED - waiting 60s...")
            time.sleep(60)
            # Retry once
            try:
                req3 = urllib.request.Request(cap_url, headers=headers)
                with urllib.request.urlopen(req3, timeout=15) as resp3:
                    data = json.loads(resp3.read())
                    events = data.get("events", [])
                    text = " ".join(
                        " ".join(seg.get("utf8", "") for seg in e.get("segs", []))
                        for e in events if e.get("segs")
                    )
                    with open(out_file, "w") as f:
                        f.write(text)
                    success += 1
                    print(f"[{i+1}/{total}] OK (retry): {title[:50]}")
            except Exception:
                fail += 1
                print(f"[{i+1}/{total}] FAIL (still rate limited)")
                time.sleep(30)
        else:
            fail += 1
            print(f"[{i+1}/{total}] ERROR HTTP {e.code}")
    except Exception as e:
        fail += 1
        print(f"[{i+1}/{total}] ERROR: {e}")

print(f"\nTranscripts: {success} new, {skipped} cached, {fail} failed")
PYEOF

# Count what we have
TRANSCRIPT_COUNT=$(find "$TRANSCRIPTS_DIR" -name "*.txt" -size +100c | wc -l | tr -d ' ')
echo "Total transcripts available: $TRANSCRIPT_COUNT"

echo "=== Step 4: Extracting ratings via Claude ==="

# Build the output file header
echo "| Reviewed Item | Restaurant | Cost | Rating | Review Date |" > "$OUTPUT_FILE"
echo "| --- | --- | --- | --- | --- |" >> "$OUTPUT_FILE"

# Process each transcript with Claude CLI
while IFS=' | ' read -r date title vid_id; do
  vid_id=$(echo "$vid_id" | tr -d '[:space:]')
  transcript_file="$TRANSCRIPTS_DIR/${vid_id}.txt"

  if [ ! -f "$transcript_file" ] || [ ! -s "$transcript_file" ]; then
    echo "SKIP (no transcript): $title"
    continue
  fi

  echo "Processing: $title ($date)..."

  # Format date as YYYY-MM-DD
  formatted_date="${date:0:4}-${date:4:2}-${date:6:2}"

  # Use Claude CLI to extract structured data from transcript
  result=$(cat "$transcript_file" | claude --print \
    "This is an auto-generated transcript from a ReviewBrah (TheReportOfTheWeek) YouTube food review video uploaded on $formatted_date titled \"$title\".

Extract ONLY the food items he reviews with numerical ratings. For each item output a single markdown table row:
| Item Name | Restaurant | Cost | Rating | $formatted_date |

Rules:
- Rating must be a number he explicitly states (e.g. \"8.5 out of 10\" → 8.5)
- Cost is what he says he paid. Use \"-\" if not mentioned.
- If this is NOT a food review (commentary, year-end list, etc), output nothing.
- If he reviews multiple items, output multiple rows.
- Output ONLY the table rows, no other text." 2>/dev/null)

  if [ -n "$result" ]; then
    echo "$result" >> "$OUTPUT_FILE"
    echo "  → $(echo "$result" | wc -l | tr -d ' ') items extracted"
  else
    echo "  → No ratings found (may not be a review)"
  fi

  sleep 1
done < "$WORK_DIR/videos_2025.txt"

echo ""
echo "=== Done! ==="
echo "Output: $OUTPUT_FILE"
echo ""
echo "To update the site, copy the table rows from $OUTPUT_FILE"
echo "into src/routes/tutorials/reviewbrah/+page.md"
cat "$OUTPUT_FILE"
