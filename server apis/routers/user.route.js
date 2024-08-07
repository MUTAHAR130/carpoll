const router = require('express').Router();
const userController = require('../controller/user.controller');

router.post("/register",userController.register);
router.post("/login",userController.login);
router.post("/getuser",userController.getuser);
router.post("/getoneuser",userController.getoneuser);
router.post("/updateuser",userController.updateuser);
router.post("/forgetpassword",userController.forgetpassword);

module.exports = router;
