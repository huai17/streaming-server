const crypto = require("crypto");

// configs
const { SECRET } = require("../configs/keys");

const checkBroadcastToken = (req, res) => {
  const { name, token, exp } = req.query;
  if (!name || !token || !exp) return res.sendStatus(404);

  const timestamp = Math.floor(new Date().getTime() / 1000);
  if (timestamp > exp) return res.sendStatus(404);

  const input = exp + " " + name + " broadcast " + SECRET;
  const binaryHash = crypto.createHash("md5").update(input).digest();
  const base64Value = new Buffer(binaryHash).toString("base64");
  const code = base64Value
    .replace(/=/g, "")
    .replace(/\+/g, "-")
    .replace(/\//g, "_");

  if (code !== token) return res.sendStatus(404);

  res.sendStatus(200);
};

module.exports = {
  checkBroadcastToken,
};
