export async function load({ locals }) {
	// Querying: https://node-postgres.com/features/pooling
	const res_items = await locals.client.query('SELECT * FROM get_items()');
	const res_cat = await locals.client.query('SELECT * FROM category');

	return { 
		items: res_items.rows,
		cat: res_cat.rows
	};
}