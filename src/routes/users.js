const express = require("express");
const router = express.Router();
const userControllers = require("../controllers/users.controller");
// const pool = require("../../config");

router.get(
  "/users",
  userControllers.listUser,
  (req, res) => {
    res.send(req.data);
  },
  (error, req, res, next) => {
    res.status(400).send({ error: error.message });
  }
);

router.get(
  "/users/:id",
  userControllers.listUserById,
  (req, res) => {
    res.send(req.data);
  },
  (error, req, res, next) => {
    res.status(400).send({ error: error.message });
  }
);

router.post(
  "/login",
  userControllers.login,
  (req, res, next) => {
    res.send(req.data);
  },
  (error, req, res, next) => {
    res.status(400).send({ error: error.message });
  }
);

router.delete(
  "/users/:id",
  userControllers.deleteUser,
  (req, res, next) => {
    res.send(req.data);
  },
  (error, req, res, next) => {
    res.status(400).send({ error: error.message });
  }
);

router.put(
  "/edit/users/:id",
  userControllers.updateUser,
  (req, res, next) => {
    res.send(req.data);
  },
  (error, req, res, next) => {
    res.status(400).send({ error: error.message });
  }
);

router.put(
  "/reset/Password",
  userControllers.updatePassword,
  (req, res, next) => {
    res.send(req.data);
  },
  (error, req, res, next) => {
    res.status(400).send({ error: error.message });
  }
);

module.exports = router;
