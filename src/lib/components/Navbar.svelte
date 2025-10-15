<script>
	const navLinks = [
		{ text: 'Home', link: '/' },
		{ text: 'Github', link: 'https://github.com/stevenweaver' }
	];
</script>

<nav class="navbar">
	<div class="navbar-inner">
		<h1 class="site-title">
			<a href="/" class="site-title-link">Steven Weaver</a>
		</h1>
		<div class="nav-links">
			{#each navLinks as { text, link }}
				<a href={link} class="nav-link">{text}</a>
			{/each}
		</div>
	</div>
</nav>

<style>
	.navbar {
		position: sticky;
		top: 0;
		z-index: 10;
		background-color: #fff;
		border-bottom: 1px solid #eaecef;
		padding: 0.7rem 0 0.7rem 1.5rem;
	}

	.navbar-inner {
		display: flex;
		justify-content: flex-start;
		align-items: center;
		gap: 2rem;
	}

	.site-title {
		font-size: 1.3rem;
		font-weight: 600;
		margin: 0;
		line-height: 1.5;
	}

	.site-title-link {
		color: #2c3e50;
		text-decoration: none;
		cursor: pointer;
	}

	.site-title-link:hover {
		color: #3eaf7c;
	}

	.nav-links {
		display: flex;
		gap: 1.5rem;
		align-items: center;
	}

	.nav-link {
		color: #2c3e50;
		text-decoration: none;
		font-weight: 500;
		line-height: 1.5;
	}

	.nav-link:hover {
		color: #3eaf7c;
	}
</style>
