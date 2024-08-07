const router = require('express').Router();
const walletController = require('../controller/wallet.controller');

router.post("/registerwallet",walletController.registerwallet);
router.post("/getwallet",walletController.getwallet);
router.post("/updatewallet",walletController.updatewallet);

module.exports = router;