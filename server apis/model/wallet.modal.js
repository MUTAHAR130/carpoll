const mongoose = require('mongoose');
const db = require('../config/db');

const { Schema } = mongoose;

const walletSchema = new Schema({
    number:{
        type:String,
    },
    notpay:{
        type:String,
    },
    paid:{
        type:String,
    },
    topup:{
        type:String,
    },
});

const walletModel = db.model('wallet',walletSchema);
module.exports = walletModel;