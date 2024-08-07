const servicemodel = require('../model/service.modal');

class photoService{
   static async registerservice(number,cat,lats,lons,late,lone,adds,adde,dis,ride,price,datetime,status,aspectedby,itemrating,itemuser){
        try{
            const serverorder = new servicemodel({number,cat,lats,lons,late,lone,adds,adde,dis,ride,price,datetime,status,aspectedby});
            return await serverorder.save();
        } catch(e){
            console.log(e)
        }
   }

   static async getservice(){
    try{
        return await servicemodel.find();
    } catch(e){
        console.log(e)
    }
   }

   static async updatedservice(number,cat,lats,lons,late,lone,adds,adde,dis,ride,price){
    try {
        await servicemodel.findByIdAndUpdate(number,
             { $set: {cat:cat,lats:lats,lons:lons,late:late,lone:lone,
                adds:adds,adde:adde,dis:dis,ride:ride,price:price}});
    } catch(e) {
        console.log(e)
        res.json({status:false,sucess:"server error service chcekuser"});
    }
   }

   static async deleteservice(id){
    try{
        return await servicemodel.findByIdAndDelete(id);
    } catch(e){
        console.log(e)
    }
   }


   static async updatestatus(id,status){
    try{
        return await servicemodel.findByIdAndUpdate(id,{$set:{status:status}});
    } catch(e){
        console.log(e)
    }
   }

}

module.exports = photoService;