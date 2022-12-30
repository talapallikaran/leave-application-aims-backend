console.log("Hello there , I'm Sarthak!");
const express = require("express");
const bodyParser = require("body-parser");
const app = express();
const db = require("./queries");
const indexRouter = require("./routes/index");
const port = 3100;

app.use(bodyParser.json());
app.use(
  bodyParser.urlencoded({
    extended: true,
  })
);

app.get("/", (request, response) => {
  response.json({ info: "Node.js, Express, and Postgres API" });
});

app.use("/", indexRouter);

app.listen(port, () => {
  console.log(`App running on port ${port}.`);
});
