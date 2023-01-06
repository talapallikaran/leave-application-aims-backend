const pool = require("../../config");
var d = new Date();
const dformat = [d.getHours(), d.getMinutes(), d.getSeconds()].join(":");
console.log("currenttime", dformat);

const AUTH = async (data) => {
  authData = data.split(" ")[1];

  {
    return new Promise(function (resolve, reject) {
      pool
        .query("SELECT * FROM  user_session   where token = $1", [authData])
        .then(function (results) {
          console.log("results.expires_at", results?.rows[0]?.expires_at);
          if (dformat < results?.rows[0]?.expires_at) {
            resolve(results.rows[0]);
          } else {
            reject(err);
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
