const users = require("./users");
const leave = require("./leave");
const express = require("express");
const router = express.Router();

// const api = new router();

router.get("/", function (req, res, next) {
  res.render("index", { title: "Express" });
});

router.use(users);
router.use(leave);

module.exports = router;
