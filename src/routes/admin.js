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
  "/users",
  adminControllers.createUser,
  async (req, res, next) => {
    res.send(req.data);
  },
  (error, req, res, next) => {
    res
      .status(400)
      .send({ message: error.message, status: "failed", statusCode: "400" });
  }
);

router.put(
  "/updateuserroles",
  adminControllers.updateuserroles,
  (req, res) => {
    res.send(req.data);
  },
  (error, req, res, next) => {
    res.status(400).send({ error: error.message });
  }
);

module.exports = router;
