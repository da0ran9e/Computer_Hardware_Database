import { getUserCookies } from '$lib/manageCookies';

export async function load({ locals, cookies }) {
	// Querying: https://node-postgres.com/features/pooling
	const usermail = getUserCookies(cookies);
	console.log("Reloaded Layout")

	if (!usermail) { return {} }

	// Logged in (no query password)
	const res_user = 
		await locals.client.query('SELECT user_id, user_name, email, phone_number FROM account WHERE email = $1', [usermail]);
		
	if (!res_user.rows[0]) { return {} }

	const res_cart =
		await locals.client.query('SELECT * FROM get_user_cart($1)', [usermail]);

	return { 
		user: {
			info: res_user.rows[0],
			cart: res_cart.rows
		}
	}
}