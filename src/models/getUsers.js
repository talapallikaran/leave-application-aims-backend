const pool = require("../../config");

async function getUsers() {
  return new Promise(async function (resolve, reject) {
    await pool
      .query(
        "SELECT u.*, rpm.reporting_person_id as reporting_person  , s.name as reporting_person_name  ,s.id as reporting_person_uuid FROM users u LEFT JOIN reporting_person_map rpm ON rpm.user_id = u.user_id LEFT JOIN  users  s ON rpm.reporting_person_id  = s.user_id ORDER BY u.id ASC",
        []
      )
      .then(function (results) {
        resolve(results.rows);
      })
      .catch(function (err) {
        reject(err);
      });
  });
}

module.exports = {
  getUsers,
};
