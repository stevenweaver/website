<script>
	import Navbar from '$lib/components/Navbar.svelte';
	import Sidebar from '$lib/components/Sidebar.svelte';
	import favicon from '$lib/assets/favicon.svg';
	import '../app.css';

	let { children } = $props();
</script>

<svelte:head>
	<link rel="icon" href={favicon} />
</svelte:head>

<div class="theme-container">
	<Navbar />
	<div class="page-wrapper">
		<Sidebar />
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
		margin-left: 20rem;
		padding: 2rem;
		max-width: 900px;
	}

	@media (max-width: 768px) {
		.page-content {
			margin-left: 0;
		}
	}
</style>
