const db = require("../db/connect");

class Planet {
  static async findAll() {
    const result = await db.query("SELECT * FROM planets");
    return result.rows;
  }
}

module.exports = Planet;
