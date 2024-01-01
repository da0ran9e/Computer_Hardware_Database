import pg from 'pg';

const { Pool } = pg;

const pool = new Pool({
	user: 'postgres',
	host: 'localhost',
	database: 'Hardware',
	password: 'q12Q!@',
	port: 5432,
})
 
export const getClientDB = async () => await pool.connect();