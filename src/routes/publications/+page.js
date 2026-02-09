const ORCID_ID = '0000-0002-6931-7191';
const ORCID_API = `https://pub.orcid.org/v3.0/${ORCID_ID}`;
const CROSSREF_MAILTO = 'mailto=stevenweaver@gmail.com';

async function fetchCrossrefBatch(fetch, dois, batchSize = 5) {
	const authorsByDoi = new Map();
	for (let i = 0; i < dois.length; i += batchSize) {
		const batch = dois.slice(i, i + batchSize);
		const results = await Promise.allSettled(
			batch.map((doi) =>
				fetch(
					`https://api.crossref.org/works/${encodeURIComponent(doi)}?${CROSSREF_MAILTO}`,
					{ headers: { Accept: 'application/json' } }
				).then((r) => (r.ok ? r.json() : null))
			)
		);
		results.forEach((result, j) => {
			if (result.status !== 'fulfilled' || !result.value) return;
			const msg = result.value.message;
			if (!msg?.author) return;
			const authors = msg.author
				.filter((a) => a.family)
				.map((a) => ({
					name: a.given ? `${a.given} ${a.family}` : a.family,
					sequence: a.sequence || 'additional'
				}));
			authorsByDoi.set(batch[j].toLowerCase(), authors);
		});
	}
	return authorsByDoi;
}

export async function load({ fetch }) {
	// Step 1: Get work summaries from ORCID
	const res = await fetch(`${ORCID_API}/works`, {
		headers: { Accept: 'application/json' }
	});
	if (!res.ok) {
		return { publications: [], error: 'Failed to fetch publications from ORCID' };
	}

	const data = await res.json();
	const groups = data.group || [];

	// Extract one publication per group (prefer journal-article over preprint)
	const raw = groups.map((g) => {
		const summaries = g['work-summary'];
		let best = summaries[0];
		for (const s of summaries) {
			if (s.type === 'journal-article') {
				best = s;
				break;
			}
		}

		const title = best?.title?.title?.value || '';
		const journal = best?.['journal-title']?.value || '';
		const year = best?.['publication-date']?.year?.value || '';
		const month = best?.['publication-date']?.month?.value || '';
		const type = best?.type || '';

		const externalIds = best?.['external-ids']?.['external-id'] || [];
		const doiEntry = externalIds.find((e) => e['external-id-type'] === 'doi');
		const doi = doiEntry?.['external-id-value'] || '';
		const url = doiEntry?.['external-id-url']?.value || best?.url?.value || '';

		return { title, journal, year, month, type, doi, url, authors: [], isFirstAuthor: false };
	});

	// Deduplicate by normalized title
	const seen = new Map();
	for (const pub of raw) {
		const key = pub.title.toLowerCase().replace(/[^a-z0-9]/g, '').slice(0, 60);
		if (!key) continue;

		const existing = seen.get(key);
		if (!existing) {
			seen.set(key, pub);
		} else {
			const rank = (t) =>
				({ 'journal-article': 4, 'book-chapter': 3, other: 2, preprint: 1 })[t] || 0;
			if (rank(pub.type) > rank(existing.type)) {
				seen.set(key, pub);
			}
		}
	}

	const pubs = [...seen.values()];

	// Step 2: Fetch author data from Crossref (batched to avoid rate limits)
	const dois = pubs.filter((p) => p.doi).map((p) => p.doi);
	const authorsByDoi = await fetchCrossrefBatch(fetch, dois);

	// Merge author data into publications
	for (const pub of pubs) {
		if (!pub.doi) continue;
		const authors = authorsByDoi.get(pub.doi.toLowerCase());
		if (!authors) continue;
		pub.authors = authors.map((a) => a.name);
		const first = authors[0];
		pub.isFirstAuthor = first && /\bweaver\b/i.test(first.name);
	}

	// Sort: first-author first, then by year descending
	const publications = pubs.sort((a, b) => {
		if (a.isFirstAuthor !== b.isFirstAuthor) return a.isFirstAuthor ? -1 : 1;
		if (b.year !== a.year) return (b.year || '0').localeCompare(a.year || '0');
		return (b.month || '0').localeCompare(a.month || '0');
	});

	return { publications };
}
