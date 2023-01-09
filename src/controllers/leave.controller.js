require("dotenv").config();

var Leave = require("../models/leave");
const auth = require("../helpers/auth");

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
  let tokanData = req.headers["authorization"];
  auth.AUTH(tokanData).then(async function (result) {
    if (result) {
      if (result.user_id === user_id) {
        if (user_id && start_date && end_date && reason) {
          Leave.createleaves(req.body)
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
        message: "success! user data updated suucessfully",
      });
    })
    .catch(function (err) {
      return res.status(400).json({
        message: err,
      });
    });
};

const updateLeaveStatus = (req, res) => {
  const { leave_id, user_id, status, reporting_person } = req.body;
  let tokanData = req.headers["authorization"];
  auth
    .AUTH(tokanData)
    .then(async function (result) {
      if (result) {
        if (result.user_id === user_id) {
          Leave.UpdateleaveStatus({
            leave_id: req.body.leave_id,
            user_id: req.body.user_id,
            status: req.body.status,
            reporting_person: req.body.reporting_person,
          }).then(function (result) {
            return res.status(200).json({
              status: "success",
              statusCode: "200",
              message: "success! user data updated suucessfully",
            });
          });
        } else {
          return res.status(402).json({
            message: "Authorization error",
            statusCode: "402",
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
