const pool = require("../../config");

const getleaves = function () {
  return new Promise(function (resolve, reject) {
    pool
      .query("SELECT * FROM leaves ORDER BY leave_id ASC ", [])
      .then(function (results) {
        resolve(results.rows);
      })
      .catch(function (err) {
        reject(err);
      });
  });
};

const getleaveByLeaveId = async function (id) {
  return await new Promise(async function (resolve, reject) {
    await pool
      .query("SELECT * FROM leaves where leave_id = $1", [id])
      .then(async function (results) {
        resolve(results.rows[0]);
      })
      .catch(function (err) {
        reject(err);
      });
  });
};

const getleaveByUserId = async function (id) {
  return new Promise(function (resolve, reject) {
    pool
      .query("SELECT * FROM leaves where user_id = $1", [id])
      .then(async function (results) {
        resolve(results.rows);
      })
      .catch(function (err) {
        reject(err);
      });
  });
};

const createleaves = function (request, response) {
  const status = 1;
  const { user_id, start_date, end_date, reason } = request;
  return new Promise(function (resolve, reject) {
    pool
      .query(
        "INSERT INTO leaves( user_id, start_date, end_date, reason, status)   VALUES ($1, $2, $3, $4, $5)",
        [user_id, start_date, end_date, reason, status]
      )
      .then(function (result) {
        resolve(result.rows[0]);
      })
      .catch(function (err) {
        reject(err);
      });
  });
};

const Deleteleave = function (request, response) {
  return new Promise(function (resolve, reject) {
    const id = parseInt(request);
    if (!id) {
      reject("error: id missing");
    } else {
      pool
        .query("DELETE FROM leaves WHERE leave_id = $1", [id])
        .then(function (results) {
          resolve(results.rows);
        })
        .catch(function (err) {
          reject(err);
        });
    }
  });
};

async function Updateleave(data) {
  const { leave_id, user_id, start_date, end_date, reason, status } = data;
  return new Promise(function (resolve, reject) {
    if (!leave_id.id) {
      console.log("error: id missing");
      reject("error: id missing");
    } else {
      pool
        .query(
          "UPDATE leaves SET   reason=$4  , status=$5 , start_date = $2, end_date = $3 , user_id=$6   WHERE leave_id = $1",
          [leave_id.id, start_date, end_date, reason, status, user_id]
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

async function UpdateleaveStatus(data) {
  const { leave_id, user_id, status } = data;
  return new Promise(function (resolve, reject) {
    if (!leave_id.id) {
      console.log("error: id missing");
      reject("error: id missing");
    } else {
      pool
        .query(
          "UPDATE leaves SET    status=$2 , leave_id=$3   WHERE user_id= $1",
          [user_id, status, leave_id.id]
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
  getleaves,
  createleaves,
  Deleteleave,
  Updateleave,
  getleaveByLeaveId,
  getleaveByUserId,
  UpdateleaveStatus,
};
