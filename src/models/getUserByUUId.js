const pool = require("../../config");

function getUserByUUId(id) {
  return new Promise(function (resolve, reject) {
    pool
      .query("SELECT * FROM users where id = $1", [id])
      .then(function (results) {
        resolve(results.rows[0]);
      })
      .catch(function (err) {
        reject(err);
      });
  });
}
module.exports = {
  getUserByUUId,
};
