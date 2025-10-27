import http from 'http';
import PG from 'pg';

const port = Number(process.env.PORT);
const user = String(process.env.DB_USER);
const pass = String(process.env.DB_PASS);
const host = String(process.env.DB_HOST);
const database = String(process.env.DB_DATABASE);
const db_port = Number(process.env.DB_PORT);

const client = new PG.Client(
  `postgres://${user}:${pass}@${host}:${db_port}/${database}`
);

let successfulConnection = false;

http.createServer(async (req, res) => {
  console.log(`Request: ${req.url}`);

  if (req.url === "/api") {
    client.connect()
      .then(() => { successfulConnection = true })
      .catch(err => console.error('Database not connected -', err.stack));

    res.setHeader("Content-Type", "application/json");
    res.writeHead(200);

    let result;

    try {
      result = (await client.query("SELECT * FROM users")).rows[0];
    } catch (error) {
      console.error(error)
    }

    const data = {
      database: successfulConnection,
      userAdmin: result?.role === "admin"
    }

    res.end(JSON.stringify(data));
  } else {
    res.writeHead(503);
    res.end("Internal Server Error");
  }

}).listen(port, () => {
  console.log(`Server is listening on port ${port}`);
});