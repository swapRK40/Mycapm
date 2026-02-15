sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"mycapmfiori/test/integration/pages/purchaseorderList",
	"mycapmfiori/test/integration/pages/purchaseorderObjectPage",
	"mycapmfiori/test/integration/pages/poitemsObjectPage"
], function (JourneyRunner, purchaseorderList, purchaseorderObjectPage, poitemsObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('mycapmfiori') + '/test/flp.html#app-preview',
        pages: {
			onThepurchaseorderList: purchaseorderList,
			onThepurchaseorderObjectPage: purchaseorderObjectPage,
			onThepoitemsObjectPage: poitemsObjectPage
        },
        async: true
    });

    return runner;
});

