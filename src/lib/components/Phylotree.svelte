<script>
	import { onMount } from 'svelte';
	import { Runtime, Inspector } from '@observablehq/notebook-runtime';
	import notebook from 'displaying-phylogenetic-trees-with-phylotree-js';

	let container;

	onMount(() => {
		Runtime.load(notebook, (cell) => {
			if (cell.name == 'phylotree') {
				return new Inspector(container);
			}
		});
	});
</script>

<div class="phylotree-app">
	<div bind:this={container} id="value"></div>
</div>

<style>
	@import 'phylotree/phylotree.css';
</style>
