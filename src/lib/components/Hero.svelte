<script>
	import Fractal from './Fractal.svelte';

	const software = [
		{
			name: 'Datamonkey',
			link: 'https://www.datamonkey.org',
			desc: 'A web application for detecting natural selection and other evolutionary processes in gene sequences.',
			usedBy: 'Supported by the NIH and NSF.'
		},
		{
			name: 'HyPhy',
			link: 'https://hyphy.org',
			desc: 'An open-source platform for phylogenetic hypothesis testing, and the analysis engine behind Datamonkey.',
			usedBy: 'Open source, written in C++.'
		},
		{
			name: 'HIV-TRACE',
			link: 'https://github.com/veg/hivtrace',
			desc: 'Reconstructs genetic-distance transmission networks for molecular epidemiology.',
			usedBy: 'Used by the U.S. CDC for HIV cluster detection and response.'
		},
		{
			name: 'phylotree.js',
			link: 'https://github.com/veg/phylotree.js',
			desc: 'A JavaScript library for interactive visualization of phylogenetic trees.',
			usedBy: 'Open source, embedded in tools across the field.'
		}
	];

	const selectedWorks = [
		{
			text: 'Publications',
			link: '/publications',
			desc: 'Peer-reviewed work in phylogenetics & molecular epidemiology'
		},
		{
			text: 'The Decline of Fast Food',
			link: '/articles/reviewbrah',
			desc: '700+ of ReviewBrah\'s fast-food ratings, collected and analyzed'
		},
		{
			text: 'Does the Internet Dream?',
			link: '/av/does-the-internet-dream',
			desc: 'An essay'
		},
		{
			text: 'Datamonkey MCP',
			link: '/tutorials/datamonkey-mcp',
			desc: 'Driving a phylogenetics server from an AI agent'
		}
	];
</script>

<section class="hero">
	<div class="hero-copy">
		<p class="eyebrow">Institute for Genomics &amp; Evolutionary Medicine · Temple University</p>
		<h1>Steven Weaver</h1>
		<p class="lead">
			I build systems that turn genomic data into research and public-health tools. Off the clock,
			I point the same curiosity at fast food, old anime, and books.
		</p>
		<p class="proof">
			Software used by the U.S. Centers for Disease Control and Prevention for HIV molecular
			surveillance. Research published in Nature, Cell, and Science Translational Medicine.
		</p>
	</div>

	<div class="hero-tree">
		<Fractal seed={31} size={360} interactive={true} opacity={0.95} />
	</div>
</section>

<section class="software" aria-label="Software">
	<p class="eyebrow section-label">Software</p>
	<div class="software-grid">
		{#each software as tool}
			<a class="sw-card" href={tool.link} target="_blank" rel="noopener noreferrer">
				<span class="sw-name">{tool.name}<span class="sw-ext" aria-hidden="true">↗</span></span>
				<span class="sw-desc">{tool.desc}</span>
				<span class="sw-used">{tool.usedBy}</span>
			</a>
		{/each}
	</div>
</section>

<nav class="start-here" aria-label="Selected works">
	<p class="eyebrow section-label">Selected works</p>
	<ul>
		{#each selectedWorks as item}
			<li>
				<a href={item.link}>
					<span class="sh-title">{item.text}</span>
					<span class="sh-desc">{item.desc}</span>
					<span class="sh-arrow" aria-hidden="true">→</span>
				</a>
			</li>
		{/each}
	</ul>
</nav>

<style>
	.hero {
		display: grid;
		grid-template-columns: 1fr auto;
		gap: var(--space-8);
		align-items: center;
		margin-bottom: var(--space-12);
	}

	.hero-copy {
		max-width: 34rem;
	}

	h1 {
		margin: var(--space-3) 0 var(--space-4);
	}

	.lead {
		font-size: 1.2rem;
		line-height: 1.55;
		color: var(--ink-soft);
	}

	.proof {
		margin-top: var(--space-4);
		padding-top: var(--space-4);
		border-top: 1px solid var(--rule);
		font-family: var(--font-mono);
		font-size: 0.76rem;
		line-height: 1.6;
		letter-spacing: 0.01em;
		color: var(--ink-faint);
		max-width: 30rem;
	}

	.hero-tree {
		display: flex;
		flex-direction: column;
		align-items: center;
	}

	.section-label {
		margin-bottom: var(--space-4);
	}

	/* Software — the systems lead */
	.software {
		margin: var(--space-8) 0 var(--space-12);
	}

	.software-grid {
		display: grid;
		grid-template-columns: 1fr 1fr;
		gap: var(--space-4);
	}

	.sw-card {
		display: flex;
		flex-direction: column;
		gap: var(--space-2);
		padding: var(--space-6);
		border: 1px solid var(--rule);
		border-radius: var(--radius-lg);
		text-decoration: none;
		background: var(--paper);
		transition:
			border-color 0.15s ease,
			background-color 0.15s ease,
			transform 0.15s ease;
	}

	.sw-card:hover {
		border-color: var(--sage);
		background: color-mix(in srgb, var(--sage-tint) 45%, transparent);
		transform: translateY(-2px);
	}

	.sw-name {
		font-family: var(--font-display);
		font-weight: 600;
		font-size: 1.15rem;
		color: var(--ink);
		display: flex;
		align-items: baseline;
		gap: var(--space-2);
	}

	.sw-ext {
		font-family: var(--font-mono);
		font-size: 0.85rem;
		color: var(--sage);
		transition: color 0.15s ease;
	}

	.sw-card:hover .sw-name {
		color: var(--pine);
	}

	.sw-card:hover .sw-ext {
		color: var(--signal);
	}

	.sw-desc {
		font-family: var(--font-body);
		font-size: 0.98rem;
		line-height: 1.5;
		color: var(--ink-soft);
	}

	.sw-used {
		margin-top: var(--space-1);
		font-family: var(--font-mono);
		font-size: 0.72rem;
		letter-spacing: 0.02em;
		color: var(--ink-faint);
	}

	/* Selected works — personal, present but below the software */
	.start-here {
		margin: var(--space-8) 0 var(--space-12);
	}

	.start-here ul {
		list-style: none;
		border-top: 1px solid var(--rule);
	}

	.start-here li {
		border-bottom: 1px solid var(--rule);
	}

	.start-here a {
		display: grid;
		grid-template-columns: 1fr auto;
		grid-template-areas:
			'title arrow'
			'desc arrow';
		align-items: center;
		gap: 0 var(--space-4);
		padding: var(--space-4) var(--space-2);
		text-decoration: none;
		transition: background-color 0.15s ease;
	}

	.start-here a:hover {
		background-color: var(--sage-tint);
	}

	.sh-title {
		grid-area: title;
		font-family: var(--font-display);
		font-weight: 500;
		font-size: 1.1rem;
		color: var(--ink);
	}

	.start-here a:hover .sh-title {
		color: var(--pine);
	}

	.sh-desc {
		grid-area: desc;
		font-family: var(--font-body);
		font-size: 0.95rem;
		color: var(--ink-faint);
	}

	.sh-arrow {
		grid-area: arrow;
		font-family: var(--font-mono);
		color: var(--sage);
		font-size: 1.1rem;
		transition:
			transform 0.15s ease,
			color 0.15s ease;
	}

	.start-here a:hover .sh-arrow {
		color: var(--signal);
		transform: translateX(4px);
	}

	@media (max-width: 720px) {
		.hero {
			grid-template-columns: 1fr;
			gap: var(--space-4);
		}

		.hero-tree {
			order: -1;
		}

		.software-grid {
			grid-template-columns: 1fr;
		}
	}
</style>
