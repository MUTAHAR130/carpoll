const mongoose = require('mongoose');
const db = require('../config/db');

const { Schema } = mongoose;

const serviceSchema = new Schema({
    number:{
        type:String,
    },
    cat:{
        type:String,  
    },
    lats:{
        type:String,
    },
    lons:{
        type:String,
    },
    late:{
        type:String,
    },
    lone:{
        type:String,
    },
    adds:{
        type:String,
    },
    adde:{
        type:String,
    },
    dis:{
        type:String,
    },
    ride:{
        type:String,
    },
    price:{
        type:String,
    },
    datetime:{
        type:String,
    },
    status:{
        type:String,
    },
    aspectedby:{
        type:String,
    },
});

const serviceModel = db.model('serviceSchema',serviceSchema);
module.exports = serviceModel;