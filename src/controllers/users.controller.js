require("dotenv").config();

var User = require("../models/user");
var Leave = require("../models/leave");

const listUser = async function (req, res) {
  let count = 0;
  let data = [];
  let leaveData = [];
  let userData = [];
  User.getUsers()
    .then(async function (result) {
      data = result;
      data.map((test) => {
        let user = {};

        Leave.getleaveByUserId(test.user_id).then(function (resss) {
          leaveData.push(resss);
          if (resss) {
            count++;
          }
          user["id"] = test.user_id;
          user["name"] = test.name;
          user["reporting_person"] = test.reporting_person;
          user["leaves"] = resss;
          userData.push(user);
          if (count === data.length) {
            return res.status(200).json(userData);
          }
        });
      });
    })
    .catch(function (err) {
      return res.status(400).json({
        message: err,
        statusCode: "400",
      });
    });
};

const listUserById = function (req, res) {
  const { id } = req.params;
  User.getUserId(id)
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

const deleteUser = (request, response, error) => {
  const { id } = request.params;

  User.DeleteUser(id).then(function (result) {
    return response.status(200).json({
      status: "success",
      statusCode: "200",
      message: "success! user data deleted suucessfully",
    });
  });
};

const updateUser = (req, res) => {
  User.Updateuser({
    user_id: req.params,
    role_id: req.body.role_id,
    name: req.body.name,
    email_id: req.body.email_id,
    phone: req.body.phone,
    id: req.body.id,
    dob: req.body.dob,
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

module.exports = {
  listUser,
  listUserById,
  createUser,
  deleteUser,
  updateUser,
};
