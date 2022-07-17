
const mongoose  = require("mongoose");


// Npm install multer to add files
const userSchema = mongoose.Schema({
    displayName : { type : String } ,
    email : { type : String } ,
    password: { type : String },
    token : {type : String}
} );
const User = mongoose.model('User' , userSchema);
module.exports = User ;