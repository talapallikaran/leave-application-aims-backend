const pool = require("../../config");
var d = new Date();
const formatDate = require("./helper");

const dformat = [d.getHours(), d.getMinutes(), d.getSeconds()].join(":");

var d1 = formatDate.formatDate(new Date());
const time = `${d1} ${dformat}`;

const AUTH = async (data) => {
  authData = data.split(" ")[1];
  {
    return new Promise(function (resolve, reject) {
      pool
        .query("SELECT * FROM user_session where token = $1", [authData])
        .then(function (results) {
          if (results.rows.length) {
            if (Date.parse(time) < Date.parse(results?.rows[0]?.expires_at)) {
              resolve(results.rows[0]);
            } else {
              reject(err);
            }
          } else {
            resolve();
          }
        })
        .catch(function (err) {
          reject(err);
        });
    });
  }
};

module.exports = {
  AUTH,
};
