// load .env
require("dotenv").config();

const express = require("express");
const cors = require("cors");
const app = express();

// middlewares
app.use(cors());

const { checkBroadcastToken, checkWatchToken } = require("./src/utils/jwt");
app.get("/broadcast", checkBroadcastToken);
app.use("/hls/:token", checkWatchToken, express.static("/tmp/hls"));

// health check
app.get("/", (req, res) => {
  res.send("Server on!");
});

const PORT = process.env.PORT || 5000;
app.listen({ port: PORT });
