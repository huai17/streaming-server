// load .env
require("dotenv").config();

const express = require("express");
const cors = require("cors");
const app = express();

// middlewares
app.use(cors());

const { checkBroadcastToken } = require("./src/utils/jwt");
app.get("/broadcast", checkBroadcastToken);

// health check
app.get("/", (req, res) => {
  res.send("Server on!");
});

const PORT = process.env.PORT || 5000;
app.listen({ port: PORT });
