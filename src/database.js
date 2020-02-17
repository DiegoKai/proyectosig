const express = require("express");
const oracledb = require("oracledb");
const bodyparse = require("body-parser");
const app = express();

app.use(express.urlencoded({extended: true})); 
app.use(express.json());   

/*app.use(bodyparse.json());

app.use(bodyparse.urlencoded({
    extend:true
}));*/
var connAttrs ={
    "user": "USR_ORACLE",
    "password": "oracle123",
    "connectString": "(DESCRIPTION =(LOAD_BALANCE = ON)(FAILOVER = ON)(ADDRESS =(PROTOCOL = TCP)(HOST = alvaro-VirtualBox)(PORT = 1521))(ADDRESS = (PROTOCOL = TCP)(HOST = alvaro-VirtualBox)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=XE)(FAILOVER_MODE=(TYPE=SELECT)(METHOD = BASIC))))"
}

/*oracledb.getConnection(connAttrs, function (err, connection) {
        
        connection.release(
            function (err) {
                if (err) {
                    console.error(err.message);
                    } else {
                        console.log("Conexion a la BD exitosa");
             }
        });
});*/

function error(err,rs,cn){
    if(err){
        console.log(err.message);
        //rs.contentType("application/json").status(500);
        //rs.send(err.message);
        if(cn!=null) close(cn);
        return -1;
    }else{
        console.log('entro');
        return 0;
    }
}

function open(sql, binds, dml,rs) {
    return new Promise((res, rej)=>{
        oracledb.getConnection(connAttrs)
        .then((cn)=>{
            cn.execute(sql, binds, {autoCommit: dml}).then((result)=>{
                if(dml){
                    res(SON.stringify(result.rowsAffected));
                }else{
                    res(JSON.stringify(result.rows));
                }
                close(cn);
            }).catch((err)=>{
                if(error(err, rs, cn)==-1) return;
            })
        }).catch((err)=>{
            if(error(err, rs, null)==-1) return;
        })
    })
 }

 function close(cn){
     cn.release(
         function(err){
             if(err){
                 console.log(err.message);
             }
         }
     );
 }

module.exports.open = open;
module.exports.close = close;
