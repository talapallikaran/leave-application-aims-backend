require("dotenv").config();

var User = require("../models/user");
var admin = require("../models/admin");
var Leave = require("../models/leave");
const jwt = require("jsonwebtoken");
const bcrypt = require("bcrypt");
const auth = require("../helpers/auth");
const formatDate = require("../helpers/helper");

const listUser = async function (req, res) {
  let tokanData = req.headers["authorization"];
  let count = 0;
  let data = [];
  let userData = [];
  auth
    .AUTH(tokanData)
    .then(async function (result) {
      if (result) {
        admin.getUsers().then(async function (result) {
          data = result;
          data.map((test) => {
            let user = {};
            Leave.getleaveByUserId(test.user_id).then(function (resss) {
              let count1 = 0;
              let leaveData = [];
              if (resss.length) {
                resss?.map((data) => {
                  let leave = {};
                  leave["leave_id"] = data?.leave_id;
                  leave["user_id"] = data?.user_id;
                  var start_date = formatDate.formatDate(
                    new Date(data?.start_date)
                  );
                  leave["start_date"] = start_date;
                  var end_date = formatDate.formatDate(
                    new Date(data?.end_date)
                  );
                  leave["end_date"] = end_date;
                  leave["reason"] = data?.reason;
                  leave["status"] = data?.status;
                  count1++;
                  leaveData.push(leave);
                });

                if (resss.length === count1) {
                  count++;
                }
              } else {
                count++;
                leaveData.push(resss);
              }
              user["id"] = test.id;
              user["name"] = test.name;
              var dob = formatDate.formatDate(new Date(test?.dob));
              user["dob"] = dob.split("-").reverse().join("-");
              user["phone"] = test.phone;
              user["reporting_person"] = test.reporting_person_uuid;
              user["reporting_person_name"] = test.reporting_person_name;
              user["leaves"] = Object.keys(resss).length ? leaveData : resss;
              userData.push(user);
              if (count === data.length) {
                return res.status(200).json(userData);
              }
            });
          });
        });
      } else {
        res.status(403).json({
          message: "Authorization error",
          statusCode: "402",
        });
      }
    })

    .catch(function (err) {
      return res.status(400).json({
        message: "Authorization error",
        statusCode: "402",
      });
    });
};

const listUserById = function (req, res) {
  const { id } = req.params;
  let tokanData = req.headers["authorization"];
  auth
    .AUTH(tokanData)
    .then(async function (result) {
      if (result) {
        User.getUserId(id).then(function (result) {
          return res.status(200).json(result);
        });
      } else {
        res.status(400).json({
          message: "Authorization error",
          statusCode: "401",
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

const createUser = (req, res, err) => {
  // let { id, name, email } = req.body;
  User.createUser(req.body)
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
};

const setuserroles = (req, res, err) => {
  // let { id, name, email } = req.body;
  admin
    .createUser(req.body)
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
};

const deleteUser = (request, response, error) => {
  const { id } = request.params;
  let tokanData = req.headers["authorization"];
  auth.AUTH(tokanData).then(async function (result) {
    if (result) {
      User.DeleteUser(id).then(function (result) {
        return response.status(200).json({
          status: "success",
          statusCode: "200",
          message: "success! user data deleted suucessfully",
        });
      });
    } else {
      return res.status(400).json({
        message: "Authorization error",
        statusCode: "402",
      });
    }
  });
};

const updateUser = (req, res) => {
  let tokanData = req.headers["authorization"];
  auth
    .AUTH(tokanData)
    .then(async function (result) {
      if (result) {
        User.Updateuser({
          user_id: req.params,
          role_id: req.body.role_id,
          name: req.body.name,
          email_id: req.body.email_id,
          phone: req.body.phone,
          id: req.body.id,
          dob: req.body.dob,
        }).then(function (result) {
          return res.status(200).json({
            status: "success",
            statusCode: "200",
            message: "success! user data updated suucessfully",
          });
        });
      } else {
        return res.status(400).json({
          message: err,
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
  listUser,
  listUserById,

  createUser,
  deleteUser,
  setuserroles,
  updateUser,
};
