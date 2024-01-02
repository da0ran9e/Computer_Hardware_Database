import { getUserCookies } from '$lib/manageCookies';

export async function load({ locals, cookies }) {
	// Querying: https://node-postgres.com/features/pooling
	const usermail = getUserCookies(cookies);
	console.log("Reloaded Layout")

	if (!usermail) {
		return {}
	}

	// Logged in
	const res_user = await locals.client.query('SELECT * FROM account WHERE email = $1', [usermail]);
	return { 
		user: {
			name: res_user.rows[0].user_name,
			cartcount: 1
		}
	}
}