// routes/userRoutes.js
import express from "express";
const router = express.Router();
import auth from '../services/authentication.js';
import checkRole from '../services/checkRole.js';
import * as userController from '../controllers/userController.js';
router.post("/signup", userController.signup);
router.post("/login", userController.login);
router.post("/ForgotPassword", userController.forgotPassword);
router.get("/get", auth.authenticationToken, checkRole.checkRole, userController.getUsers);
router.patch("/update", auth.authenticationToken, checkRole.checkRole, userController.updateUser);
router.get("/checkToken", auth.authenticationToken, checkRole.checkRole, userController.checkToken);
router.post("/changePassword", auth.authenticationToken, userController.changePassword);

export default router;