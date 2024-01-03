<script>
	export let count = 1;
	export let disabled = false;
	function increase(){
		count +=1;
	}
	function decrease(){
		count===0 ? 0:count-=1;
	}
</script>

<div class="flex border border-primary divide-x divide-gray-300 w-max">
	{#if !disabled}
		<button class="square text-xl cursor-pointer select-none" on:click={decrease} >-</button>
	{/if}
	<div class="square text-base">{count}</div>
	{#if !disabled}
		<button class="square text-xl cursor-pointer select-none" on:click={increase}>+</button>
	{/if}
</div>

<style lang='postcss'>
	.square {
		@apply h-8 w-8 flex items-center justify-center;
	}
</style>