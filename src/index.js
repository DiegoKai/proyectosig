const express = require('express');
const app = express();
const path = require('path');
const morgan = require('morgan');


require("./database");

//configuraciones
app.set('port',process.env.PORT || 3000);
app.set('views',path.join(__dirname,'views'));
app.engine('html',require('ejs').renderFile);
app.set('view engine', 'ejs');

//middlewares
app.use(morgan('dev'));
app.use(express.urlencoded({extended:false}));
app.use(express.json());

//variables globales
app.use((req, res ,next)=>{
    next();
});

//routes
app.use(require('./routes/rutas'));
app.use(require('./routes/autenticacion'));
//app.use(require('./routes/aplicacion'));
app.use('/aplicacion',require('./routes/aplicacion'));

//static files public
app.use(express.static(path.join(__dirname,'public')));

//Puerto escuchando
app.listen(app.get('port'), ()=>{
    console.log('Servidor corriendo en el puerto', app.get('port'));
});