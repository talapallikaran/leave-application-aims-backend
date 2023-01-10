const pool = require("../../config");
const bcrypt = require("bcrypt");
const formatDate = require("../helpers/helper");

const getUsers = async function () {
  return new Promise(async function (resolve, reject) {
    await pool
      .query(
        "SELECT u.*, rpm.reporting_person_id as reporting_person  ,rpm.reporting_person_uuid as reporting_person_uuid ,rpm.reporting_person_name as reporting_person_name FROM users u LEFT JOIN reporting_person_map rpm ON rpm.user_id = u.user_id ORDER BY u.id ASC",
        []
      )
      .then(function (results) {
        resolve(results.rows);
      })
      .catch(function (err) {
        reject(err);
      });
  });
};

const setUserRoles = async function (request, response) {
  const {
    user_id,
    reporting_person_id,
    reporting_person_uuid,
    reporting_person_name,
    user_uuid,
  } = request;
  return new Promise(async function (resolve, reject) {
    await pool
      .query(
        "INSERT INTO public.reporting_person_map(user_id, reporting_person_id, reporting_person_uuid, reporting_person_name, user_uuid)VALUES ($1, $2, $3, $4, $5)",
        [
          user_id,
          reporting_person_id,
          reporting_person_uuid,
          reporting_person_name,
          user_uuid,
        ]
      )
      .then(function (results) {
        resolve(results.rows);
      })
      .catch(function (err) {
        reject(err);
      });
  });
};

const updateUserRoles = function (request) {
  const {
    reporting_person_id,
    reporting_person_uuid,
    reporting_person_name,
    user_uuid,
  } = request;
  return new Promise(function (resolve, reject) {
    if (!user_uuid) {
      console.log("error: id missing");
      reject("error: id missing");
    } else {
      pool
        .query(
          "UPDATE public.reporting_person_map   SET  reporting_person_id=$2, reporting_person_uuid=$3, reporting_person_name=$4  WHERE user_uuid=$1;",
          [
            user_uuid,
            reporting_person_id,
            reporting_person_uuid,
            reporting_person_name,
          ]
        )
        .then(function (result) {
          resolve(result.rows[0]);
        })
        .catch(function (err) {
          reject(err);
        });
    }
  });
};

async function Updateuser(data) {
  const { user_id, role_id, name, email_id, phone, id, dob } = data;
  return new Promise(function (resolve, reject) {
    if (!user_id.id) {
      console.log("error: id missing");
      reject("error: id missing");
    } else {
      pool
        .query(
          "UPDATE users SET   id=$4  , role_id=$5 , name = $2, email_id = $3, phone=$6  , dob=$7  WHERE user_id = $1",
          [user_id.id, name, email_id, id, role_id, phone, dob]
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

module.exports = {
  getUsers,
  setUserRoles,
  updateUserRoles,
  Updateuser,
};
