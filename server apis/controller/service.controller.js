const service = require('../services/service.service');
const users = require('../services/user.service');

exports.registerservice = async(req,res,next)=>{
    try{
        const {number,cat,lats,lons,late,lone,adds,adde,dis,ride,price,datetime,status,aspectedby,itemrating,itemuser} = req.body;
        await service.registerservice(number,cat,lats,lons,late,lone,adds,adde,dis,ride,price,datetime,status,aspectedby,itemrating,itemuser);
        res.json({status:true,sucess:"service registered Sucessfully"});
    } catch (e){
        console.log(e)
        res.json({status:false,sucess:"server error controller register"});
    }
}

exports.getservice = async(req,res,next)=>{
    try{
        const {} = req.body;
        const numberdata = await service.getservice();
        const combinedData = [];
            for (const item of numberdata) {
                if (item.number !== undefined) {
                    const userdata = await users.checkuser(item.number);
                    combinedData.push({ number: item, user: userdata });
                }
            }
        res.status(200).json({message:combinedData});
    } catch (e){
        console.log(e)
        res.json({status:false,sucess:"server error controller mood"});
    }
}

exports.updatedservice = async(req,res,next)=>{
    try{
        const {number,cat,lats,lons,late,lone,adds,adde,dis,ride,price} = req.body;
        const numberdata = await service.updatedservice(number,cat,lats,lons,late,lone,adds,adde,dis,ride,price);
        res.json({status:true,sucess:"service update Sucessfully"});
    } catch (e){
        console.log(e)
        res.json({status:false,sucess:"server error controller mood"});
    }
}


exports.deleteservice = async(req,res,next)=>{
    try{
        const {id} = req.body;
        await service.deleteservice(id);
        res.json({status:true,sucess:"service delete Sucessfully"});
    } catch (e){
        console.log(e)
        res.json({status:false,sucess:"server error controller mood"});
    }
}


exports.updatestatus = async(req,res,next)=>{
    try{
        const {id,status} = req.body;
        await service.updatestatus(id,status);
        res.json({status:true,sucess:"service update Sucessfully"});
    } catch (e){
        console.log(e)
        res.json({status:false,sucess:"server error controller mood"});
    }
}


exports.updatedmenurating = async(req,res,next)=>{
    try{
        const {id,itemrating} = req.body;
        const rest = await users.updatedmenuuser(id);
        const rest1 = await users.updatedmenurating(id,itemrating);
        res.status(200).json({status:true,rest:rest,message:"update in sucessfully"});
    } catch (e){
        console.log(e)
        res.json({status:false,sucess:"server error controller login"});
    }
}