require("dotenv").config();

var Leave = require("../models/leave");
const auth = require("../helpers/auth");
const dateIsValid = require("../helpers/helper");

const listleave = function (req, res) {
  Leave.getleaves()
    .then(function (result) {
      return res.status(200).json(result);
    })
    .catch(function (err) {
      return res.status(400).json({
        message: err,
        statusCode: "400",
      });
    });
};

const listLeaveById = function (req, res) {
  const { id } = req.params;
  Leave.getleaveId(id)
    .then(function (result) {
      return res.status(200).json(result);
    })
    .catch(function (err) {
      return res.status(400).json({
        message: err,
        statusCode: "400",
      });
    });
};

const createLeave = (req, res, err) => {
  const { user_id, start_date, end_date, reason } = req.body;
  console.log(dateIsValid.dateIsValid(start_date));
  let tokanData = req.headers["authorization"];
  auth.AUTH(tokanData).then(async function (result) {
    if (result) {
      let test = false;
      if (result.id === user_id || test) {
        if (user_id && start_date && end_date && reason) {
          if (start_date <= end_date) {
            Leave.createleaves(req.body, result.user_id)
              .then(function (result) {
                return res.status(200).json({
                  status: "success",
                  statusCode: "200",
                  message: "success! created account for new user",
                });
              })
              .catch(function (err) {
                return res.status(400).json({
                  message: err,
                  statusCode: "400",
                });
              });
          } else {
            console.log("ashgfhgfhgfiujklkl");
            return res.status(400).json({
              message:
                "The end date is must be greter then or equl to start date",
              statusCode: "400",
            });
          }
        } else {
          return res.status(400).json({
            message: "user id or start date or end date or reason is missing  ",
            statusCode: "400",
          });
        }
      }
    } else {
      return res.status(402).json({
        message: "Authorization error",
        statusCode: "402",
      });
    }
  });
};

const deleteLeave = (request, response, error) => {
  const { id } = request.params;
  Leave.Deleteleave(id).then(function (result) {
    return response.status(200).json({
      status: "success",
      statusCode: "200",
      message: "success! user data deleted suucessfully",
    });
  });
};

const updateLeave = (req, res) => {
  Leave.Updateleave({
    leave_id: req.params,
    user_id: req.body.user_id,
    start_date: req.body.start_date,
    end_date: req.body.end_date,
    reason: req.body.reason,
    status: req.body.status,
  })
    .then(function (result) {
      return res.status(200).json({
        status: "success",
        statusCode: "200",
        message: "success! leave status  updated suucessfully",
      });
    })
    .catch(function (err) {
      return res.status(400).json({
        message: err,
      });
    });
};

const updateLeaveStatus = (req, res) => {
  const { leave_id, status, reporting_person } = req.body;
  let tokanData = req.headers["authorization"];
  auth
    .AUTH(tokanData)
    .then(async function (result) {
      if (result) {
        console.log(result.id, reporting_person);
        if (result.id === reporting_person) {
          Leave.UpdateleaveStatus({
            leave_id: req.body.leave_id,
            status: req.body.status,
          }).then(function (result) {
            return res.status(200).json({
              status: "success",
              statusCode: "200",
              message: "success! user data updated suucessfully",
            });
          });
        } else {
          return res.status(401).json({
            message: "Authorization error",
            statusCode: "401",
          });
        }
      } else {
        return res.status(402).json({
          message: "Authorization error",
          statusCode: "402",
        });
      }
    })
    .catch(function (err) {
      return res.status(400).json({
        message: err,
        statusCode: "400",
      });
    });
};

module.exports = {
  listleave,
  createLeave,
  deleteLeave,
  updateLeave,
  listLeaveById,
  updateLeaveStatus,
};
