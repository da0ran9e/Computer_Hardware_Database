<script lang='ts'>
	// Do something here

	// Connect to +page.server.ts
	// load() -> return data
	export let data;

	let selectedCategories = []
	// $: console.log(selectedCategories)
	// Testing
</script>

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

	<!-- ./sidebar -->
	<div class="col-span-1 bg-white px-4 pb-6 shadow rounded overflow-hiddenb hidden md:block">
		<div class="divide-y divide-gray-200 space-y-5">
			<div class="pt-4">
				<h3 class="text-xl text-gray-800 mb-3 uppercase font-medium">Categories</h3>
				<div class="space-y-2">
					<!-- Each, data.cat from +page.server.ts -->
					<!-- Group checkbox: https://learn.svelte.dev/tutorial/group-inputs -->
					{#each data.cat as category (category.category_id) }
						<div class="flex items-center">
							<input type="checkbox"
								value={category.category_id}
								class="checkbox checkbox-xs rounded-sm"
								bind:group={selectedCategories}>
							<label for="cat-3" class="text-gray-600 ml-3">
								{category.category_name}
							</label>
						</div>
					{/each}
				</div>
			</div>

			<div class="pt-4">
				<h3 class="text-xl text-gray-800 mb-3 uppercase font-medium">Price</h3>
				<div class="mt-4 flex items-center">
					<input type="text" name="min" id="min"
						class="input input-sm w-full input-bordered focus:input-primary rounded"
						placeholder="min">
					<span class="mx-3 text-gray-500">-</span>
					<input type="text" name="max" id="max"
						class="input input-sm w-full input-bordered focus:input-primary rounded"
						placeholder="max">
				</div>
			</div>

			<div class="pt-4">
				<h3 class="text-xl text-gray-800 mb-3 uppercase font-medium">country</h3>
				<div class="flex items-center gap-2">
					<div class="size-selector">
						<input type="radio" name="country" id="ct-au" class="hidden">
						<label for="ct-au"
							class="text-xs border border-gray-200 rounded-sm h-6 w-6 flex items-center justify-center cursor-pointer shadow-sm text-gray-600">AU</label>
					</div>
					<div class="size-selector">
						<input type="radio" name="country" id="ct-ca" class="hidden">
						<label for="ct-ca"
							class="text-xs border border-gray-200 rounded-sm h-6 w-6 flex items-center justify-center cursor-pointer shadow-sm text-gray-600">CA</label>
					</div>
					<div class="size-selector">
						<input type="radio" name="country" id="ct-cn" class="hidden">
						<label for="ct-cn"
							class="text-xs border border-gray-200 rounded-sm h-6 w-6 flex items-center justify-center cursor-pointer shadow-sm text-gray-600">CN</label>
					</div>
					<div class="size-selector">
						<input type="radio" name="country" id="tr-in" class="hidden">
						<label for="tr-in"
							class="text-xs border border-gray-200 rounded-sm h-6 w-6 flex items-center justify-center cursor-pointer shadow-sm text-gray-600">IN</label>
					</div>
					<div class="size-selector">
						<input type="radio" name="country" id="ct-mx" class="hidden">
						<label for="ct-mx"
							class="text-xs border border-gray-200 rounded-sm h-6 w-6 flex items-center justify-center cursor-pointer shadow-sm text-gray-600">MX</label>
					</div>
					<div class="size-selector">
						<input type="radio" name="country" id="ct-us" class="hidden">
						<label for="ct-us"
							class="text-xs border border-gray-200 rounded-sm h-6 w-6 flex items-center justify-center cursor-pointer shadow-sm text-gray-600">US</label>
					</div>
				</div>
			</div>

		</div>
	</div>

	<!-- products -->
	<div class="col-span-3">
		<div class="flex items-center mb-4">
			<select name="sort" id="sort"
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
	{#each data.items as product (product.product_id)}
	<div class="card card-compact shadow-md rounded group">
		<a href={`/product/${product.product_id}`} class="h-full flex flex-col">
			<figure><img src="https://daisyui.com/images/stock/photo-1606107557195-0e29a4b5b4aa.jpg" alt="Shoes" /></figure>
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


		<button class="block w-full py-2 text-center text-white bg-primary border border-primary rounded-b hover:bg-transparent hover:text-primary transition">Add
			to cart</button>
	</div>
	{/each}
</div> 
	<!-- ./products -->
</div>


<!-- ./shop wrapper -->
</div>


<h1 class="text-3xl font-bold underline">
	Hello world 222!
</h1>


<style lang='postcss'>
</style>