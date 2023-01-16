require("dotenv").config();

var User = require("../models/index");
const jwt = require("jsonwebtoken");
const bcrypt = require("bcrypt");
const auth = require("../helpers/auth");
const formatDate = require("../helpers/helper");
const formValidation = require("../helpers/helper");

const listUser = async function (req, res) {
  let tokanData = req.headers["authorization"];
  let count = 0;
  let data = [];
  let userData = [];

  auth
    .AUTH(tokanData)
    .then(async function (result) {
      if (result) {
        User.getUsers().then(async function (result) {
          data = result?.filter((test) => test.role_id !== 1);
          data.map((test) => {
            let user = {};
            User.getleaveByUserId(test.user_id).then(function (resss) {
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
              user["email"] = test.email_id;
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

const updateuserroles = (req, res) => {
  let { id, name, email, dob, phone, reporting_person } = req.body;

  let tokanData = req.headers["authorization"];

  auth

    .AUTH(tokanData)

    .then(async function (result) {
      if (result) {
        User.getUserByUUId(id).then(async function (resss) {
          User.getUserByUUId(reporting_person).then(async function (response) {
            User.updateUserRoles({
              reporting_person_id: response.user_id,
              user_id: resss.user_id,
              name: name,
              email_id: email,
              dob: dob,
              phone: phone,
            }).then(function (result) {
              return res.status(200).json({
                status: "success",
                statusCode: "200",
                message: "success! user data updated suucessfully",
              });
            });
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

const createUser = (req, res, err) => {
  let { reporting_person } = req.body;
  let reporting_id;
  let validation = formValidation.formValidation(req.body);
  if (!Object.keys(validation).length) {
    if (reporting_person) {
      User.getUserByUUId(reporting_person)
        .then(function (response) {
          reporting_id = response.user_id;
        })
        .then(function () {
          User.createUser(req.body, reporting_id)
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
        })
        .catch(function (error) {
          return error;
        });
    } else {
      admin
        .createUser(req.body, reporting_id)
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
    }
  } else {
    return res.status(400).json({
      message: validation,
      statusCode: "400",
    });
  }
};

module.exports = {
  listUser,
  updateuserroles,
  createUser,
};
