<script>
	import { page } from '$app/stores';
	import Navbar from '$lib/components/Navbar.svelte';
	import Sidebar from '$lib/components/Sidebar.svelte';
	import favicon from '$lib/assets/favicon.svg';
	import '../app.css';

	// Self-hosted display face (Space Grotesk)
	import '@fontsource/space-grotesk/400.css';
	import '@fontsource/space-grotesk/500.css';
	import '@fontsource/space-grotesk/700.css';
	// Reading serif (Newsreader)
	import '@fontsource/newsreader/400.css';
	import '@fontsource/newsreader/400-italic.css';
	import '@fontsource/newsreader/600.css';
	// Data / utility mono (Space Mono)
	import '@fontsource/space-mono/400.css';
	import '@fontsource/space-mono/700.css';

	let { children } = $props();

	let navOpen = $state(false);

	// Close the mobile drawer whenever the route changes.
	$effect(() => {
		$page.url.pathname;
		navOpen = false;
	});

	const PAGE_TITLES = {
		'/publications': 'Publications',
		'/articles/reviewbrah': 'Review Brah Ratings',
		'/tutorials/datamonkey-mcp': 'Datamonkey MCP',
		'/tutorials/kraken': 'Kraken on Galaxy',
		'/av/does-the-internet-dream': 'Does the Internet Dream?',
		'/av/bubblegum-crisis-goofs': 'Bubblegum Crisis Goofs',
		'/av/home-videos': 'Home Videos',
		'/misc/quotations': 'Quotes'
	};

	const pageTitle = $derived.by(() => {
		const path = $page.url.pathname.replace(/\/+$/, '') || '/';
		if (path === '/') return 'Steven Weaver · Phylogenetics & Systems';
		const label = PAGE_TITLES[path];
		return label ? `${label} · Steven Weaver` : 'Steven Weaver';
	});
</script>

<svelte:head>
	<title>{pageTitle}</title>
	<meta
		name="description"
		content="Steven Weaver builds bioinformatics software for molecular evolution and selection analysis (HyPhy, Datamonkey) and works on the molecular epidemiology of HIV, hepatitis C, and SARS-CoV-2."
	/>
	<link rel="icon" href={favicon} />
</svelte:head>

<div class="theme-container">
	<Navbar {navOpen} onMenuToggle={() => (navOpen = !navOpen)} />
	<div class="page-wrapper">
		<Sidebar {navOpen} onClose={() => (navOpen = false)} />
		<main class="page-content">
			{@render children?.()}
		</main>
	</div>
</div>

<style>
	.theme-container {
		min-height: 100vh;
	}

	.page-wrapper {
		display: flex;
	}

	.page-content {
		flex: 1;
		min-width: 0;
		margin-left: var(--sidebar-w);
		padding: var(--space-12) var(--space-16);
		max-width: calc(var(--content-max) + var(--space-16) * 2);
	}

	@media (max-width: 900px) {
		.page-content {
			margin-left: 0;
			padding: var(--space-8) var(--space-6);
		}
	}
</style>
