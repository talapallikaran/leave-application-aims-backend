const pool = require("../../config");
const bcrypt = require("bcrypt");

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
async function isUserExists(email) {
  return new Promise((resolve) => {
    pool.query(
      "SELECT * FROM users WHERE email_id = $1",
      [email],
      (error, results) => {
        if (error) {
          throw error;
        }

        return resolve(results.rowCount > 0);
      }
    );
  });
}

const createUser = function (request, response) {
  const { role_id, name, email_id, phone, dob, password } = request;
  return new Promise(function (resolve, reject) {
    hashPassword(password)
      .then(function (hash) {
        return pool.query(
          "INSERT INTO users ( role_id, name, email_id, phone, dob , password ) VALUES ($1, $2 ,$3 ,$4 , $5 ,$6 )",
          [role_id, name, email_id, phone, dob, hash]
        );
      })
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
      .query("SELECT * FROM users where user_id = $1", [id])
      .then(function (results) {
        resolve(results.rows[0]);
      })
      .catch(function (err) {
        reject(err);
      });
  });
};

async function getUser(email, uuid) {
  return new Promise((resolve) => {
    pool.query(
      "SELECT * FROM users WHERE email_id = $1 ",
      [email],
      (error, results) => {
        if (error) {
          throw error;
        }

        return resolve(results.rows[0]);
      }
    );
  });
}

const getUserSessionByUser_id = function (id) {
  return new Promise(function (resolve, reject) {
    pool
      .query("SELECT * FROM user_session where user_id = $1", [id])
      .then(function (results) {
        resolve(results.rows[0]);
      })
      .catch(function (err) {
        reject(err);
      });
  });
};

const createUserSession = function (request, response) {
  const { token, user_id } = request;
  return new Promise(function (resolve, reject) {
    pool
      .query(
        "INSERT INTO public.user_session( token, user_id  )  VALUES ( $1, $2);",
        [token, user_id]
      )
      .then(function (result) {
        resolve(result.rows[0]);
      })
      .catch(function (err) {
        reject(err);
      });
  });
};

const updateUserSession = function (data) {
  const { token, user_id } = data;
  return new Promise(function (resolve, reject) {
    if (!user_id) {
      console.log("error: id missing");
      reject("error: id missing");
    } else {
      pool
        .query(
          "UPDATE public.user_session SET  token=$2     WHERE user_id=$1;",
          [user_id, token]
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

module.exports = {
  getUser,
  getUsers,
  getUserById,
  createUser,
  Updateuser,
  DeleteUser,
  getUserId,
  isUserExists,
  createUserSession,
  getUserSessionByUser_id,
  updateUserSession,
};

// Name : Sarthak Sarvaiya
// Job Title : Trainee
// Team Leader Name : Nayan Thakor, Karan Talapali
// Leave Type : Causal Leave
// Reason for leaving: I want to inform you that my colleage exam is going to start in the january. So to prepare for the exam, I want to take a break from my job.
// Work plan during your absence: I confirmed with my TL and i will manage my padding work after rejoining.
// Leave Date : 4 January To 5 January , 11 January to 12 January , 17 January to 18 January

// Thank you
// Sarthak Sarvaiya

// Subject : Leave Request on <Date> i.e 5th Sept 2022 Monday

// Name :
// Job Title:
// Team Leader Name :
// Project Manager Name :
// Leave Type :
// Reason for leaving:
// Work plan during your absence:
// Leave Date : <Date> (i.e. 5th Sept 2022 Monday)

// Thank you
// <Name of Person>

// Example :

// Subject : Leave Request on 5th Sept 2022 Monday

// Name : John Sinha
// Job Title : Sr. Web Developer
// Team Leader Name : Rajesh Prajapati
// Project Manager Name : Anant Prajapati
// Leave Type(CL/SL/UL) : Causal Leave
// Reason for leaving: going to outside with family
// Work plan during your absence: I confirmed with my PM/TL and they will manage work in my absence.
// Leave Date : 5th Sept 2022 Monday

// Thank you
// John Sinha
