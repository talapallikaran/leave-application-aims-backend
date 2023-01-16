const pool = require("../../config");
const bcrypt = require("bcrypt");
const formatDate = require("../helpers/helper");
var User = require("./user");

function updateUserRoles(request) {
  const { reporting_person_id, user_id, name, email_id, dob, phone } = request;

  return new Promise(function (resolve, reject) {
    if (!user_id) {
      console.log("error: id missing");

      reject("error: id missing");
    } else {
      pool

        .query("SELECT COUNT(*) FROM reporting_person_map WHERE user_id = $1", [
          user_id,
        ])

        .then(function (result) {
          if (result.rows[0].count > 0) {
            pool
              .query(
                "UPDATE public.reporting_person_map SET reporting_person_id=$2 WHERE  user_id=$1",

                [user_id, reporting_person_id]
              )

              .then(function (result) {
                resolve(result.rows[0]);
              })

              .catch(function (err) {
                reject(err);
              });
          } else {
            pool

              .query(
                "INSERT INTO public.reporting_person_map(user_id, reporting_person_id)VALUES ($1, $2)",

                [user_id, reporting_person_id]
              )

              .then(function (results) {
                resolve(results.rows);
              })

              .catch(function (err) {
                reject(err);
              });
          }
        })

        .catch(function (err) {
          reject(err);
        });

      pool

        .query(
          "UPDATE users SET  name=$2 , email_id=$3, dob=$4, phone=$5  WHERE user_id=$1",

          [user_id, name, email_id, dob, phone]
        )

        .then(function (result) {
          resolve(result.rows[0]);
        })

        .catch(function (err) {
          reject(err);
        });
    }
  });
}

function hashPassword(password) {
  return new Promise(function (resolve, reject) {
    bcrypt.genSalt(10, function (err, salt) {
      if (err) {
        reject(err);
      } else {
        bcrypt.hash(password, salt, function (err, hash) {
          if (err) {
            reject(err);
          } else {
            resolve(hash);
          }
        });
      }
    });
  });
}
exports.hashPassword = hashPassword;

module.exports = {
  updateUserRoles,
};
