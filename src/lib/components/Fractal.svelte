<script>
	import { onMount } from 'svelte';

	let canvas;
	let animationId;

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
			for (let i = 0; i < 6; i += 1) {
				rand += this.random();
			}
			return ((rand - 3) / 6) * std + mean;
		}

		unif(a, b) {
			return this.random() * (b - a) + a;
		}
	}

	function fractalComputation(x, y, angle, depth, random, config, ctx, time) {
		if (depth >= config.maxDepth) return;

		// Add sway based on depth - deeper branches sway more
		let swayAmount = depth > 5 ? Math.sin(time * 0.0005 + depth * 0.5) * 0.005 * (depth / config.maxDepth) : 0;

		let _x = x;
		let _y = y;
		let _angle = angle;
		let length = (config.scale / depth) * random.gaussian(1, config.lengthVar);
		let segments = length / 10;

		ctx.lineWidth = config.lineWidth / Math.pow(config.lineWidthFalloff, depth);
		ctx.strokeStyle = 'rgb(60,60,60)';
		ctx.lineCap = 'round';

		let curve_dir = random.unif(0, 1) < 0.5 ? -1 : 1;
		let curve = config.curveAmount * curve_dir;
		if (depth == 1) {
			curve *= 0.25;
		}

		for (let i = 0; i < segments; i++) {
			let up = angle < -Math.PI / 2 ? Math.PI / 2 - angle : angle - Math.PI / 2;

			_angle += curve + up * config.upAmount * depth + swayAmount;
			_x = x + 10 * Math.cos(angle);
			_y = y + 10 * Math.sin(angle);

			ctx.beginPath();
			ctx.moveTo(x, y);
			ctx.lineTo(_x, _y);
			ctx.stroke();
			ctx.closePath();

			x = _x;
			y = _y;
			angle = _angle;

			if (random.unif(0, 1) < config.branchiness) {
				let dir = random.unif(0, 1) < 0.5 ? -1 : 1;
				fractalComputation(x, y, angle + (config.spread / 2) * dir, depth + 1, random, config, ctx, time);
				ctx.lineWidth = config.lineWidth / Math.pow(config.lineWidthFalloff, depth);
			}
		}

		let dir = random.unif(0, 1) < 0.5 ? -1 : 1;
		fractalComputation(x, y, angle + config.spread * dir + swayAmount, depth + 1, random, config, ctx, time);
		fractalComputation(x, y, angle + config.spread * -dir - swayAmount, depth + 1, random, config, ctx, time);

		if (depth >= config.maxDepth - 2) {
			let h = random.unif(160, 170);
			let s = random.unif(65, 75);
			let l = random.unif(60, 70);
			ctx.fillStyle = `hsl(${h}, ${s}%, ${l}%)`;

			let r = random.gaussian(4, 1);
			ctx.beginPath();
			ctx.arc(x, y, r, 0, Math.PI * 2);
			ctx.fill();
		}
	}

	function animate() {
		let config = {
			maxDepth: 12,
			scale: 100,
			lineWidth: 22,
			lineWidthFalloff: 1.6,
			lengthVar: 3.8,
			branchiness: 0.044,
			curveAmount: 0.2,
			upAmount: 0.0095,
			spread: 0.4,
			seed: 31
		};

		let ctx = canvas.getContext('2d');
		let random = new Random(config.seed);
		let start_angle = -1 * (Math.PI / 2) + random.gaussian(0, 0.5);

		function draw(time) {
			ctx.clearRect(0, 0, canvas.width, canvas.height);
			random.reset();
			random.gaussian(0, 0.5); // Skip this to match initial angle
			fractalComputation(300, 600, start_angle, 1, random, config, ctx, time);
			animationId = requestAnimationFrame(draw);
		}

		animationId = requestAnimationFrame(draw);
	}

	onMount(() => {
		animate();
		return () => {
			if (animationId) {
				cancelAnimationFrame(animationId);
			}
		};
	});
</script>

<canvas bind:this={canvas} id="canvas" width="600" height="600"></canvas>

<style>
	#canvas {
		position: fixed;
		opacity: 0.2;
		right: 0;
		animation: fadeIn 2s ease-in-out;
	}

	@keyframes fadeIn {
		0% {
			opacity: 0;
		}
		100% {
			opacity: 0.2;
		}
	}
</style>
