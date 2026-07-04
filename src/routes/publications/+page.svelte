<script>
	let { data } = $props();

	function formatAuthors(authors) {
		if (!authors || authors.length === 0) return '';
		return authors.map((a) => {
			if (/\bweaver\b/i.test(a)) {
				return `<strong>${a}</strong>`;
			}
			return a;
		}).join(', ');
	}

	const firstAuthor = $derived(data.publications.filter((p) => p.isFirstAuthor));
	const other = $derived(data.publications.filter((p) => !p.isFirstAuthor));
</script>

<h1>Publications</h1>

<p>
	Pulled from <a href="https://orcid.org/0000-0002-6931-7191">ORCID</a>
	&middot;
	<a href="https://scholar.google.com/citations?user=A2ImcaUAAAAJ&hl=en">Google Scholar</a>
</p>

{#if data.error}
	<p class="error">{data.error}</p>
{/if}

{#if firstAuthor.length > 0}
	<h2>First Author</h2>
	{#each firstAuthor as pub}
		<div class="pub">
			<span class="pub-title">
				{#if pub.url}
					<a href={pub.url}>{pub.title}</a>
				{:else}
					{pub.title}
				{/if}
			</span>
			{#if pub.authors.length > 0}
				<span class="pub-authors">{@html formatAuthors(pub.authors)}</span>
			{/if}
			<span class="pub-meta">
				{#if pub.journal}
					<span class="pub-journal">{pub.journal}</span>
				{/if}
				{#if pub.year}
					<span class="pub-year">({pub.year})</span>
				{/if}
				{#if pub.type === 'preprint'}
					<span class="pub-badge">preprint</span>
				{/if}
			</span>
		</div>
	{/each}
{/if}

{#if other.length > 0}
	<h2>Contributing Author</h2>
	{#each other as pub}
		<div class="pub">
			<span class="pub-title">
				{#if pub.url}
					<a href={pub.url}>{pub.title}</a>
				{:else}
					{pub.title}
				{/if}
			</span>
			{#if pub.authors.length > 0}
				<span class="pub-authors">{@html formatAuthors(pub.authors)}</span>
			{/if}
			<span class="pub-meta">
				{#if pub.journal}
					<span class="pub-journal">{pub.journal}</span>
				{/if}
				{#if pub.year}
					<span class="pub-year">({pub.year})</span>
				{/if}
				{#if pub.type === 'preprint'}
					<span class="pub-badge">preprint</span>
				{/if}
			</span>
		</div>
	{/each}
{/if}

<style>
	.pub {
		margin-bottom: var(--space-4);
		padding-bottom: var(--space-3);
		border-bottom: 1px solid var(--rule);
	}

	.pub:last-child {
		border-bottom: none;
	}

	.pub-title {
		display: block;
		font-family: var(--font-display);
		font-weight: 500;
		font-size: 1.05rem;
		line-height: 1.35;
	}

	.pub-title a {
		color: var(--ink);
		text-decoration: none;
	}

	.pub-title a:hover {
		color: var(--signal);
	}

	.pub-authors {
		display: block;
		margin-top: 0.3rem;
		font-size: 0.9rem;
		color: var(--ink-soft);
		line-height: 1.5;
	}

	.pub-meta {
		display: block;
		margin-top: 0.2rem;
		font-family: var(--font-mono);
		font-size: 0.78rem;
		color: var(--ink-faint);
	}

	.pub-journal {
		font-style: normal;
		color: var(--pine);
	}

	.pub-year {
		margin-left: 0.35rem;
	}

	.pub-badge {
		display: inline-block;
		margin-left: 0.5rem;
		padding: 0.1rem 0.45rem;
		font-family: var(--font-mono);
		font-size: 0.68rem;
		letter-spacing: 0.06em;
		text-transform: uppercase;
		background: var(--sage-tint);
		border-radius: var(--radius);
		color: var(--pine);
	}

	.error {
		color: var(--signal);
	}
</style>
