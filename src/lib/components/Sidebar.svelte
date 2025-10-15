<script>
	import { page } from '$app/stores';

	const sidebarSections = [
		{
			items: [
				{ text: 'Publications', link: '/publications' },
			]
		},
		{
			title: 'Tutorials',
			items: [
				{ text: 'Review Brah Ratings', link: '/tutorials/reviewbrah' },
				{ text: 'Kraken on Galaxy', link: '/tutorials/kraken' }
			]
		},
		{
			title: 'Misc',
			items: [
				{ text: 'Books, Audio & Visual', link: '/av' },
				{ text: 'Quotes', link: '/misc/quotations' }
			]
		}
	];
</script>

<aside class="sidebar">
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
	</nav>
</aside>

<style>
	.sidebar {
		width: 20rem;
		position: fixed;
		top: 3.6rem;
		left: 0;
		bottom: 0;
		overflow-y: auto;
		background-color: #fff;
		border-right: 1px solid #eaecef;
		padding: 1.5rem 0;
	}

	nav {
		display: flex;
		flex-direction: column;
	}

	.sidebar-section-title {
		padding: 1rem 1.5rem 0.5rem;
		font-size: 0.75rem;
		text-transform: uppercase;
		letter-spacing: 0.05em;
		font-weight: 700;
		color: #a0a0a0;
	}

	.sidebar-link {
		display: block;
		padding: 0.5rem 1.5rem;
		color: #2c3e50;
		text-decoration: none;
		border-left: 0.25rem solid transparent;
		transition: all 0.2s ease;
		font-size: 0.95rem;
	}

	.sidebar-link:hover {
		color: #3eaf7c;
		background-color: #f8f9fa;
	}

	.sidebar-link.active {
		border-left-color: #3eaf7c;
		color: #3eaf7c;
		font-weight: 600;
		background-color: #f0fdf4;
	}

	@media (max-width: 768px) {
		.sidebar {
			display: none;
		}
	}
</style>
