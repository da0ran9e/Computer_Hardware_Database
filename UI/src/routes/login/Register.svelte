<script lang='ts'>
	export let state = 1;
</script>

<h2 class="text-2xl uppercase font-medium mb-1">Create an account</h2>
<p class="text-gray-600 mb-6 text-sm">
	Register for new cosutumer
</p>
<form method="post" action="?/register" autocomplete="off">
	<div class="space-y-2">
		<div class="grid grid-cols-2 gap-4">
			<div>
				<label for="first-name" class="text-gray-600">First Name <span
						class="text-primary">*</span></label>
				<input type="text" name="first-name" id="first-name" class="input-box">
			</div>
			<div>
				<label for="last-name" class="text-gray-600">Last Name <span
						class="text-primary">*</span></label>
				<input type="text" name="last-name" id="last-name" class="input-box">
			</div>
		</div>
		<div>
			<label for="name" class="text-gray-600 mb-2 block">Full Name</label>
			<input type="text" name="name" id="name"
				class="block w-full border border-gray-300 px-4 py-3 text-gray-600 text-sm rounded focus:ring-0 focus:border-primary placeholder-gray-400"
				placeholder="fulan fulana">
		</div>
		<div>
			<label for="email" class="text-gray-600 mb-2 block">Email address</label>
			<input type="email" name="email" id="email"
				class="block w-full border border-gray-300 px-4 py-3 text-gray-600 text-sm rounded focus:ring-0 focus:border-primary placeholder-gray-400"
				placeholder="youremail.@domain.com">
		</div>
		<div>
			<label for="phone" class="text-gray-600 mb-2 block">Phone number</label>
			<input type="phone" name="phone" id="phone"
				class="block w-full border border-gray-300 px-4 py-3 text-gray-600 text-sm rounded focus:ring-0 focus:border-primary placeholder-gray-400"
				placeholder="+XXX XXX">
		</div>
		<div>
			<label for="password" class="text-gray-600 mb-2 block">Password</label>
			<input type="password" name="password" id="password"
				class="block w-full border border-gray-300 px-4 py-3 text-gray-600 text-sm rounded focus:ring-0 focus:border-primary placeholder-gray-400"
				placeholder="*******">
		</div>
		<div>
			<label for="confirm" class="text-gray-600 mb-2 block">Confirm password</label>
			<input type="password" name="confirm" id="confirm"
				class="block w-full border border-gray-300 px-4 py-3 text-gray-600 text-sm rounded focus:ring-0 focus:border-primary placeholder-gray-400"
				placeholder="*******">
		</div>
	</div>
	<div class="mt-6">
		<div class="flex items-center">
			<input type="checkbox" name="aggrement" id="aggrement"
				class="text-primary focus:ring-0 rounded-sm cursor-pointer">
			<label for="aggrement" class="text-gray-600 ml-3 cursor-pointer">I have read and agree to the <a
					href="/" class="text-primary">terms & conditions</a></label>
		</div>
	</div>
	<div class="mt-4">
		<button type="submit"
			class="block w-full py-2 text-center text-white bg-primary border border-primary rounded hover:bg-transparent hover:text-primary transition uppercase font-roboto font-medium">create
			account</button>
	</div>
</form>

<!-- login with -->
<div class="mt-6 flex justify-center relative">
	<div class="text-gray-600 uppercase px-3 bg-white z-10 relative">Or signup with</div>
	<div class="absolute left-0 top-3 w-full border-b-2 border-gray-200"></div>
</div>
<div class="mt-4 flex gap-4">
	<a href="/"
		class="w-1/2 py-2 text-center text-white bg-blue-800 rounded uppercase font-roboto font-medium text-sm hover:bg-blue-700">facebook</a>
	<a href="/"
		class="w-1/2 py-2 text-center text-white bg-red-600 rounded uppercase font-roboto font-medium text-sm hover:bg-red-500">google</a>
</div>
<!-- ./login with -->

<p class="mt-4 text-center text-gray-600">Already have account?
	<button class="text-primary cursor-pointer" on:click={() => state = 0}>Login now</button>
</p>