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
		margin-bottom: 1rem;
		padding-bottom: 0.75rem;
		border-bottom: 1px solid #eaecef;
	}

	.pub:last-child {
		border-bottom: none;
	}

	.pub-title {
		display: block;
		font-weight: 500;
		line-height: 1.4;
	}

	.pub-title a {
		color: #3eaf7c;
	}

	.pub-title a:hover {
		text-decoration: underline;
	}

	.pub-authors {
		display: block;
		margin-top: 0.2rem;
		font-size: 0.85em;
		color: #555;
		line-height: 1.5;
	}

	.pub-meta {
		display: block;
		margin-top: 0.2rem;
		font-size: 0.9em;
		color: #666;
	}

	.pub-journal {
		font-style: italic;
	}

	.pub-year {
		margin-left: 0.25rem;
	}

	.pub-badge {
		display: inline-block;
		margin-left: 0.5rem;
		padding: 0.1rem 0.4rem;
		font-size: 0.75em;
		background: #f0f0f0;
		border-radius: 3px;
		color: #888;
	}

	.error {
		color: #c00;
	}
</style>
