const cds = require('@sap/cds');
const { SELECT } = require('@sap/cds/lib/ql/cds-ql');

module.exports = srv => {

    const { purchaseorder } = cds.entities('india.db.transaction');

    srv.on('READ', 'Readbp', async (req) => {
        const Bp_ID = req.data.NODE_KEY;
        let result = await cds.tx(req).run(SELECT.from(purchaseorder).where({ NODE_KEY: Bp_ID }));

        return result;

    }
    );


    //Updater

    srv.on('update', 'UpdatePO', async (req) => {

        try {

            const affectrows = await cds.tx(req).run(update(purchaseorder).set({ LIFECYCLE_STATUS: req.data.LIFECYCLE_STATUS }).where
                ({ NODE_KEY: req.data.NODE_KEY }));

            //If record does not exist
            if (affectrows === 0) {
                req.error(404, `Purchase order ID Not found : ${req.data.NODE_KEY}`);

            }

            return req.data;
        }

        catch (err) {
            req.error(500, `Error while updating PO_ID : ${err.data}`);
        }

    }


    );




}