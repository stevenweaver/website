<template>
	<div className="App">
		<div id="value"></div>
	</div>
</template>

<script>

var _ = require("underscore");
var $ = window.$ = require("jquery");
import {Runtime, Inspector} from "@observablehq/notebook-runtime";
import notebook from "displaying-phylogenetic-trees-with-phylotree-js";

export default {
  mounted () {
    this.loadObservable();
  },
  methods: {
    loadObservable () {
			Runtime.load(notebook, (cell) => {
				console.log(cell.name);
				if (cell.name === undefined) {
					return new Inspector(document.getElementById("value"));
				}
			});
    }
  }
}

</script>

<style>
	@import '../../node_modules/phylotree/phylotree.css'
</style>
