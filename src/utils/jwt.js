const jwt = require("jwt-simple");

// configs
const { JWT_SECRET } = require("../configs/keys");

const checkBroadcastToken = (req, res) => {
  const { name, token } = req.query;
  if (!name || !token) return res.sendStatus(404);
  const payload = jwt.decode(token, JWT_SECRET);
  const timestamp = Math.floor(new Date().getTime() / 1000);
  if (timestamp > (payload.exp || 0)) return res.sendStatus(404);
  if (payload.act !== "broadcast") return res.sendStatus(404);
  if (payload.sub !== name) return res.sendStatus(404);
  res.sendStatus(200);
};

const checkWatchToken = (req, res, next) => {
  const { token } = req.params;
  const file = req.path.slice(1);
  if (!token || !file) return res.sendStatus(401);
  const [fileName, ext] = file.split(".");
  const name = ext === "ts" ? fileName.split("-")[0] : fileName;
  const payload = jwt.decode(token, JWT_SECRET);
  const timestamp = Math.floor(new Date().getTime() / 1000);
  if (timestamp > (payload.exp || 0)) return res.sendStatus(401);
  if (payload.act !== "watch") return res.sendStatus(401);
  if (payload.sub !== name) return res.sendStatus(401);
  next();
};

module.exports = {
  checkBroadcastToken,
  checkWatchToken,
};
