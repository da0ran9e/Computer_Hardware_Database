<script>
	import productImg from '$lib/assets/images/products/product5.jpg';
	import Counter from '$lib/Counter.svelte';

	// src/routes/+layout.server.ts -> +layout.svelte
	export let data;
	console.log(data);

	let cart_total_price = data.user.cart.reduce((total, item) => total + parseFloat(item.total_list_price, 10), 0);

	let editable = false;
</script>
<!-- wishlist -->
<div class="col-span-9 space-y-4">
	<div class="flex items-center bg-gray-500 justify-between border gap-6 p-4 border-gray-200">
		<div class="w-1/3">
			<h2 class="text-white text-xl font-medium uppercase">Total: </h2>
		</div>
		<div class="text-white text-lg font-semibold">${cart_total_price}</div>

		<div class="w-1/4 cursor-pointer hover:text-primary">
			<i class="fa-solid fa-trash"></i>
		</div>

		{#if editable}
			<button class="btn btn-accent font-roboto font-medium"
				on:click={() => editable = false}>Save</button>
		{:else}
			<button class="btn btn-primary hover:bg-accent font-roboto font-medium"
				on:click={() => editable = true}>Edit</button>
		{/if}

		<a href="/checkout"
			class="ml-4 btn btn-accent uppercase btn-lg">Check out</a>
	</div>

	{#each data.user.cart as item (item.product_id)}
	<div class="flex items-center justify-between border gap-6 p-4 pr-8 border-gray-200 rounded">
		<div class="w-28">
			<img src={productImg} alt="product 6" class="w-full">
		</div>
		<div class="w-1/3">
			<h2 class="text-gray-800 text-xl font-medium uppercase">{item.product_name}</h2>
			<!-- <p class="text-gray-500 text-sm">Availability: <span class="text-green-600">In Stock</span></p> -->
		</div>
		<div class="text-primary text-lg font-semibold">${item.total_list_price}</div>
		<Counter count={item.quantity} />

		{#if editable}
			<div class="btn btn-ghost text-error">
				<span class="icon trash-icon "></span>
			</div>
		{/if}
	</div>
	{/each}	
</div>
<!-- ./wishlist -->

<style>
	.icon {
		mask-size: contain;
		width: 2rem;
		height: 2rem;
		background-color: currentColor;
	}
	.trash-icon {
		mask-image: url($lib/icons/trash.svg);
	}
</style>