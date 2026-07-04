<script>
	let { navOpen = false, onMenuToggle } = $props();
</script>

<nav class="navbar">
	<div class="navbar-inner">
		<a href="/" class="wordmark">
			<span class="wordmark-name">Steven Weaver</span>
			<span class="wordmark-tag">phylogenetics &amp; systems</span>
		</a>

		<button
			class="menu-toggle"
			aria-label={navOpen ? 'Close navigation' : 'Open navigation'}
			aria-expanded={navOpen}
			aria-controls="site-sidebar"
			onclick={onMenuToggle}
		>
			<span class="menu-icon" class:open={navOpen} aria-hidden="true">
				<span></span>
				<span></span>
				<span></span>
			</span>
		</button>
	</div>
</nav>

<style>
	.navbar {
		position: sticky;
		top: 0;
		z-index: 30;
		background-color: color-mix(in srgb, var(--paper) 88%, transparent);
		backdrop-filter: saturate(1.4) blur(8px);
		border-bottom: 1px solid var(--rule);
	}

	.navbar-inner {
		display: flex;
		justify-content: space-between;
		align-items: center;
		gap: var(--space-4);
		padding: var(--space-3) var(--space-6);
	}

	.wordmark {
		display: flex;
		flex-direction: column;
		line-height: 1.05;
		text-decoration: none;
		color: var(--ink);
	}

	.wordmark:hover {
		color: var(--ink);
	}

	.wordmark-name {
		font-family: var(--font-display);
		font-weight: 700;
		font-size: 1.15rem;
		letter-spacing: -0.02em;
	}

	.wordmark:hover .wordmark-name {
		color: var(--pine);
	}

	.wordmark-tag {
		font-family: var(--font-mono);
		font-size: 0.62rem;
		letter-spacing: 0.14em;
		text-transform: uppercase;
		color: var(--ink-faint);
		margin-top: 0.15rem;
	}

	/* Hamburger — hidden on desktop, shown when the sidebar folds away */
	.menu-toggle {
		display: none;
		background: none;
		border: 1px solid var(--rule);
		border-radius: var(--radius);
		width: 2.5rem;
		height: 2.5rem;
		cursor: pointer;
		align-items: center;
		justify-content: center;
		color: var(--ink);
	}

	.menu-toggle:hover {
		border-color: var(--sage);
	}

	.menu-icon {
		display: block;
		width: 20px;
		height: 14px;
		position: relative;
	}

	.menu-icon span {
		position: absolute;
		left: 0;
		height: 2px;
		width: 100%;
		background: currentColor;
		border-radius: 2px;
		transition:
			transform 0.22s ease,
			opacity 0.22s ease,
			top 0.22s ease;
	}

	.menu-icon span:nth-child(1) {
		top: 0;
	}
	.menu-icon span:nth-child(2) {
		top: 6px;
	}
	.menu-icon span:nth-child(3) {
		top: 12px;
	}

	.menu-icon.open span:nth-child(1) {
		top: 6px;
		transform: rotate(45deg);
	}
	.menu-icon.open span:nth-child(2) {
		opacity: 0;
	}
	.menu-icon.open span:nth-child(3) {
		top: 6px;
		transform: rotate(-45deg);
	}

	@media (max-width: 900px) {
		.menu-toggle {
			display: flex;
		}
	}
</style>
