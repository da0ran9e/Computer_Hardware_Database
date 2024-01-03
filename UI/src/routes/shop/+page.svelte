<script lang='ts'>
	import SidebarFilter from './SidebarFilter.svelte';
	import { enhance } from '$app/forms';

	// Connect to +page.server.ts
	// load() -> return data
	export let data;

	$: allItems = data.items;
	// $: console.log(selectedCategories)
	// Testing

	function sortProducts(e) {
		if (e.target.value == "price-low-to-high") {
			allItems = data.items.sort((a, b) => a.standard_cost - b.standard_cost);
		} else if (e.target.value == "price-high-to-low") {
			allItems = data.items.sort((a, b) => b.standard_cost - a.standard_cost);
		} else {
			allItems = data.items;
		}
	}

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

	// Add to cart part
	$: maildata = data?.user?.info.email;
	$: usermail = maildata ? maildata : '';
	let addCartProduct;
</script>

<form id="add2cart" method="POST" use:enhance>
	<input type="hidden" name="email" value={usermail} />
	<input type="hidden" name="quantity" value="1" />
	<input type="hidden" name="productID" value={addCartProduct} />
</form>

		<!-- breadcrumb -->
		<div class="container py-4 flex items-center gap-3">
				<a href="../index.html" class="text-primary text-base">
						<i class="fa-solid fa-house"></i>
				</a>
				<span class="text-sm text-gray-400">
						<i class="fa-solid fa-chevron-right"></i>
				</span>
				<p class="text-gray-600 font-medium">Shop</p>
		</div>
		<!-- ./breadcrumb -->

<!-- shop wrapper -->
<div class="container grid md:grid-cols-4 grid-cols-2 gap-6 pt-4 pb-16 items-start mx-auto">

	<SidebarFilter allCats={data.cat}/>

	<!-- products -->
	<div class="col-span-3">
		<div class="flex items-center mb-4">
			<select name="sort" id="sort" on:change={sortProducts}
				class="w-44 text-sm text-gray-600 py-3 px-4 border-gray-300 shadow-sm rounded focus:ring-primary focus:border-primary">
				<option value="">Default sorting</option>
				<option value="price-low-to-high">Price low to high</option>
				<option value="price-high-to-low">Price high to low</option>
			</select>

			<div class="flex gap-2 ml-auto">
				<div
					class="border border-primary w-10 h-9 flex items-center justify-center text-white bg-primary rounded cursor-pointer">
					<i class="fa-solid fa-grip-vertical"></i>
				</div>
				<div
					class="border border-gray-300 w-10 h-9 flex items-center justify-center text-gray-600 rounded cursor-pointer">
					<i class="fa-solid fa-list"></i>
				</div>
			</div>
		</div>
		<!-- ./products -->
		<div class="grid md:grid-cols-4 grid-cols-2 gap-6">
			{#each allItems as product (product.product_id)}
			<div class="card card-compact shadow-md rounded group">
				<a href={`/product/${product.product_id}`} class="h-full flex flex-col">
					<figure><img src={getImage(product.product_id)} alt="Shoes" /></figure>
					<div class="card-body flex justify-between">
						<h4 class="card-title uppercase group-hover:text-primary transition">
							{product.product_name}
						</h4>
						<div class="md:flex space-x-2 items-baseline justify-end">
							<p class="text-xl grow-0 text-primary font-semibold">${product.standard_cost}</p>
							<p class="text-sm grow-0 text-gray-400 line-through">${product.list_price}</p>
						</div>
					</div>	
				</a>


				<button type="submit" form="add2cart"
					on:click={() => addCartProduct = product.product_id}
					class="block w-full py-2 text-center text-white bg-primary border border-primary rounded-b hover:bg-transparent hover:text-primary transition">
					Add to cart
				</button>
			</div>
			{/each}
		</div> 
		<!-- ./products -->
	</div>


<!-- ./shop wrapper -->
</div>

