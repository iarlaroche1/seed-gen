// test-db.js
import mysql from 'mysql2/promise';

const conn = await mysql.createConnection({
  host: 'care2-sandbox-db.onetouchhealth.net',
  port: 3306,
  user: 'Manuel',
  password: 'YOUR_PASSWORD_HERE',
  database: 'cm'
});

const [rows] = await conn.query(
  'SELECT COUNT(*) as count FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = "cm"'
);

console.log('Table count:', rows[0].count);
await conn.end();