const express = require('express');
const mongoose = require('mongoose');
const bodyParser = require('body-parser');
const morgan = require('morgan');
const userRoute = require('./routes/user_route');

var app = express();
mongoose.connect('mongodb+srv://hamza:hamza@cluster0.6hmsv.mongodb.net/?retryWrites=true&w=majority');
const connection = mongoose.connection ;
// Mongooose Erroor 

connection.on("error" ,() => {
    console.log('Mongoose Connection Failed')
})

/// Mongooose connection
connection.once('open', ()=> {console.log('Connected to mongoose')});


///////
app.use(morgan('dev'));
app.use([bodyParser.urlencoded({ extended: true}) ,bodyParser.json()]);

app.use('/',userRoute)
const Port = process.env.PORT || 3000 ;
app.listen( Port,()=> {
    console.log('Connected To Server '+Port);
});
module.exports = app;