export function setUserCookies(cookies, cookievalue) {
	// name: sessionId
	// value: [email protected]
	// options: {...}

	cookies.set('session', cookievalue, {
		path: '/',				// send cookie for every page
		httpOnly: true,			// server side only cookie so you can't use `document.cookie`
		sameSite: 'strict',		// only requests from same site can send cookies
								// https://developer.mozilla.org/en-US/docs/Glossary/CSRF
		// secure: process.env.NODE_ENV === 'production',	// only sent over HTTPS in production
		secure: false,
		maxAge: 60 * 60 * 24,							// set cookie to expire after a day
	})
}

export function getUserCookies(cookies) {
	return cookies.get('session');
}

export async function deleteUserCookies(cookies) {
	await cookies.delete('session', {path: '/'});
}