const walletrmodel = require('../model/wallet.modal');

class walletService{
   static async registerwallet(number,notpay,paid,topup){
        try{
            const cretewallet = new walletrmodel({number,notpay,paid,topup});
            return await cretewallet.save();
        } catch(e){
            console.log(e)
            res.json({status:false,sucess:"server error service register"});
        }
   }

   static async getwallet(number){
    try{
        return await walletrmodel.findOne({number});
    } catch(e){
        console.log(e)
            res.json({status:false,sucess:"server error service chcekuser"});
    }
   }

   static async updatewallet(number,notpay,paid,topup){
    try{
        return await walletrmodel.findOneAndUpdate({number:number},
            {$set:{notpay:notpay,paid:paid,topup:topup}});
    } catch(e){
        console.log(e)
            res.json({status:false,sucess:"server error service chcekuser"});
    }
   }

}

module.exports = walletService;