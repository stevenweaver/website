<template>
		<canvas id="canvas" width="600" height="600"></canvas>
</template>

<script>

var _ = require("underscore");

export default {
  mounted () {
		this.renderFractal();
  },
  methods: {
    renderFractal() {

			let config = {
				maxDepth: 12,
				scale:  100,
				lineWidth:  22,
				lineWidthFalloff: 1.6,
				lengthVar: 3.8,
				branchiness: .044,
				curveAmount: .2,
				upAmount: .0095,
				spread: .4,
				seed: 31
			}

			let canvas = document.getElementById('canvas');
			let ctx = canvas.getContext('2d');
			let random = new this.Random(config.seed);
			let start_angle = -1 * (Math.PI/2) + random.gaussian(0,.5);
			let start = Date.now();

			this.fractalComputation(300, 600, start_angle, 1, random, config, ctx);

			return ctx.canvas;

    },

		Random(seed) {
		 this.seed = seed
		 this.random = function(){
				let x = Math.sin(this.seed) * 10000
				this.seed++
				return x - Math.floor(x)
			}
			
			this.gaussian = function(mean, std) {
				var rand = 0;
				for (var i = 0; i < 6; i += 1) {
					rand += this.random();
				}

					return ((rand - 3)/6) * std + mean;
				}
			
			this.unif = function(a,b){
				return this.random() * (b-a) + a
			}
		},

		fractalComputation(x,y,angle, depth, random,config,ctx) {

				if (depth >= config.maxDepth){return}
			 
				let _x = x
				let _y = y
				let _angle = angle
				let length = (config.scale/depth) * random.gaussian(1,config.lengthVar)
				let segments = length/10
				
				ctx.lineWidth = config.lineWidth/(Math.pow(config.lineWidthFalloff,depth))
				ctx.strokeStyle = "rgb(60,60,60)"
				ctx.lineCap = "round"
																			
				let curve_dir = (random.unif(0,1) < .5)?-1:1
				let curve = config.curveAmount * curve_dir 
				if (depth == 1) {curve *= .25}
				
				for(let i = 0; i < segments; i++){
					
					let up =  (angle < -Math.PI/2)?  Math.PI/2 - angle : angle - Math.PI/2 
					
				 _angle += curve + (up * config.upAmount * depth)  
					_x = x + 10 * Math.cos(angle)
					_y = y + 10 * Math.sin(angle)
					
			 
					ctx.beginPath()
					ctx.moveTo(x,y)
					ctx.lineTo(_x,_y)
					ctx.stroke()
					ctx.closePath()
					
					x = _x
					y = _y
					angle = _angle
				
					if (random.unif(0,1) < config.branchiness){
						let dir = (random.unif(0,1) < .5)?-1:1
						this.fractalComputation(x,y,angle + (config.spread/2 * dir), depth + 1, random,config,ctx)
						ctx.lineWidth = config.lineWidth/(Math.pow(config.lineWidthFalloff,depth))
					} 
				}
				
				let dir = (random.unif(0,1) < .5)?-1:1
				this.fractalComputation(x,y,angle + (config.spread * dir), depth + 1, random,config,ctx)
				this.fractalComputation(x,y,angle + (config.spread * -dir), depth + 1, random,config,ctx)
																			
				if (depth >= config.maxDepth - 2){
					
					let h = random.unif(160,170)
					let s = random.unif(65,75)
					let l = random.unif(60,70)
					ctx.fillStyle = `hsl(${h}, ${s}%, ${l}%)`
					
					let r = random.gaussian(4,1)
					ctx.beginPath()
					ctx.arc(x,y,r,0, Math.PI *  2)
					ctx.fill()
			 }
		}
  }
}

</script>

<style>
#canvas {
	position: fixed;
	opacity : .2;
	right: 0;
}
</style>

