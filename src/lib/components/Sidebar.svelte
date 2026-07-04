<script>
	import { page } from '$app/stores';

	let { navOpen = false, onClose } = $props();

	const sidebarSections = [
		{
			items: [
				{ text: 'Home', link: '/' },
				{ text: 'Publications', link: '/publications' }
			]
		},
		{
			title: 'Articles',
			items: [{ text: 'The Decline of Fast Food', link: '/articles/reviewbrah' }]
		},
		{
			title: 'Tutorials',
			items: [
				{ text: 'Datamonkey MCP', link: '/tutorials/datamonkey-mcp' },
				{ text: 'Kraken on Galaxy', link: '/tutorials/kraken' }
			]
		},
		{
			title: 'Watching & Reading',
			items: [
				{ text: 'Does the Internet Dream?', link: '/av/does-the-internet-dream' },
				{ text: 'Bubblegum Crisis Goofs', link: '/av/bubblegum-crisis-goofs' },
				{ text: 'Home Videos', link: '/av/home-videos' }
			]
		},
		{
			title: 'Commonplace',
			items: [{ text: 'Quotes', link: '/misc/quotations' }]
		}
	];
</script>

<aside id="site-sidebar" class="sidebar" class:open={navOpen}>
	<nav>
		{#each sidebarSections as section}
			{#if section.title}
				<div class="sidebar-section-title">{section.title}</div>
			{/if}
			{#each section.items as item}
				<a
					href={item.link}
					class="sidebar-link"
					class:active={$page.url.pathname === item.link}
				>
					{item.text}
				</a>
			{/each}
		{/each}

		<div class="sidebar-footer">
			<a href="https://www.stevenweaver.org/cv/" target="_blank" rel="noopener noreferrer">CV ↗</a>
			<a href="https://github.com/stevenweaver" target="_blank" rel="noopener noreferrer">GitHub ↗</a>
			<a
				href="https://www.goodreads.com/user/show/6435692-steven"
				target="_blank"
				rel="noopener noreferrer">Goodreads ↗</a
			>
		</div>
	</nav>
</aside>

<button
	class="scrim"
	class:show={navOpen}
	aria-label="Close navigation"
	tabindex={navOpen ? 0 : -1}
	onclick={onClose}
></button>

<style>
	.sidebar {
		width: var(--sidebar-w);
		position: fixed;
		top: 3.9rem;
		left: 0;
		bottom: 0;
		overflow-y: auto;
		background-color: var(--paper);
		border-right: 1px solid var(--rule);
		padding: var(--space-6) 0 var(--space-8);
		z-index: 20;
	}

	nav {
		display: flex;
		flex-direction: column;
	}

	.sidebar-section-title {
		font-family: var(--font-mono);
		padding: var(--space-6) var(--space-6) var(--space-2);
		font-size: 0.68rem;
		text-transform: uppercase;
		letter-spacing: 0.14em;
		font-weight: 400;
		color: var(--ink-faint);
	}

	.sidebar-link {
		display: block;
		padding: var(--space-2) var(--space-6);
		color: var(--ink-soft);
		text-decoration: none;
		font-family: var(--font-display);
		font-size: 0.95rem;
		font-weight: 400;
		border-left: 2px solid transparent;
		transition:
			color 0.15s ease,
			background-color 0.15s ease,
			border-color 0.15s ease;
	}

	.sidebar-link:hover {
		color: var(--pine);
		background-color: var(--sage-tint);
	}

	.sidebar-link.active {
		border-left-color: var(--signal);
		color: var(--pine);
		font-weight: 500;
		background-color: color-mix(in srgb, var(--sage-tint) 60%, transparent);
	}

	.sidebar-footer {
		margin-top: var(--space-8);
		padding: var(--space-6) var(--space-6) 0;
		border-top: 1px solid var(--rule);
		display: flex;
		flex-direction: column;
		gap: var(--space-2);
	}

	.sidebar-footer a {
		font-family: var(--font-mono);
		font-size: 0.78rem;
		letter-spacing: 0.02em;
		color: var(--ink-faint);
		text-decoration: none;
	}

	.sidebar-footer a:hover {
		color: var(--signal);
	}

	/* Scrim — only meaningful on mobile when the drawer is open */
	.scrim {
		display: none;
		position: fixed;
		inset: 0;
		z-index: 15;
		border: none;
		background: color-mix(in srgb, var(--ink) 32%, transparent);
		opacity: 0;
		transition: opacity 0.22s ease;
		cursor: pointer;
	}

	@media (max-width: 900px) {
		.sidebar {
			top: 0;
			padding-top: 4.5rem;
			transform: translateX(-100%);
			visibility: hidden;
			transition:
				transform 0.24s ease,
				visibility 0.24s ease;
			box-shadow: 2px 0 24px color-mix(in srgb, var(--ink) 12%, transparent);
			width: min(20rem, 82vw);
		}

		.sidebar.open {
			transform: translateX(0);
			visibility: visible;
		}

		.scrim.show {
			display: block;
			opacity: 1;
		}
	}
</style>
