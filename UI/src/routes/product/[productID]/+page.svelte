<script lang='ts'>
	import CartIcon from '$lib/icons/cart.svg?component';
	import toast from 'svelte-french-toast';
	import { enhance } from '$app/forms';

	import Counter from '$lib/Counter.svelte';
	let count;

	// Connect to +page.server.ts
	export let data;
	// console.log(data);

	const product = data.info;
	$: maildata = data?.user?.info.email;
	$: usermail = maildata ? maildata : '';

	let selectedWarehouse = data.warehouses[0];

	// Imgs
	import img1 from '$lib/assets/images/products/product1.jpg'
	import img2 from '$lib/assets/images/products/product2.jpg'
	import img3 from '$lib/assets/images/products/product3.jpg'
	import img4 from '$lib/assets/images/products/product4.jpg'
	import img5 from '$lib/assets/images/products/product5.jpg'
	import img6 from '$lib/assets/images/products/product6.jpg'

	const imgList = [img1, img2, img3, img4, img5, img6];

	function getImage(id){
		const imgId = id%6;
		return imgList[imgId];
	}

	const selected = getImage(product.product_id);

	// Dealing with add to cart
	export let form;

	$: notify(form?.addcart);
	function notify(changed) {
		if (form?.addcart === true) {
			toast.success("Added to cart");	
		}
		if (form?.errmsg) {
			toast.error(form.errmsg);
		}
	}


</script>

<!-- product-detail -->
<div class="container grid grid-cols-2 gap-6 mx-auto p-8">
	<div>
		<img src={getImage(product.product_id)} alt="product" class="w-full">
		<div class="grid grid-cols-5 gap-4 mt-4">
			<img src={getImage(product.product_id+1)} alt="product2"
				class="w-full cursor-pointer border border-primary">
			<img src={getImage(product.product_id+2)} alt="product2" class="w-full cursor-pointer border">
			<img src={getImage(product.product_id+3)} alt="product2" class="w-full cursor-pointer border">
			<img src={getImage(product.product_id+4)} alt="product2" class="w-full cursor-pointer border">
			<img src={getImage(product.product_id+5)} alt="product2" class="w-full cursor-pointer border">
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
			<Counter bind:count />
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

		<form method="POST" use:enhance
			class="mt-6 flex gap-3 border-b border-gray-200 pb-5 pt-5">

			<input type="hidden" name="email" value={usermail} />
			<input type="hidden" name="quantity" value={count} />
			<input type="hidden" name="productID" value={data?.info.product_id} />

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