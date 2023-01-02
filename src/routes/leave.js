const express = require("express");
const router = express.Router();
const userControllers = require("../controllers/leave.controller");
// const pool = require("../../config");

router.get(
  "/leave",
  userControllers.listleave,
  (req, res) => {
    res.send(req.data);
  },
  (error, req, res, next) => {
    res.status(400).send({ error: error.message });
  }
);

router.get(
  "/leave/:id",
  userControllers.listLeaveById,
  (req, res) => {
    res.send(req.data);
  },
  (error, req, res, next) => {
    res.status(400).send({ error: error.message });
  }
);

router.post(
  "/leave",
  userControllers.createLeave,
  async (req, res, next) => {
    res.send(req.data);
  },
  (error, req, res, next) => {
    res
      .status(400)
      .send({ message: error.message, status: "failed", statusCode: "400" });
  }
);

router.delete(
  "/leave/:id",
  userControllers.deleteLeave,
  (req, res, next) => {
    res.send(req.data);
  },
  (error, req, res, next) => {
    res.status(400).send({ error: error.message });
  }
);

router.put(
  "/edit/leave/:id",
  userControllers.updateLeave,
  (req, res, next) => {
    res.send(req.data);
  },
  (error, req, res, next) => {
    res.status(400).send({ error: error.message });
  }
);

router.put(
  "leave/updateLeaveStatus",
  userControllers.updateLeaveStatus,
  (req, res, next) => {
    res.send(req.data);
  },
  (error, req, res, next) => {
    res.status(400).send({ error: error.message });
  }
);

module.exports = router;
