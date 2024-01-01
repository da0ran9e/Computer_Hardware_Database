import pg from 'pg';

const { Pool } = pg;

const pool = new Pool({
	user: 'postgres',
	host: 'localhost',
	database: 'Hardware',
	password: 'q12Q!@',
	port: 5432,
})
 
export const getClientDB = async () => {
	try {
		return await pool.connect()
	} catch(err) {
		console.log("Cannot connect to DB???");
		console.err(err);
	}
};