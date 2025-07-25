const { Pool } = require('pg');

const pool = new Pool({
  host: 'localhost',
  port: 5432,
  user: 'postgres',
  password: '54321',
  database: 'cinecin'
});

module.exports = pool;
