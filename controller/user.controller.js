const UserService=require("../services/user.services");

exports.register=async(req,res,next)=>{
    try{
      const{username,email,password}=req.body;
      const successRes=await UserService.registerUser(username,email,password);
      res.json({status:true,succrss:"User Registered successfully"});
    }catch(error){
        throw error;
    }
}

exports.login=async(req,res,next)=>{
  try{
    const{email,password}=req.body;
    const user=await UserService.checkuser(email);
    if(!user){
      throw new Error('User dont exist');
    }
    const isMatch= user.comparePassword(password);
    if(isMatch===false){
      throw new Error('Password invalid');
    }

    let tokenData={_id:user._id, email:user.email};
    const token=await UserService.generateToken(tokenData,"secertKey",'1h');
    res.status(200).json({status:true, token:token});
  }catch(error){
      throw error;
  }
}