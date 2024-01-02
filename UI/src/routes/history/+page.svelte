

<div class="container grid grid-cols-12 items-start gap-6 pt-4 pb-16">
<!-- sidebar -->
<div class="col-span-3">
	<div class="px-4 py-3 shadow flex items-center gap-4">
		<div class="flex-shrink-0">
			<img src="../assets/images/avatar.png" alt="profile"
				class="rounded-full w-14 h-14 border border-gray-200 p-1 object-cover">
		</div>
		<div class="flex-grow">
			<p class="text-gray-600">Hello,</p>
			<h4 class="text-gray-800 font-medium">Username</h4>
		</div>
	</div>

	<div class="mt-6 bg-white shadow rounded p-4 divide-y divide-gray-200 space-y-4 text-gray-600">
		<div class="space-y-1 pl-8">
			<a href="#" class="block font-medium capitalize transition">
				<span class="absolute -left-8 top-0 text-base">
					<i class="fa-regular fa-address-card"></i>
				</span>
				Manage account
			</a>
			<a href="#" class="relative hover:text-primary block capitalize transition">
				Profile information
			</a>
			<a href="#" class="relative hover:text-primary block capitalize transition">
				Manage addresses
			</a>
			<a href="#" class="relative hover:text-primary block capitalize transition">
				Change password
			</a>
		</div>

		<div class="space-y-1 pl-8 pt-4">
			<a href="#" class="relative hover:text-primary block font-medium capitalize transition">
				<span class="absolute -left-8 top-0 text-base">
					<i class="fa-solid fa-box-archive"></i>
				</span>
				My order history
			</a>
			<a href="#" class="relative hover:text-primary block capitalize transition">
				My returns
			</a>
			<a href="#" class="relative hover:text-primary block capitalize transition">
				My Cancellations
			</a>
			<a href="#" class="relative hover:text-primary block capitalize transition">
				My reviews
			</a>
		</div>

		<div class="space-y-1 pl-8 pt-4">
			<a href="#" class="relative hover:text-primary block font-medium capitalize transition">
				<span class="absolute -left-8 top-0 text-base">
					<i class="fa-regular fa-credit-card"></i>
				</span>
				Payment methods
			</a>
			<a href="#" class="relative hover:text-primary block capitalize transition">
				voucher
			</a>
		</div>

		<div class="space-y-1 pl-8 pt-4">
			<a href="#" class="relative text-primary block font-medium capitalize transition">
				<span class="absolute -left-8 top-0 text-base">
					<i class="fa-regular fa-heart"></i>
				</span>
				My wishlist
			</a>
		</div>

		<div class="space-y-1 pl-8 pt-4">
			<a href="#" class="relative hover:text-primary block font-medium capitalize transition">
				<span class="absolute -left-8 top-0 text-base">
					<i class="fa-solid fa-right-from-bracket"></i>
				</span>
				Logout
			</a>
		</div>

	</div>
</div>
<!-- ./sidebar -->
<!-- wishlist -->
<div class="col-span-9 space-y-4">

	<div class="flex items-center justify-between border gap-6 p-4 border-gray-200 rounded">
		<div class="w-1/3">
			<h2 class="text-gray-800 text-xl font-medium uppercase">order Id go here</h2>
			<p class="text-gray-500 text-sm">Status: <span class="text-blue-600">Pending</span></p>
		</div>
		<div class="text-primary text-lg font-semibold">$320.00</div>
		<a href=""
			class=" px-6 py-2 text-center text-sm text-white bg-green-600 hover:bg-green-400 border border-green-400 rounded transition uppercase font-roboto font-medium">View</a>
		<a href="/checkout"
			class=" px-6 py-2 text-center text-sm text-white bg-red-600 hover:bg-red-400 border border-green-400 rounded transition uppercase font-roboto font-medium">Cancel</a>


		<div class="text-gray-600 cursor-pointer hover:text-primary">
			<i class="fa-solid fa-trash"></i>
		</div>
	</div>

	<div class="flex items-center justify-between border gap-6 p-4 border-gray-200 rounded">
		<div class="w-1/3">
			<h2 class="text-gray-800 text-xl font-medium uppercase">Order id</h2>
			<p class="text-gray-500 text-sm">Status: <span class="text-green-600">Delivering</span></p>
		</div>
		<div class="text-primary text-lg font-semibold">$320.00</div>
		<a href=""
		class=" px-6 py-2 text-center text-sm text-white bg-green-600 hover:bg-green-400 border border-green-400 rounded transition uppercase font-roboto font-medium">View</a>
	<a href="/checkout"
		class=" px-6 py-2 text-center cursor-not-allowed text-sm text-white bg-red-400 hover:bg-red-400 border border-green-400 rounded transition uppercase font-roboto font-medium">Cancel</a>


		<div class="text-gray-600 cursor-pointer hover:text-primary">
			<i class="fa-solid fa-trash"></i>
		</div>
	</div>

	
</div>
</div>
<!-- ./wishlist -->