 const cds = require('@sap/cds');

module.exports = cds.service.impl(function () {
  this.on('ApprovePO', async (req) => {
    const { PO_ID } = req.data;
    if (!PO_ID) throw req.error(400, 'PO_ID is required');

    // read PO directly in transaction
    const PO = await cds.transaction(req).run(
      SELECT.one.from('india.db.transaction.purchaseorder').where({ PO_ID })
    );
    if (!PO) throw req.error(404, `Purchase order not found: ${PO_ID}`);

    // guard: already approved
    if (PO.LIFECYCLE_STATUS === 'APPROVED') {
      return `Purchase order ${PO_ID} is already APPROVED`;
    }

    // load items directly in transaction
    const items = await cds.transaction(req).run(
      SELECT.from('india.db.transaction.poitems').where({ PARENT_KEY_NODE_KEY: PO.NODE_KEY })
    );

    // sum NET_AMOUNT with a simple loop
    let total = 0;
    for (const row of items) {
      total += Number(row.NET_AMOUNT || 0);
    }

    // business rule
    const newLifecycle = total > 2000 ? 'PENDING_APPROVAL' : 'APPROVED';
    const newOverall  = newLifecycle === 'APPROVED' ? 'OPEN' : 'AWAITING_APPROVAL';

    // update PO directly in transaction
    await cds.transaction(req).run(
      UPDATE('india.db.transaction.purchaseorder')
        .set({ LIFECYCLE_STATUS: newLifecycle, OVERALL_STATUS: newOverall })
        .where({ PO_ID })
    );

    return `Purchase order ${PO_ID} -> ${newLifecycle} (total=${total})`;
  });
});
