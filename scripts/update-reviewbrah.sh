#!/bin/bash
# Downloads ReviewBrah 2025 transcripts and extracts ratings via LLM
# Run this when YouTube rate limiting has cleared (wait a few hours after heavy yt-dlp usage)
#
# Prerequisites: pip install youtube-transcript-api
# Optional (for LLM extraction): pip install llm && llm keys set openai (or use claude)

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
WORK_DIR="/tmp/reviewbrah_2025"
PAGE_FILE="$SCRIPT_DIR/../src/routes/tutorials/reviewbrah/+page.md"

mkdir -p "$WORK_DIR"

echo "=== Step 1: Fetching 2025 video list from YouTube ==="
yt-dlp --dateafter 20250101 --datebefore 20251231 \
  --skip-download \
  --print "%(upload_date)s|%(title)s|%(id)s" \
  "https://www.youtube.com/@TheReportOfTheWeek/videos" \
  2>/dev/null | sort > "$WORK_DIR/videos.txt"

VIDEO_COUNT=$(wc -l < "$WORK_DIR/videos.txt")
echo "Found $VIDEO_COUNT videos from 2025"

echo ""
echo "=== Step 2: Downloading transcripts ==="

python3 << 'PYEOF'
import os
import time
from youtube_transcript_api import YouTubeTranscriptApi

work_dir = "/tmp/reviewbrah_2025"
ytt = YouTubeTranscriptApi()

with open(os.path.join(work_dir, "videos.txt")) as f:
    lines = [l.strip() for l in f if l.strip()]

success = 0
fail = 0
for i, line in enumerate(lines):
    date, title, vid_id = line.split("|", 2)
    out_file = os.path.join(work_dir, f"{vid_id}.txt")

    if os.path.exists(out_file) and os.path.getsize(out_file) > 100:
        success += 1
        continue

    try:
        transcript = ytt.fetch(vid_id)
        text = " ".join([snippet.text for snippet in transcript.snippets])
        with open(out_file, "w") as f:
            f.write(f"DATE: {date}\nTITLE: {title}\n\n{text}")
        success += 1
        print(f"[{i+1}/{len(lines)}] OK: {title[:60]}")
    except Exception as e:
        fail += 1
        print(f"[{i+1}/{len(lines)}] FAIL ({type(e).__name__}): {title[:60]}")

    time.sleep(1)  # Be polite

print(f"\nDone: {success} success, {fail} fail")
PYEOF

echo ""
echo "=== Step 3: Extracting ratings with Claude ==="
echo "Combining transcripts..."

# Build combined transcript file
> "$WORK_DIR/combined.txt"
while IFS='|' read -r date title vid_id; do
    transcript_file="$WORK_DIR/${vid_id}.txt"
    if [ -f "$transcript_file" ] && [ -s "$transcript_file" ]; then
        echo "=== VIDEO: $title | DATE: $date | ID: $vid_id ===" >> "$WORK_DIR/combined.txt"
        cat "$transcript_file" >> "$WORK_DIR/combined.txt"
        echo -e "\n---END---\n" >> "$WORK_DIR/combined.txt"
    fi
done < "$WORK_DIR/videos.txt"

echo "Combined transcript size: $(wc -c < "$WORK_DIR/combined.txt") bytes"
echo ""
echo "=== NEXT STEPS ==="
echo ""
echo "Feed the combined transcript through your LLM of choice:"
echo ""
echo '  cat /tmp/reviewbrah_2025/combined.txt | llm -s "Extract food review ratings from these ReviewBrah video transcripts. For each review, output a markdown table row: | Item Name | Restaurant | Cost | Rating | Review Date (YYYY-MM-DD) |. Skip non-review videos (commentary, controversy, year-end lists). Only output table rows, no headers."'
echo ""
echo "Or paste into Claude.ai with the same prompt."
echo ""
echo "Then prepend the output to the table in:"
echo "  $PAGE_FILE"
