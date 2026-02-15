const cds = require('@sap/cds');
module.exports = srv => {
    srv.on('getHighestSalary',async ()=>{
        try{
            const {Employees} = cds.entities('india.db');
            //fetch the Employees with highest salary
            const highestSalaryEmployee = await cds.run(SELECT.one `Salary as highestSalary` 
            .from(Employees)
            .orderBy `Salary DESC`
        );
        if( highestSalaryEmployee){
            return highestSalaryEmployee.highestSalary;
        } else {
            return null;
        }
        }catch (error){
            console.error('Error fetching highest Salary:' , error);
            return null;
        }
    })
}