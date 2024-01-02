<script lang='ts'>
	import CartIcon from '$lib/icons/cart.svg?component';
	import toast from 'svelte-french-toast';

	// Connect to +page.server.ts
	export let data;
	// console.log(data);

	const product = data.info;

	let selectedWarehouse;

	let count = 0;
	function increase(){
		count +=1;
	}
	function decrease(){
		count===0 ? 0:count-=1;
	}


	// Dealing with add to cart
	export let form;

	function fillFormData(e) {
		let formData = e.formData;

		formData.append('email', data.user.info.email);
		formData.append('quantity', count);
		formData.append('productID', data.info.product_id);
	}

	if (form?.addcart === true) {
		toast.success("Added to cart");	
	}

	if (form?.errmsg) {
		toast.error(form.errmsg);
	}
</script>

<!-- product-detail -->
<div class="container grid grid-cols-2 gap-6 mx-auto p-8">
	<div>
		<img src="https://daisyui.com/images/stock/photo-1606107557195-0e29a4b5b4aa.jpg" alt="product" class="w-full">
		<div class="grid grid-cols-5 gap-4 mt-4">
			<img src="https://daisyui.com/images/stock/photo-1606107557195-0e29a4b5b4aa.jpg" alt="product2"
				class="w-full cursor-pointer border border-primary">
			<img src="https://daisyui.com/images/stock/photo-1606107557195-0e29a4b5b4aa.jpg" alt="product2" class="w-full cursor-pointer border">
			<img src="https://daisyui.com/images/stock/photo-1606107557195-0e29a4b5b4aa.jpg" alt="product2" class="w-full cursor-pointer border">
			<img src="https://daisyui.com/images/stock/photo-1606107557195-0e29a4b5b4aa.jpg" alt="product2" class="w-full cursor-pointer border">
			<img src="https://daisyui.com/images/stock/photo-1606107557195-0e29a4b5b4aa.jpg" alt="product2" class="w-full cursor-pointer border">
		</div>
	</div>

	<div class="space-y-3">
		<h2 class="text-3xl font-medium uppercase">{product.product_name}</h2>
		<div>
			<p class="space-x-2">
				<span class="font-semibold">Category: </span>
				<span>{product.category_name}</span>
			</p>
			<p class="space-x-2">
				<span class="font-semibold">ID: </span>
				<span>{product.product_id}</span>
			</p>
		</div>

		<div class="md:flex items-baseline mb-1 space-x-2 font-roboto">
			<p class="text-2xl text-primary font-semibold">${product.standard_cost}</p>
			<p class="text-base text-gray-400 line-through">${product.list_price}</p>
		</div>

		<div class="pb-4">
			<p>{product.description}</p>
			<p>{product.description_1}</p>
			<p>{product.description_2}</p>
			<p>{product.description_3}</p>
			<p>{product.description_4}</p>
		</div>
		
		<div>
			<h3 class="text-sm font-semibold uppercase mb-1">Quantity:</h3>
			<div class="flex border border-gray-300 divide-x divide-gray-300 w-max">
				<button on:click={decrease} class="h-8 w-8 text-xl flex items-center justify-center cursor-pointer select-none">-</button>
				<div class="h-8 w-8 text-base flex items-center justify-center">{count}</div>
				<button on:click={increase} class="h-8 w-8 text-xl flex items-center justify-center cursor-pointer select-none">+</button>
			</div>
		</div>
		

		<div>
			<h3 class="text-sm font-semibold uppercase mb-1">Shop: </h3>
			<!-- How to select: https://learn.svelte.dev/tutorial/select-bindings -->
			<select class="select select-bordered w-44"
				bind:value={selectedWarehouse}>

				{#each data.warehouses as wh (wh.warehouse_id)}
					<option value={wh}>
						{wh.warehouse_name}
					</option>
				{/each}
			</select>
		</div>

		<div class="font-semibold space-x-2">
			<span>Availability: </span>
			{#if selectedWarehouse && selectedWarehouse.quantity > 0}
				<span class="text-success">In Stock ({selectedWarehouse.quantity})</span>
			{:else}
				<span class="text-error">Out of Stock</span>
			{/if}
		</div>

		<form method="POST" action="?/add_to_cart"
			on:formdata={fillFormData}
			class="mt-6 flex gap-3 border-b border-gray-200 pb-5 pt-5">
			<button type="submit"
				class="bg-primary border border-primary text-white px-8 py-2 font-medium rounded uppercase flex items-center gap-2 hover:bg-transparent hover:text-primary transition">
				<span class="icon cart-icon"></span> Add to cart
			</button>
<!-- 			<a href="#"
				class="border border-gray-300 px-8 py-2 font-medium rounded uppercase flex items-center gap-2 hover:text-primary transition">
				<i class="fa-solid fa-heart"></i> Wishlist
			</a> -->
		</form>
	</div>
</div>
<!-- ./product-detail -->

<style>
	.icon {
		mask-size: contain;
		width: 1.5rem;
		height: 1.5rem;
		background-color: currentColor;
	}
	.cart-icon {
		mask-image: url($lib/icons/cart.svg);
	}
</style>