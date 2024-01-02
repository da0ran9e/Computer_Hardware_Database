
<script>
	import "../app.css";
	import { Toaster } from 'svelte-french-toast';

	import SearchIcon from '$lib/icons/search.svg?component';
	import HeartIcon from '$lib/icons/heart.svg?component';
	import CartIcon from '$lib/icons/cart.svg?component';
	import UserIcon from '$lib/icons/user.svg?component';

	import Logo from '$lib/logo.svg?component';

	import paymentImg from '$lib/assets/methods.png';

	let username = 'an';

	function account(){
		if (username === 'Login'){
			window.location.href ='/login'
		} else {
			window.location.href ='/profile/'// +username
		}
	}

	// +layout.server.ts
	export let data;

	function logData(e) {
		let formData = e.formData;	
		for (let [name, value] of Array.from(formData.entries())) {
			if (value === '') formData.delete(name);
		}
	}
</script>

<Toaster />

<!-- header -->
<header class="shadow-sm bg-white flex items-center justify-between px-16">
		<a href="/" class="px-2 p-4">
			<Logo width="3rem" height="3rem"/>
		</a>

		<form method="GET" action="/shop" on:formdata={logData}
			class="join border border-primary flex justify-between w-2/5 ">
			<input type="text" name="search" id="searchBar"
				class="join-item input w-full min-w-12 focus:outline-none pl-12 hidden md:flex"
				placeholder="Search">

			<SearchIcon class="absolute m-3" width="1.5rem" height="1.5rem"/>

			<button type="submit" class="join-item btn px-8 btn-primary">Search</button>
		</form>

		<div class="flex items-center gap-4">
			<!-- TODO: -->
<!-- 			<a href="/wishlist" class="text-center text-gray-700 hover:text-primary transition relative">
				<div class="indicator">
					<HeartIcon width="1.5rem" height="1.5rem"/>
					<span class="badge-num">8</span>
				</div>
				<div class="text-sm">Wishlist</div>
			</a> -->

			<!-- TODO THIS: -->
			{#if data.user}
				<a href="/cart" class="top-icon-button">
					<div class="indicator">
						<CartIcon width="1.5rem" height="1.5rem"/>
						{#if data.user.cartcount > 0}
							<span class="badge-numbered">{data.user.cartcount}</span>
						{/if}
					</div>
					<div class="text-sm leading-3">Cart</div>
				</a>

				<a href="/profile" class="top-icon-button">
					<div class="indicator px-2">
						<UserIcon width="1.5rem" height="1.5rem"/>
					</div>
					<div class="text-sm leading-3">{data.user.name}</div>
				</a>
			{:else}
				<a href="/login" class="btn btn-primary pl-1">
					<div class="indicator px-2 invert">
						<UserIcon width="1.5rem" height="1.5rem"/>
					</div>
					<div class="text-sm leading-3">Login</div>
				</a>
			{/if}
		</div>
</header>

<!-- navbar -->
<nav class="bg-gray-800 text-lg">
	<div class="container flex">
		<div class="px-8 py-4 bg-primary md:flex items-center cursor-pointer relative group hidden px-16">
			<!-- <span class="capitalize ml-2 text-white hidden">All Categories</span> -->
		</div>

		<div class="flex items-center justify-between flex-grow md:pl-12">
			<div class="flex items-center uppercase">
				<a href="/" class="selectable-nav">Home</a>
				<a href="/shop" class="selectable-nav">Shop</a>
				<a href="/about" class="selectable-nav">About us</a>
			</div>
		</div>
	</div>
</nav>
<!-- ./navbar -->

<slot />

<!-- copyright -->
<div class="bg-gray-800 py-4">
	<div class="container flex items-center justify-between mx-auto">
		<p class="text-white">&copy; Quynh & An - All Right Reserved</p>
		<div>
			<img src={paymentImg} alt="methods" class="h-5">
		</div>
	</div>
</div>
<!-- ./copyright -->

<style lang="postcss">
	.badge-numbered {
		@apply badge badge-primary min-w-5 min-h-5 p-1 indicator-item;
	}

	.top-icon-button {
		@apply text-center hover:text-primary transition relative mx-4;
	}

	.selectable-nav {
		@apply p-4 text-gray-200 hover:text-primary-content hover:bg-primary transition
	}
</style>