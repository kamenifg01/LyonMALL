// routes/userRoutes.js
const express = require("express");
const router = express.Router();
const auth = require('../services/authentication');
const checkRole = require('../services/checkRole');
const userController = require('../controllers/userController');

router.post("/signup", userController.signup);
router.post("/login", userController.login);
router.post("/ForgotPassword", userController.forgotPassword);
router.get("/get", auth.authenticationToken, checkRole.checkRole, userController.getUsers);
router.patch("/update", auth.authenticationToken, checkRole.checkRole, userController.updateUser);
router.get("/checkToken", auth.authenticationToken, checkRole.checkRole, userController.checkToken);
router.post("/changePassword", auth.authenticationToken, userController.changePassword);

module.exports = router;
