import { redirect } from '@sveltejs/kit';

export const actions = {
		login: async ({ request, cookies, locals }) => {
			const form = await request.formData();
			const email = form.get('email');
			const password = form.get('password');
			console.log("Logging in...");

			const res_login = await locals.client.query('SELECT login_account($1, $2);', [email, password]);
			const succ = Boolean(res_login.rows[0].login_account);

			// Seet cookies here
			if (succ) {
				throw redirect(303, '/');
			}

			// $page.form, return to the "export let form" of +page.svelte
			return {
				success: succ,
			}
		},
		register: async ({ request, cookies }) => {
			console.log("Registering...");
			//TODO: 
		}
}