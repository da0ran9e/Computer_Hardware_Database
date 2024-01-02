import { redirect } from '@sveltejs/kit';

export async function load({ locals, params }) {
	// Querying: https://node-postgres.com/features/pooling
	const prodID = params.productID;	// [productID]

	const res_info = await 
		locals.client.query('SELECT * FROM get_an_item_info($1);', [prodID]);

	const res_warehouse = await 
		locals.client.query('SELECT * FROM get_warehouse_info($1)', [prodID]);

	return { 
		info: res_info.rows[0],
		warehouses: res_warehouse.rows
	};
}

export const actions = {
	default: async ({ request, locals }) => {
		console.log("Add To Cart...");
		const form = await request.formData();
		const email = form.get('email');
		const quantity = form.get('quantity');
		const productID = form.get('productID');

		if (!email) {
			console.log("MOVE");
			redirect(302, '/login');
		}

		// console.log('SELECT add_item_to_cart($1, $2, $3);', [productID, quantity, email], form);

		try {
			const res_login = await locals.client.query('SELECT add_item_to_cart($1, $2, $3);', [productID, quantity, email]);
			const status = Boolean(res_login.rows[0].add_item_to_cart);

			let returnobj = { addcart: status }
			// Seet cookies here
			if (!status) {
				returnobj.errmsg = "IDK";
				// $page.form, return to the "export let form" of +page.svelte
				console.log("Add item to cart failed.");
			}

			return returnobj;
		} catch (err) {
			console.log(err.message);
			return { 
				addcart: false,
				errmsg: err.message 
			}
		}

	},
}