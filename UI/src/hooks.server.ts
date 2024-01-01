import { connectToDB } from '$lib/db';

export const handle = async ({event, resolve}) => {
  const dbconn = connectToDB();
  event.locals = { dbconn };

  // +page.server.ts and others stuffs
  // Read more here https://joyofcode.xyz/sveltekit-data-flow
  const response = await resolve(event);

  dbconn.release();
}