import pg from 'pg';

const { Pool } = pg;

const pool = new Pool({
	user: 'postgres',
	database: 'Hardware',
	password: 'q12Q!@',

	host: 'localhost',
	port: 5432,
})
 
export const getClientDB = async () => {
	try {
		return await pool.connect()
	} catch(err) {
		console.log("Cannot connect to DB???");
		console.error(err);
	}
};