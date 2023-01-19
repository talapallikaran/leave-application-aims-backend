const pool = require("../../config");
const bcrypt = require("bcrypt");

const formatDate = require("../helpers/helper");

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

function createUser(request, reporting_id) {
  const { name, email, phone, dob, password, reporting_person } = request;
  const role_id = 2;
  if (!reporting_person) {
    return new Promise(function (resolve, reject) {
      hashPassword(password)
        .then((hash) =>
          pool.query(
            "INSERT INTO users ( role_id, name, email_id, phone, dob ,password   ) VALUES ($1, $2 ,$3 ,$4 , $5 ,$6 )",
            [role_id, name, email, phone, dob, hash]
          )
        )
        .then((result) => {
          resolve(result.rows[0]);
        })
        .catch((err) => {
          reject(err);
        });
    });
  } else {
    return new Promise(function (resolve, reject) {
      hashPassword(password)
        .then(
          async (hash) =>
            await pool.query(
              "INSERT INTO users ( role_id, name, email_id, phone, dob ,password   ) VALUES ($1, $2 ,$3 ,$4 , $5 ,$6 )",
              [role_id, name, email, phone, dob, hash]
            )
        )
        .then(() =>
          pool.query("SELECT * FROM users WHERE email_id = $1;", [email])
        )
        .then((ress) => {
          const user_id = ress.rows[0].user_id;
          return pool.query(
            "INSERT INTO public.reporting_person_map(user_id, reporting_person_id) VALUES ($1, $2);",
            [user_id, reporting_id]
          );
        })
        .then((result) => {
          resolve(result.rows[0]);
        })
        .catch((err) => {
          reject(err);
        });
    });
  }
}

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
  getUsers,
  createUser,
  getUserByUUId,
  updateUserRoles,
};
