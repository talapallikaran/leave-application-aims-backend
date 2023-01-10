const express = require("express");
const router = express.Router();
const adminControllers = require("../controllers/admin.users.controller");
// const pool = require("../../config");

router.get(
  "/userslist",
  adminControllers.listUser,
  (req, res) => {
    res.send(req.data);
  },
  (error, req, res, next) => {
    res.status(400).send({ error: error.message });
  }
);

router.post(
  "/setuserroles",
  adminControllers.setuserroles,
  (req, res) => {
    res.send(req.data);
  },
  (error, req, res, next) => {
    res.status(400).send({ error: error.message });
  }
);

module.exports = router;
