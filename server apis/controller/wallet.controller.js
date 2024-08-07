const walletService = require('../services/wallet.service');

exports.registerwallet = async(req,res,next)=>{
    try{
        const {number,notpay,paid,topup} = req.body;
        const response = await walletService.registerwallet(number,notpay,paid,topup);
        res.json({status:true,sucess:"wallet registered Sucessfully"});
    } catch (e){
        console.log(e)
        res.json({status:false,sucess:"server error controller register"});
    }
}

exports.getwallet = async(req,res,next)=>{
    try{
        const {number} = req.body;
        const rest = await walletService.getwallet(number);
        if(!rest){
            res.status(200).json({status:false,message:"no order found"});
        } else{
            res.status(200).json({status:true,rest:rest,message:"order founded"});
        }
    } catch (e){
        console.log(e)
        res.json({status:false,sucess:"server error controller login"});
    }
}

exports.updatewallet = async(req,res,next)=>{
    try{
        const {number,notpay,paid,topup} = req.body;
        const rest = await walletService.updatewallet(number,notpay,paid,topup);
        if(!rest){
            res.status(200).json({status:false,message:"no order found"});
        } else{
            res.status(200).json({status:true,rest:rest,message:"order founded"});
        }
    } catch (e){
        console.log(e)
        res.json({status:false,sucess:"server error controller login"});
    }
}