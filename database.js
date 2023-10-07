const mysql = require('mysql2/promise');

const pool = mysql.createPool({
  host: 'localhost',
  user: 'root',
  password: 'admin',
  database: 'sistemainicial',
  waitForConnections: true,
});

module.exports = pool;
