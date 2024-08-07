const mongoose = require('mongoose');
const bcrypt = require("bcrypt");
const db = require('../config/db');

const { Schema } = mongoose;

const userSchema = new Schema({
    number:{
        type:String,
        require:true,
        unique:true,
    },
    firstname:{
        type:String,
        require:true
    },
    lastname:{
        type:String,
        require:true
    },
    gender:{
        type:String,
        require:true
    },
    pass:{
        type:String,
        require:true
    },
    email:{
        type:String,
        require:true
    },
    bikenumber:{
        type:String,
        require:true
    },
    licencenumber:{
        type:String,
        require:true
    },
    dob:{
        type:String,
        require:true
    },
    cat:{
        type:String,
        require:true
    },
    deviceid:{
        type:String,
        require:true
    },
    itemrating:{
        type:String,
    },
    itemuser:{
        type:String,
    },
});

userSchema.pre("save",async function(){
    try{
        var user = this;
        const salt = await bcrypt.genSalt(10);
        const hash = await bcrypt.hash(user.pass,salt);
        user.pass = hash;
    } catch(e){
        throw e;
    }
})

userSchema.methods.comparePassword = async function(userpassword){
    try{
        const isMatch = await bcrypt.compare(userpassword,this.pass);
        return isMatch;
    } catch(e){
        throw e;
    }
}

const UserModel = db.model('user',userSchema);
module.exports = UserModel;
