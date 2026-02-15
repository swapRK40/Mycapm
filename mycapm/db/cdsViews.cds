namespace india.db;

using {india.db.master ,india.db.transaction  } from './datamodel';

context CDSViews{
    define view ![PODetails] as select from transaction.purchaseorder{
      key PO_ID as ![PurchaseOrders],
      PARTNER_GUID.BP_ID as ![VendorID],
      PARTNER_GUID.COMPANY_NAME as ![CompanyName],
      GROSS_AMOUNT  as ![POGrossAmount],
      CURRENCY_CODE as ![POCurrency],
      key Items.PO_ITEM_POS as ![ItemPosition],
      Items.PRODUCT_GUID.PRODUCT_ID as ![ProductID],
      Items.PRODUCT_GUID.DESCRIPTION as ![ProductDescription],
      PARTNER_GUID.ADDRESS_GUID.CITY as ![City],
      PARTNER_GUID.ADDRESS_GUID.COUNTRY as ![Country],
      Items.GROSS_AMOUNT as ![ItemGrossAmount],
      Items.NET_AMOUNT as ![ItemNetAMount]


    }


    // Item View //
    /* 
    This view was created for learning purpose
    */

    define view ![ItemView] as select from transaction.poitems {
       key PARENT_KEY.PARTNER_GUID.NODE_KEY as ![Vendor],
       PRODUCT_GUID.NODE_KEY as ![ProductID],
        CURRENCY_CODE as ![CurrencyCode],
        NET_AMOUNT as ![NetAmount],
        TAX_AMOUNT as ![TaxAmount],
        PARENT_KEY.OVERALL_STATUS as ![POStatus]

}

}
