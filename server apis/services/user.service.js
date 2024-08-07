const usermodel = require('../model/user.modal');
const jwt = require("jsonwebtoken");
const bcrypt = require("bcrypt");

class UserService{
   static async registerUser(number,firstname,lastname,gender,pass,email,bikenumber,licencenumber,dob,cat,deviceid,itemrating,itemuser){
        try{
            const creteuser = new usermodel({number,firstname,lastname,gender,pass,email,bikenumber,licencenumber,dob,cat,deviceid,itemrating,itemuser});
            return await creteuser.save();
        } catch(e){
            console.log(e)
            res.json({status:false,sucess:"server error service register"});
        }
   }

   static async checkuser(number){
    try{
        return await usermodel.findOne({number});
    } catch(e){
        console.log(e)
            res.json({status:false,sucess:"server error service chcekuser"});
    }
   }


   static async updateuser(number,firstname,lastname,bikenumber,licencenumber){
    try{
        return await usermodel.findOneAndUpdate({number},{$set:
            {firstname:firstname,lastname:lastname,bikenumber:bikenumber,licencenumber:licencenumber}});
    } catch(e){
        console.log(e)
            res.json({status:false,sucess:"server error service chcekuser"});
    }
   }

   static async getuser(){
    try{
        return await usermodel.find();
    } catch(e){
        console.log(e)
            res.json({status:false,sucess:"server error service chcekuser"});
    }
   }

   static async updatedevice(userId,deviceid){
    try{
        await usermodel.findByIdAndUpdate(userId, { $set: { deviceid: deviceid } });
    } catch(e){
        console.log(e)
            res.json({status:false,sucess:"server error service chcekuser"});
    }
   }


   static async forgetpassword(number,password){
    try{
        const salt = await bcrypt.genSalt(10);
        const hash = await bcrypt.hash(password, salt);
        await usermodel.findOneAndUpdate({number: number}, {$set: {password: hash}});
    } catch(e){
        console.log(e)
            res.json({status:false,sucess:"server error service chcekuser"});
    }
   }

   static async getoneuser(id){
    try{
        return await usermodel.findOne({number:id});
    } catch(e){
        console.log(e)
            res.json({status:false,sucess:"server error service chcekuser"});
    }
   }

   static async getoneuserdetailss(number,email){
    try{
        return await usermodel.findOne({number:number,email:email});
    } catch(e){
        console.log(e)
            res.json({status:false,sucess:"server error service chcekuser"});
    }
   }

   static async generateToken(tokenData,secretKey,jwt_expiry){
    return jwt.sign(tokenData,secretKey,{expiresIn:jwt_expiry});
   }

   static async updatedmenurating(id,itemrating){
    try {
        await usermodel.findByIdAndUpdate(id,{ $set: {itemrating:itemrating}});
    } catch(e) {
        console.log(e)
        res.json({status:false,sucess:"server error service chcekuser"});
    }
   }

   static async updatedmenuuser(id){
    try {
        const u = await usermodel.findById(id);
        u.itemuser = (parseInt(u.itemuser) + 1).toString();
        await usermodel.findByIdAndUpdate(id,{ $set: {itemuser:u.itemuser}});
    } catch(e) {
        console.log(e)
        res.json({status:false,sucess:"server error service chcekuser"});
    }
   }

}

module.exports = UserService;