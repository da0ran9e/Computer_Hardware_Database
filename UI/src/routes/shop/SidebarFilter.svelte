<script lang='ts'>
	export let allCats = [];

	let selectedCategories = [];

	function logData(e) {
		let formData = e.formData;
			for (let [name, value] of Array.from(formData.entries())) {
			if (value === '') formData.delete(name);
		}
	}
</script>

<!-- ./sidebar -->
<form method="GET" action="?/" on:formdata={logData}
	class="col-span-1 bg-white px-4 pb-6 shadow rounded overflow-hidden hidden md:block divide-y divide-gray-200 space-y-5">
		<div class="pt-4">
			<h3 class="text-xl text-gray-800 mb-3 uppercase font-medium">Categories</h3>
			<div class="space-y-2">
				<!-- Each, data.cat from +page.server.ts -->
				<!-- Group checkbox: https://learn.svelte.dev/tutorial/group-inputs -->
				{#each allCats as category (category.category_id) }
					<div class="flex items-center">
						<input type="checkbox"
							name="selectcat"
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
				<input type="number" name="min" id="min" min="0"
					class="input input-sm w-full input-bordered focus:input-primary rounded"
					placeholder="min">
				<span class="mx-3 text-gray-500">-</span>
				<input type="number" name="max" id="max" min="0"
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
		<button type="submit" class="btn btn-primary">Search</button>
</form>