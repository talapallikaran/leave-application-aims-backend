const admin = require("./updateUserRoles");
const leave = require("./leave");
const createUser = require("./createUser");
const user = require("./user");
const getUsers = require("./getUsers");
const updateUserRoles = require("./updateUserRoles");
const getleaveByUserId = require("./getleaveByUserId");
const getUserByUUId = require("./getUserByUUId");

const express = require("express");

const router = express.Router();

module.exports = {
  user,
  admin,
  leave,
  createUser,
  getUsers,
  updateUserRoles,
  getleaveByUserId,
  getUserByUUId,
};
