<script lang='ts'>
	export let state = 0;
	export let form;
</script>

<h2 class="text-2xl uppercase font-medium mb-1">Login</h2>
<p class="text-gray-600 mb-6 text-sm">
	Welcome back customer
</p>
<form method="POST" action="?/login" autocomplete="off">
	<div class="space-y-2">
		<div>
			<label for="email" class="text-gray-600 mb-2 block">Email address</label>
			<input type="email" name="email"
				class="block w-full border border-gray-300 px-4 py-3 text-gray-600 text-sm rounded focus:ring-0 focus:border-primary placeholder-gray-400"
				placeholder="youremail.@domain.com" required>
		</div>
		<div>
			<label for="password" class="text-gray-600 mb-2 block">Password</label>
			<input type="password" name="password"
				class="block w-full border border-gray-300 px-4 py-3 text-gray-600 text-sm rounded focus:ring-0 focus:border-primary placeholder-gray-400"
				placeholder="*******" required>
		</div>
	</div>
<!--             <div class="flex items-center justify-between mt-6">
		<div class="flex items-center">
			<input type="checkbox" name="remember" id="remember"
				class="text-primary focus:ring-0 rounded-sm cursor-pointer">
			<label for="remember" class="text-gray-600 ml-3 cursor-pointer">Remember me</label>
		</div>
		<a href="#" class="text-primary">Forgot password</a>
	</div> -->
	{#if form?.success === false}
		<p class="mt-2 text-error">Wrong email or password.</p>
	{/if}

	<div class="mt-4">
		<button type="submit"
			class="block w-full py-2 text-center text-white bg-primary border border-primary rounded hover:bg-transparent hover:text-primary transition uppercase font-roboto font-medium">Login</button>
	</div>
</form>

<!-- login with -->
<div class="mt-6 flex justify-center relative">
	<div class="text-gray-600 uppercase px-3 bg-white z-10 relative">Or login with</div>
	<div class="absolute left-0 top-3 w-full border-b-2 border-gray-200"></div>
</div>
<div class="mt-4 flex gap-4">
	<a href="/"
		class="w-1/2 py-2 text-center text-white bg-blue-800 rounded uppercase font-roboto font-medium text-sm hover:bg-blue-700">facebook</a>
	<a href="/"
		class="w-1/2 py-2 text-center text-white bg-red-600 rounded uppercase font-roboto font-medium text-sm hover:bg-red-500">google</a>
</div>
<!-- ./login with -->

<p class="mt-4 text-center text-gray-600">Don't have account?
	<button class="text-primary" on:click={() => state = 1}>Register now</button>
</p>