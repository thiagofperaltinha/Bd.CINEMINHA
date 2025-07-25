const { Pool } = require('pg');

const pool = new Pool({
  host: 'localhost',
  port: 5432,
  user: 'peralta',
  password: '54321',
  database: 'cinema'
});

module.exports = pool;
