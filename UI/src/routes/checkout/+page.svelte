<!-- wrapper -->
<div class="container grid grid-cols-12 items-start pb-16 pt-4 gap-6">

	<div class="col-span-8 border border-gray-200 p-4 rounded">
		<h3 class="text-lg font-medium capitalize mb-4">Checkout</h3>
		<div class="space-y-4">
			<div>
				<label for="first-name" class="text-gray-600">Full Name <span
					class="text-primary">*</span></label>
				<input type="text" name="first-name" id="first-name" class="input-box">
			</div>
			
			<div>
				<label for="region" class="text-gray-600">Country/Region</label>
				<input type="text" name="region" id="region" class="input-box">
			</div>
			<div>
				<label for="address" class="text-gray-600">Street address</label>
				<input type="text" name="address" id="address" class="input-box">
			</div>
			<div>
				<label for="city" class="text-gray-600">City</label>
				<input type="text" name="city" id="city" class="input-box">
			</div>
			<div>
				<label for="phone" class="text-gray-600">Phone number<span
					class="text-primary">*</span></label>
				<input type="text" name="phone" id="phone" class="input-box">
			</div>
			<div>
				<label for="email" class="text-gray-600">Email address<span
					class="text-primary">*</span></label>
				<input type="email" name="email" id="email" class="input-box">
			</div>
			<div>
				<label for="company" class="text-gray-600">Payment method</label>
				<select name="method" id="method"
					class="w-44 text-sm text-gray-600 py-3 px-4 border-gray-300 shadow-sm rounded focus:ring-primary focus:border-primary">
					<option value="">Cash</option>
					<option value="price-low-to-high">Debit</option>
					<option value="price-high-to-low">Credit</option>
				</select>
			</div>
		</div>

	</div>

	<div class="col-span-4 border border-gray-200 p-4 rounded">
		<h4 class="text-gray-800 text-lg mb-4 font-medium uppercase">order summary</h4>
		<div class="space-y-2">
			<div class="flex justify-between">
				<div>
					<h5 class="text-gray-800 font-medium">Italian shape sofa</h5>
					<p class="text-sm text-gray-600">Amount: 2</p>
				</div>
				<p class="text-gray-800 font-medium">$320</p>
			</div>
			
		</div>

		<div class="flex justify-between border-b border-gray-200 mt-1 text-gray-800 font-medium py-3 uppercas">
			<p>subtotal</p>
			<p>$320</p>
		</div>

		<div class="flex justify-between border-b border-gray-200 mt-1 text-gray-800 font-medium py-3 uppercas">
			<p>shipping</p>
			<p>Free</p>
		</div>

		<div class="flex justify-between text-gray-800 font-medium py-3 uppercas">
			<p class="font-semibold">Total</p>
			<p>$320</p>
		</div>

		<div class="flex items-center mb-4 mt-2">
			<input type="checkbox" name="aggrement" id="aggrement"
				class="text-primary focus:ring-0 rounded-sm cursor-pointer w-3 h-3">
			<label for="aggrement" class="text-gray-600 ml-3 cursor-pointer text-sm">I agree to the <a href="#"
					class="text-primary">terms & conditions</a></label>
		</div>

		<a href="#"
			class="block w-full py-3 px-4 text-center text-white bg-primary border border-primary rounded-md hover:bg-transparent hover:text-primary transition font-medium">Place
			order</a>
	</div>

</div>
<!-- ./wrapper -->