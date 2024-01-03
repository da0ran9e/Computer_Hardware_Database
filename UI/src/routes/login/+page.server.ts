import { redirect } from '@sveltejs/kit';
import { setUserCookies, getUserCookies, deleteUserCookies } from '$lib/manageCookies';

export async function load({ cookies }) {
	// Querying: https://node-postgres.com/features/pooling
	const usermail = getUserCookies(cookies);

	if (usermail) {
		redirect(303, '/profile');
	} else {
		console.log("No cookie found. User not logged in.");
	}
}

export const actions = {
	login: async ({ request, cookies, locals }) => {
		console.log("Logging in...");
		const form = await request.formData();
		const email = form.get('email');
		const password = form.get('password');

		const res_login = await locals.client.query('SELECT login_account($1, $2);', [email, password]);
		const succ = Boolean(res_login.rows[0].login_account);

		// Seet cookies here
		if (!succ) {
			// $page.form, return to the "export let form" of +page.svelte
			console.log("Login failed.");
			return { loginsuccess: succ }			
		}

		// Else success then redirect
		setUserCookies(cookies, email);
		// **** NOTE: save email into cookies ****
		redirect(303, '/');
	},


	register: async ({ request, cookies, locals }) => {
		console.log("Registering...");
		const form = await request.formData();
		const username = form.get('username');
		const password = form.get('password');
		const email = form.get('email');
		const phone = form.get('phone');

		console.log('SELECT register_account($1, $2, $3, $4)', [username, password, email, phone]);
		// --SELECT register_account('user4', 'password4', 'user4@gmail.com','368-383-2839');
		const res_register = await locals.client.query('SELECT register_account($1, $2, $3, $4)', [username, password, email, phone]);
		const status = Boolean(res_register.rows[0].register_account);

		return { registersuccess: status }
	},

	logout: async ({ cookies }) => {
		console.log("Logging out..");
		await deleteUserCookies(cookies);

		redirect(302, '/');	// move to home
	}
}