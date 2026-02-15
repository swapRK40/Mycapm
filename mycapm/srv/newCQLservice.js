const cds = require('@sap/cds');
const { Employees } = cds.entities("india.db");

const NewCQLService = function (srv) {
  srv.on("READ", "readEmployees", async (req, res) => {
    var results = [];
    results = await cds.tx(req).run(SELECT.from(Employees).where({"FirstName":"Veer"}));
    return results
  })


// Inserting data in table according to passed payload:

srv.on("CREATE", "insertEmployee", async(req,res)=>{

    let returnData = await cds.transaction(req).run([
        INSERT.into(Employees).entries([req.data])
    ]).then((resolve,reject)=> {
        if (typeof(resolve) !== undefined){
            return req.data;
        }else{
            req.error(500, "There was as error!");
        }
    }).catch(err => {
        req.error(500, "below error occured" + err.toString());
    });
    return returnData;
});



//Update operation

srv.on("UPDATE", "updateEmployee", async(req,res)=>{

    let returnData = await cds.transaction(req).run([
        UPDATE(Employees).set({
            FirstName : req.data.FirstName
        }).where({ID:req.data.ID}),
    ]).then((resolve,reject)=> {
        if (typeof(resolve) !== undefined){
            return req.data;
        }else{
            req.error(500, "There was as error!");
        }
    }).catch(err => {
        req.error(500, "below error occured" + err.toString());
    });
    return returnData;
});


// Delete operation

srv.on("DELETE", "deleteEmployee", async(req,res)=>{
    let returnData = await cds.transaction(req).run([
        DELETE.from(Employees).where(req.data)
    ]).then((resolve,reject)=> {
        if (typeof(resolve) !== undefined){
            return req.data;
        }else{
            req.error(500, "There was as error!")
        }
    }).catch(err => {
        req.error(500, "below error occurred" + err.toString());
    });

    return returnData;
})


}


module.exports=NewCQLService
