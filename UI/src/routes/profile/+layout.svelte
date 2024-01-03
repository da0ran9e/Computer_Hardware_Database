<script>
	import Avatar from '$lib/assets/images/avatar.png';
	import { page } from '$app/stores';  

	// GET THIS FROM src/routes/+layout.server.ts
	export let data;	// Still contain user info

	console.log(data);
</script>



<!-- wrapper -->
<div class="container m-auto grid grid-cols-12 items-start gap-6 pt-4 pb-16">

	<!-- sidebar -->
	<div class="col-span-3">
		<div class="px-4 py-3 shadow flex items-center gap-4">
			<div class="flex-shrink-0">
				<img src={Avatar} alt="profile"
					class="rounded-full w-14 h-14 border border-gray-200 p-1 object-cover">
			</div>
			<div class="flex-grow">
				<p>Hello, 
					<span class="font-bold">{data.user?.info.user_name}</span>
				</p>
			</div>
		</div>


		<div class="mt-6 bg-white shadow rounded p-4 divide-y divide-gray-200 space-y-4 text-gray-600 sidebarthing">
			<div class="!pt-0">
				<a href="/profile" class:text-primary={$page.url.pathname === '/profile'}>
					<!-- fa-regular fa-address -->
					My Account
				</a>
				<a href="#" class="hover:text-primary block capitalize transition">
					Profile information
				</a>
				<a href="#" class="relative hover:text-primary block capitalize transition">
					Manage addresses
				</a>
				<a href="#" class="relative hover:text-primary block capitalize transition">
					Change password
				</a>
			</div>

			<div>
				<a href="/profile/cart" class:text-primary={$page.url.pathname === '/profile/cart'}>
					<!-- fa-regular fa-heart -->
					My cart
				</a>
			</div>

			<div>
				<a href="/profile/history" 
					class:text-primary={$page.url.pathname === '/profile/history'}>
					<!-- fa-solid fa-box-archive -->
					My order history
				</a>

				<!-- My returns -->
				<!-- My reviews -->
			</div>

<!-- 			<div class="space-y-1 pl-8 pt-4">
				<a href="#" class="relative hover:text-primary block font-medium capitalize transition">
					<span class="absolute -left-8 top-0 text-base">
						<i class="fa-regular fa-credit-card"></i>
					</span>
					Payment methods
				</a>
				<a href="#" class="relative hover:text-primary block capitalize transition">
					voucher
				</a>
			</div> -->



			<div>
				<form method="POST" action="/login?/logout">
					<button type="submit" class="big-text text-error">
						<!-- fa-right-from-bracket -->
						Logout
					</button>
				</form>
			</div>

		</div>
	</div>
	<!-- ./sidebar -->

	<slot/>

</div>
<!-- ./wrapper -->

<div class="h-20"></div>

<style lang='postcss'>
	.big-text {
		@apply relative hover:text-primary block font-medium text-lg capitalize transition;
	}

	.sidebarthing div a:first-child {
		@apply big-text;
	}

	.sidebarthing div {
		@apply space-y-1 pl-8 pt-4;
	}
</style>