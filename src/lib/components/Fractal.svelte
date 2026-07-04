<script>
	import { onMount } from 'svelte';

	let {
		seed = 31,
		size = 600,
		interactive = false,
		opacity = 1,
		label = 'Generative tree — every one grows from the same branching rule'
	} = $props();

	let canvas;
	let animationId;
	let currentSeed = $state(seed);
	let lineColor = '#2c4a3b';
	const fruitHue = 11; // vermilion

	class Random {
		constructor(seed) {
			this.seed = seed;
			this.initialSeed = seed;
		}
		reset() {
			this.seed = this.initialSeed;
		}
		random() {
			let x = Math.sin(this.seed) * 10000;
			this.seed++;
			return x - Math.floor(x);
		}
		gaussian(mean, std) {
			let rand = 0;
			for (let i = 0; i < 6; i += 1) rand += this.random();
			return ((rand - 3) / 6) * std + mean;
		}
		unif(a, b) {
			return this.random() * (b - a) + a;
		}
	}

	// Munari's rule, varied per seed: same branching logic, a different tree each time.
	function buildConfig(seedValue) {
		const r = new Random(seedValue + 0.5);
		r.random();
		r.random();
		return {
			maxDepth: 12,
			scale: 100,
			lineWidth: 22,
			lineWidthFalloff: 1.6,
			lengthVar: 3.8,
			branchiness: 0.038 + r.random() * 0.014, // 0.038–0.052
			curveAmount: 0.13 + r.random() * 0.14, //   0.13–0.27
			upAmount: 0.0095,
			spread: 0.33 + r.random() * 0.13 //          0.33–0.46
		};
	}

	// `head` is the growth frontier measured in depth-units. A branch at depth d
	// extends while head sweeps from (d-1) to d; fruit blooms as it passes the tip.
	// RNG is consumed identically every frame (regardless of head) so the tree's
	// shape is fixed and it simply grows outward rather than reshuffling.
	function branch(x, y, angle, depth, random, config, ctx, head) {
		if (depth > config.maxDepth) return;

		const reveal = Math.max(0, Math.min(1, head - (depth - 1)));
		const grown = reveal >= 1;

		const length = (config.scale / depth) * random.gaussian(1, config.lengthVar);
		const segments = length / 10;
		const drawnFull = Math.floor(segments * reveal);
		const frac = segments * reveal - drawnFull;

		const baseWidth = config.lineWidth / Math.pow(config.lineWidthFalloff, depth);
		ctx.lineWidth = baseWidth;
		ctx.strokeStyle = lineColor;
		ctx.lineCap = 'round';

		let curveDir = random.unif(0, 1) < 0.5 ? -1 : 1;
		let curve = config.curveAmount * curveDir;
		if (depth == 1) curve *= 0.25;

		for (let i = 0; i < segments; i++) {
			const up = angle < -Math.PI / 2 ? Math.PI / 2 - angle : angle - Math.PI / 2;
			const nextAngle = angle + curve + up * config.upAmount * depth;
			const nx = x + 10 * Math.cos(angle);
			const ny = y + 10 * Math.sin(angle);

			if (grown || i < drawnFull) {
				ctx.beginPath();
				ctx.moveTo(x, y);
				ctx.lineTo(nx, ny);
				ctx.stroke();
			} else if (i === drawnFull && frac > 0) {
				ctx.beginPath();
				ctx.moveTo(x, y);
				ctx.lineTo(x + (nx - x) * frac, y + (ny - y) * frac);
				ctx.stroke();
			}

			// Always attempt the mid-branch child (keeps RNG deterministic); the
			// child gates its own drawing by its own reveal.
			if (random.unif(0, 1) < config.branchiness) {
				const d2 = random.unif(0, 1) < 0.5 ? -1 : 1;
				branch(nx, ny, nextAngle + (config.spread / 2) * d2, depth + 1, random, config, ctx, head);
				ctx.lineWidth = baseWidth;
				ctx.strokeStyle = lineColor;
			}

			x = nx;
			y = ny;
			angle = nextAngle;
		}

		const dir = random.unif(0, 1) < 0.5 ? -1 : 1;
		branch(x, y, angle + config.spread * dir, depth + 1, random, config, ctx, head);
		branch(x, y, angle + config.spread * -dir, depth + 1, random, config, ctx, head);

		// Fruit — values drawn unconditionally (determinism); rendered as a bloom.
		if (depth >= config.maxDepth - 2) {
			const h = fruitHue + random.unif(-4, 8);
			const s = random.unif(70, 84);
			const l = random.unif(48, 60);
			const r0 = random.gaussian(4, 1);
			const bloom = Math.max(0, Math.min(1, head - depth - 0.5));
			if (bloom > 0) {
				ctx.globalAlpha = bloom;
				ctx.fillStyle = `hsl(${h}, ${s}%, ${l}%)`;
				ctx.beginPath();
				ctx.arc(x, y, r0 * (0.45 + 0.55 * bloom), 0, Math.PI * 2);
				ctx.fill();
				ctx.globalAlpha = 1;
			}
		}
	}

	// smootherstep: gentle acceleration in, gentle settle out — no hard start/stop.
	const smoother = (t) => t * t * t * (t * (t * 6 - 15) + 10);

	// A no-op "context" that records the extent of every stroke/fruit, so we can
	// measure the finished tree and scale it to always fit the canvas.
	function makeMeasurer() {
		const b = { minX: Infinity, minY: Infinity, maxX: -Infinity, maxY: -Infinity };
		const track = (x, y, pad = 0) => {
			if (x - pad < b.minX) b.minX = x - pad;
			if (y - pad < b.minY) b.minY = y - pad;
			if (x + pad > b.maxX) b.maxX = x + pad;
			if (y + pad > b.maxY) b.maxY = y + pad;
		};
		return {
			bounds: b,
			beginPath() {},
			closePath() {},
			stroke() {},
			fill() {},
			moveTo(x, y) {
				track(x, y);
			},
			lineTo(x, y) {
				track(x, y);
			},
			arc(x, y, r) {
				track(x, y, r);
			},
			set lineWidth(_) {},
			set strokeStyle(_) {},
			set lineCap(_) {},
			set fillStyle(_) {},
			set globalAlpha(_) {}
		};
	}

	function run() {
		if (!canvas) return;
		if (animationId) cancelAnimationFrame(animationId);

		// Retina-crisp: back the 600-unit drawing space with device pixels.
		// Only resize when it actually changes — setting width/height clears the
		// canvas, and we don't want a reseed to blank the old tree before drawing.
		const dpr = Math.min(typeof window !== 'undefined' ? window.devicePixelRatio || 1 : 1, 2);
		const backing = Math.round(size * dpr);
		if (canvas.width !== backing) {
			canvas.width = backing;
			canvas.height = backing;
		}
		canvas.style.width = size + 'px';
		canvas.style.height = size + 'px';

		const ctx = canvas.getContext('2d');
		const scale = backing / 600;

		const config = buildConfig(currentSeed);
		const drawRandom = new Random(currentSeed);
		const start_angle = -Math.PI / 2 + drawRandom.gaussian(0, 0.5);
		const fullHead = config.maxDepth + 2;

		// Measure the finished tree, then fit it: horizontally centered, base planted
		// at the bottom margin, scaled down if it would otherwise overgrow the box.
		const measurer = makeMeasurer();
		const measureRandom = new Random(currentSeed);
		measureRandom.gaussian(0, 0.5);
		branch(300, 600, start_angle, 1, measureRandom, config, measurer, fullHead);
		const bb = measurer.bounds;
		const margin = 40;
		const avail = 600 - margin * 2;
		const bw = Math.max(1, bb.maxX - bb.minX);
		const bh = Math.max(1, bb.maxY - bb.minY);
		const fit = Math.min(avail / bw, avail / bh, 1.3);
		const offX = margin + (avail - bw * fit) / 2 - bb.minX * fit;
		const offY = 600 - margin - bb.maxY * fit;

		const reduce =
			typeof window !== 'undefined' &&
			window.matchMedia('(prefers-reduced-motion: reduce)').matches;

		const growMs = 1650;
		let t0 = null;

		function drawAt(head) {
			ctx.setTransform(1, 0, 0, 1, 0, 0);
			ctx.clearRect(0, 0, canvas.width, canvas.height);
			ctx.setTransform(scale, 0, 0, scale, 0, 0);
			ctx.translate(offX, offY);
			ctx.scale(fit, fit);
			drawRandom.reset();
			drawRandom.gaussian(0, 0.5); // keep RNG aligned with the start-angle draw
			branch(300, 600, start_angle, 1, drawRandom, config, ctx, head);
		}

		if (reduce) {
			drawAt(fullHead); // no growth animation for reduced-motion; the tree simply is
			return;
		}

		function frame(time) {
			if (t0 === null) t0 = time;
			const raw = Math.min(1, (time - t0) / growMs);
			drawAt(smoother(raw) * fullHead);
			if (raw < 1) animationId = requestAnimationFrame(frame);
			else animationId = null; // grown — then rest, completely still
		}
		animationId = requestAnimationFrame(frame);
	}

	function reseed() {
		if (!interactive) return;
		currentSeed = 1 + Math.floor(Math.random() * 995);
		run();
	}

	onMount(() => {
		const cs = getComputedStyle(document.documentElement);
		lineColor = cs.getPropertyValue('--pine').trim() || lineColor;
		run();
		return () => {
			if (animationId) cancelAnimationFrame(animationId);
		};
	});
</script>

{#if interactive}
	<button class="fractal-btn" style="opacity:{opacity}" onclick={reseed} aria-label={label}>
		<canvas bind:this={canvas}></canvas>
	</button>
{:else}
	<canvas bind:this={canvas} role="img" aria-label={label} style="opacity:{opacity}"></canvas>
{/if}

<style>
	canvas {
		max-width: 100%;
		height: auto;
		display: block;
	}

	.fractal-btn {
		background: none;
		border: none;
		padding: 0;
		margin: 0;
		cursor: pointer;
		display: block;
		max-width: 100%;
		border-radius: var(--radius-lg);
		transition: transform 0.4s cubic-bezier(0.22, 1, 0.36, 1);
	}

	/* A whisper of an affordance — no words needed. */
	.fractal-btn:hover {
		transform: translateY(-2px);
	}

	.fractal-btn:active {
		transform: translateY(0);
	}

	@media (prefers-reduced-motion: reduce) {
		.fractal-btn {
			transition: none;
		}
	}
</style>
