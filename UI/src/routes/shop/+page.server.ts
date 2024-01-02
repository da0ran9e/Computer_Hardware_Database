function build_filter_query(cats, min, max, search) {
	const item_args = [];
	let item_query = 'SELECT * FROM get_items() WHERE 1=1';
	let arg_count = 0;

	console.log(cats, min, max);

	if (cats.length > 0) {
		const idx_list = cats.map(cat => { 
			item_args.push(cat);
			arg_count += 1;
			return `$${arg_count}`;
		});

		item_query += ' AND category_id IN (' + idx_list.join(',') + ')';
	}

	if (search) {
		arg_count += 1;
		item_query += ' AND product_name ~* $' + arg_count;
		item_args.push(search);		
	}

	if (min) {
		arg_count += 1;
		item_query += ' AND standard_cost > $' + arg_count;
		item_args.push(min);
	}

	if (max) {
		arg_count += 1;
		item_query += ' AND standard_cost < $' + arg_count;
		item_args.push(max);
	}

	return {
		query: item_query,
		args: item_args,
	}
}

export async function load({ locals, url }) {
	// Querying: https://node-postgres.com/features/pooling
	const res = build_filter_query(
		url.searchParams.getAll('selectcat'),
		url.searchParams.get('min'),
		url.searchParams.get('max'),
		url.searchParams.get('search')
	);

	console.log('"',res.query, '"', res.args);

	const res_items = await locals.client.query(res.query, res.args);
	const res_cat = await locals.client.query('SELECT * FROM category');

	return { 
		items: res_items.rows,
		cat: res_cat.rows
	};
}


