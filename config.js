require("dotenv").config();

const { Pool } = require("pg");
const isProduction = process.env.NODE_ENV === "production";

const connectionString = `postgresql://${process.env.DATABASE_USER}:${process.env.DATABASE_PASSWORD}@${process.env.DATABASE_HOST}:${process.env.DATABASE_PORT}/${process.env.DATABASE}`;

const pool = new Pool({
  connectionString: isProduction ? process.env.DATABASE_URL : connectionString,
  ssl: isProduction,
});

module.exports = pool;

// require("dotenv").config();

// const { Pool } = require("pg");

// const pool = new Pool({
//   user: "postgres",
//   host: "localhost",
//   database: "api",
//   password: "aims",
//   port: 5432,
// });

// module.exports = pool;
