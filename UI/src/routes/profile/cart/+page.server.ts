export const actions = {
	save: async ({ request, locals }) => {
		console.log("Updating Quantity...");
		const form = await request.formData();
		const cartID = form.get('cartID');
		const productID = form.get('productID');
		const quantity = form.get('quantity');

		console.log('SELECT update_cart_item_quantity($1, $2, $3);', [cartID, productID, quantity])
		try {
			const res_cart = await locals.client.query('SELECT update_cart_item_quantity($1, $2, $3);', [cartID, productID, quantity]);
			const status = Boolean(res_cart.rows[0].update_cart_item_quantity);

			let returnobj = { update: status }
			// Seet cookies here
			if (!status) {
				returnobj.errmsg = "IDK";
				// $page.form, return to the "export let form" of +page.svelte
				console.log("Update cart failed.");
			}

			return returnobj;
		} catch (err) {
			console.log(err.message);
			return { 
				update: false,
				errmsg: err.message 
			}
		}

	},
}