<script>
	import productImg from '$lib/assets/images/products/product5.jpg';
	import Editable from './Editable.svelte';

	// src/routes/+layout.server.ts -> +layout.svelte
	export let data;
	// console.log(data);

	$: cart_total_price = data.user.cart.reduce((total, item) => total + parseFloat(item.total_list_price, 10), 0).toFixed(2);

	export let form;
</script>
<!-- wishlist -->
<div class="col-span-9 space-y-4">
	<div class="flex items-center bg-gray-500 justify-between border gap-6 p-4 border-gray-200">
		<div class="w-1/3">
			<h2 class="text-white text-xl font-medium uppercase">Total: </h2>
		</div>
		<div class="text-white text-lg font-semibold">${cart_total_price}</div>

		<a href="/checkout"
			class="ml-4 btn btn-accent uppercase btn-lg">Check out</a>
	</div>

	{#each data.user.cart as item (item.product_id)}
	<div class="flex items-center justify-between border gap-4 p-4 pr-8 border-gray-200 rounded h-32">
		<div class="w-28">
			<img src={productImg} alt="product 6">
		</div>
		<div class="w-1/3">
			<h2 class="text-gray-800 text-xl font-medium uppercase">{item.product_name}</h2>
			<!-- <p class="text-gray-500 text-sm">Availability: <span class="text-green-600">In Stock</span></p> -->
		</div>
		<div class="w-1/4 text-primary text-lg font-semibold">${item.total_list_price}</div>

		<Editable
			quantity={item.quantity} 
			productID={item.product_id}
			cartID={item.cart_id}
			{form}
		/>
	</div>
	{/each}	
</div>
<!-- ./wishlist -->

