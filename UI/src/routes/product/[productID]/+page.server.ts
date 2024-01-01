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