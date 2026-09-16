const Planet = require("../models/Planet");

async function index(req, res) {
  const rows = await Planet.findAll();
  res.json(rows);
}

module.exports = { index };
