const User = require('../models/user');
const bcrypt = require('bcryptjs');
const jwt = require("jsonwebtoken");

const register = (req , res ,next )=> {
    
    const hash = bcrypt.hashSync(req.body.password, 10);
   let user = new User ({
        displayName : req.body.displayName ,
        email : req.body.email ,
        password : hash  ,
    })
    user.save().then( user=> {res.status(201).send(user)
        res.json({
            message : 'User Added Succesfully ',
            
        })
    }
      
    ).catch(error=> {
        res.json({
            message : 'Error Occur adding user'
        })
    }
      )

}
const signin =async (req ,res ,next )=> {
    const email = req.body.email ;
    const password = req.body.password ;
   User.findOne({$or:[{'email':email } ] }).then( user=> {
        if (user){
            console.log(password);
            console.log(user.password);
          
           if( bcrypt.compare(password,user.password)){
           
            
                let token = jwt.sign({name:user.displayName ,email:user.email } ,'verySecretValue1999@lmogaaet-') 
                res.json({
                    message : 'Sign In succesfully ',
                    token :token
                    
                });
                console.log("Succesful sign in")
            
        }}else {
            res.json({
                message : 'No user found'
            })
            console.log("no USer fOUND")
        }
    })
   /* const user1 =  User.findOne({$or:[{'email':email } ] });
    console.log(user1.password)
    if(await bcrypt.compare(password,user1.password)){
        let token = jwt.sign({name:user1.displayName ,email:user1.email } ,'verySecretValue1999@lmogaaet-') 
        res.json({
            message : 'Sign In succesfully ',
            token :token
            
        });
        console.log("Succesful sign in")
    }*/
}




module.exports = {register ,signin} 