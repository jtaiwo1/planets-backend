const db = require("../db/connect");

class Planet {
  static async findAll() {
    const result = await db.query("SELECT * FROM planets ORDER BY id");
    return result.rows;
  }

  static async findById(id) {
    const result = await db.query("SELECT * FROM planets WHERE id = $1", [id]);
    return result.rows[0];
  }
}

module.exports = Planet;
