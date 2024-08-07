const UserService = require('../services/user.service');

exports.register = async(req,res,next)=>{
    try{
        const {number,firstname,lastname,gender,pass,email,bikenumber,licencenumber,dob,cat,deviceid,itemrating,itemuser} = req.body;
        const response = await UserService.registerUser(number,firstname,lastname,gender,pass,email,
            bikenumber,licencenumber,dob,cat,deviceid,itemrating,itemuser);
        res.json({status:true,sucess:"User registered Sucessfully"});
    } catch (e){
        console.log(e)
        res.json({status:false,sucess:"server error controller register"});
    }
}


exports.login = async(req,res,next)=>{
    try{
        const {number,pass,deviceid} = req.body;
        
        const user = await UserService.checkuser(number);
        if(!user){
            res.status(200).json({status:false,message:"no user found"});
        } else{

            const isMatch = await user.comparePassword(pass);
            if(isMatch == false){
                res.status(200).json({status:false,message:"invalid password"});
            } else{
                await UserService.updatedevice(user._id, deviceid);
                let tokenData = {user};
                const token = await UserService.generateToken(tokenData,"bikepool","1h")
                res.status(200).json({status:true,token:token,message:"login in sucessfully"});
            }
        }
    } catch (e){
        console.log(e)
        res.json({status:false,sucess:"server error controller login"});
    }
}


exports.getuser = async(req,res,next)=>{
    try{
        const user = await UserService.getuser();
        res.status(200).json({status:true,data:user});
    } catch (e){
        console.log(e)
        res.json({status:false,sucess:"server error controller login"});
    }
}

exports.getoneuser = async(req,res,next)=>{
    try{
        const {id} = req.body;
        const user = await UserService.getoneuser(id);
        res.status(200).json({status:true,data:user});
    } catch (e){
        console.log(e)
        res.json({status:false,data:{}});
    }
}

exports.updateuser = async(req,res,next)=>{
    try{
        const {number,firstname,lastname,bikenumber,licencenumber} = req.body;
        await UserService.updateuser(number,firstname,lastname,bikenumber,licencenumber);
        res.status(200).json({status:true});
    } catch (e){
        console.log(e)
        res.json({status:false});
    }
}

exports.forgetpassword = async(req,res,next)=>{
    try{
        const {number,password,email} = req.body;
        const a = await UserService.getoneuserdetailss(number,email);
        if(!a){
            res.status(200).json({status:false,message:"no user found"});
        } else {
            await UserService.forgetpassword(number,password,email);
            res.status(200).json({status:true,message:"password update in sucessfully"});
        }
    } catch (e){
        console.log(e)
        res.json({status:false,sucess:"server error controller login"});
    }
}

