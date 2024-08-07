const router = require('express').Router();
const serviceController = require('../controller/service.controller');

router.post("/registerservice",serviceController.registerservice);
router.post("/getservice",serviceController.getservice);
router.post("/updatedservice",serviceController.updatedservice);
router.post("/deleteservice",serviceController.deleteservice);
router.post("/updatestatus",serviceController.updatestatus);
router.post("/updatedmenurating",serviceController.updatedmenurating);

module.exports = router;