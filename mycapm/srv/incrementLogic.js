module.exports = cds.service.impl(async function() {
    const { Employees } = this.entities;

    this.on('hike', async req => {
        const { ID } = req.data;
        if (!ID) {
            return req.reject(400, 'ID is required');
        }
    

        console.log(`Received request to increment salary for Employees with ID: ${ID}`);

        // Start a new transaction
        const tx = cds.transaction(req);

        try {
            // Retrieve the current salary amount of the Employees
            const Employeess = await tx.read(Employees).where({ ID: ID });

            if (!Employeess || Employeess.length === 0) {
                await tx.rollback();
                return req.reject(404, `Employees with ID ${ID} not found.`);
            }

            const currentSalary = Employeess[0].Salary;
            console.log(`Current salary of Employees with ID ${ID} is ${currentSalary}`);

            // Perform the update operation to increment Salary by 20000
            const result = await tx.update(Employees)
                .set({ Salary: currentSalary + 20000 })
                .where({ ID: ID });

            if (result === 0) {
                await tx.rollback();
                return req.reject(500, 'Failed to update salary');
            }

            console.log(`Salary of Employees with ID ${ID} incremented by 20000`);

            // Retrieve the updated Employees within the same transaction before committing
            const updatedEmployees = await tx.read(Employees).where({ ID: ID });

            if (!updatedEmployees || updatedEmployees.length === 0) {
                await tx.rollback();
                return req.reject(500, 'Failed to retrieve updated Employees');
            }

            // Commit the transaction
            await tx.commit();

            console.log(`Updated Employees with ID ${ID} retrieved successfully`);

            return req.reply({ message: "Incremented", Employees: updatedEmployees[0] });
        } catch (error) {
            // Rollback the transaction in case of error
            console.error("Error during hike action:", error);
            try {
                await tx.rollback();
            } catch (rollbackError) {
                console.error("Rollback failed:", rollbackError);
            }
            return req.reject(500, `Error: ${error.message}`);
        }
    });
});
