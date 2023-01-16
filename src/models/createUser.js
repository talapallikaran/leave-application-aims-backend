const pool = require("../../config");
const { hashPassword } = require("./updateUserRoles");
const bcrypt = require("bcrypt");
const formatDate = require("../helpers/helper");

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

module.exports = {
  createUser,
};
