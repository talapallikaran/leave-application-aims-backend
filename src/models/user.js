const pool = require("../../config");

const getUsers = async function () {
  return new Promise(async function (resolve, reject) {
    await pool
      .query(
        "SELECT u.*, rpm.reporting_person_id as reporting_person FROM users u LEFT JOIN reporting_person_map rpm ON rpm.user_id = u.user_id ORDER BY u.id ASC",
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

const createUser = function (request, response) {
  const { role_id, name, email_id, phone, dob } = request;
  return new Promise(function (resolve, reject) {
    pool
      .query(
        "INSERT INTO users ( role_id, name, email_id, phone, dob ) VALUES ($1, $2 ,$3 ,$4 , $5 )",
        [role_id, name, email_id, phone, dob]
      )
      .then(function (result) {
        resolve(result.rows[0]);
      })
      .catch(function (err) {
        reject(err);
      });
  });
};

const DeleteUser = function (request, response) {
  return new Promise(function (resolve, reject) {
    const id = parseInt(request);
    if (!id) {
      reject("error: id missing");
    } else {
      pool
        .query("DELETE FROM users WHERE id = $1", [id])
        .then(function (results) {
          resolve(results.rows);
        })
        .catch(function (err) {
          reject(err);
        });
    }
  });
};

const getUserById = function (id) {
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

const getUserId = function (id) {
  return new Promise(function (resolve, reject) {
    pool
      .query("SELECT * FROM users where user_id = $1", [id])
      .then(function (results) {
        resolve(results.rows[0]);
      })
      .catch(function (err) {
        reject(err);
      });
  });
};

module.exports = {
  getUsers,
  getUserById,
  createUser,
  Updateuser,
  DeleteUser,
  getUserId,
};
