import { getClientDB } from '$lib/db';
import type { Handle } from "@sveltejs/kit";

export const handle = (async ({event, resolve}) => {
  const clientDB = await getClientDB();

  event.locals.client = clientDB; // Automatic create client and release

  // +page.server.ts and others stuffs
  // Read more here https://joyofcode.xyz/sveltekit-data-flow
  // event.locals: https://khromov.se/the-comprehensive-guide-to-locals-in-sveltekit/
  const response = await resolve(event);

  clientDB.release();

  return response;
}) satisfies Handle;