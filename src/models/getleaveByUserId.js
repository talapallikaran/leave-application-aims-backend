const pool = require("../../config");

async function getleaveByUserId(id) {
  return new Promise(function (resolve, reject) {
    pool
      .query("SELECT * FROM leaves where user_id = $1", [id])
      .then(async function (results) {
        resolve(results.rows);
      })
      .catch(function (err) {
        reject(err);
      });
  });
}

module.exports = {
  getleaveByUserId,
};
