require("dotenv").config();

var User = require("../models/user");
var Leave = require("../models/leave");
var index = require("../models/index");
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
        User.getUsers().then(async function (result) {
          data = result?.filter((test) => test.role_id !== 1);
          data.map((test) => {
            let user = {};
            index.getleaveByUserId(test.user_id).then(function (resss) {
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
              user["reporting_person"] = test.reporting_person_uuid;
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

const login = (request, response) => {
  const { email, password } = request.body;
  User.isUserExists(email).then((isExists) => {
    if (!isExists) {
      return response.status(401).json({
        status: "failed",
        message: "Invalid email or password!",
        statusCode: "401",
      });
    }
    User.getUser(email).then(
      (user) => {
        bcrypt.compare(password, user.password, (error, isValid) => {
          if (error) {
            throw error;
          }
          if (!isValid) {
            return response.status(401).json({
              status: "failed",
              message: "Invalid email or password??!",
              statusCode: "401",
            });
          } else {
            const token = jwt.sign(
              {
                id: user.user_id,
              },
              process.env.API_SECRET,
              {
                expiresIn: 86400,
              }
            );
            const user_id = user.user_id;
            const id = user.id;
            const role_id = user.role_id;
            User.getUserSessionByUser_id(user_id).then(function (isExists) {
              if (!isExists) {
                User.createUserSession({ token, user_id, id }).then(
                  function () {
                    response.status(200).json({
                      status: "success",
                      statusCode: "200",
                      message: "Login Successfully!",
                      accessToken: token,
                      email: email,
                      user_id: id,
                      role_id: role_id,
                    });
                  }
                );
              } else {
                User.updateUserSession({ token, user_id }).then(function () {
                  response.status(200).json({
                    status: "success",
                    statusCode: "200",
                    message: "Login Successfully!",
                    accessToken: token,
                    email: email,
                    user_id: id,
                    role_id: role_id,
                  });
                });
              }
            });
          }
        });
      },

      (error) => {
        response.status(400).json({
          status: "failed",
          statusCode: "400",
          message: "Error while login.",
        });
      }
    );
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

const updatePassword = (req, res) => {
  let { email, oldPassword, newPassword } = req.body;
  User.getUser(email)
    .then((user) => {
      bcrypt.compare(oldPassword, user.password, (error, isValid) => {
        if (error) {
          throw error;
        }
        if (!isValid) {
          return res.status(401).json({
            status: "failed",
            message: "Invalid email or password??!",
            statusCode: "401",
          });
        } else {
          User.updatepassword({
            email_id: email,
            password: newPassword,
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
        }
      });
    })
    .catch(function (err) {
      return res.status(400).json({
        status: "failed",
        message: "Invalid email ",
        statusCode: "401",
      });
    });
};

module.exports = {
  listUser,
  listUserById,
  login,
  deleteUser,
  updateUser,
  updatePassword,
};
