const UserService=require("../services/user.services");

exports.register=async(req,res,next)=>{
    try{
      const{username,email,password}=req.body;
      const user=await UserService.checkuser(email);
      if(user){
        res.status(409).json({status:409});
        return;
      }
      const successRes=await UserService.registerUser(username,email,password);
      res.json({status:200,success:"User Registered successfully"});
    }catch(error){
        throw error;
    }
}

exports.login=async(req,res,next)=>{
  try{
    const{email,password}=req.body;
    const user=await UserService.checkuser(email);
    if(!user){
      res.status(401).json({status:401});
      return;
    }
    const isMatch= await user.comparePassword(password);
    if(isMatch===false){
      //throw new Error('Password invalid');
      res.status(401).json({status:401});
      return;
    }

    let tokenData={_id:user._id, email:user.email};
    const token=await UserService.generateToken(tokenData,"secertKey",'1h');
    res.status(200).json({status:true, token:token});
  }catch(error){
      throw error;
  }
}