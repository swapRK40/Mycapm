namespace india.db ;


using {cuid, managed} from '../node_modules/@sap/cds/common' ;   //CUID aspect we use. automatically generates IDs and ID field - here we use for emp table, managed aspect will create extra coloumn

using {india.customAspect} from './customAspect' ;  //custom aspect used in purchaseorder table

entity Employees : cuid, managed{
    //key EmployeeID : String(50);- previous- we define UUID which will automatically create field, we have deleted ID field for these in emp table capm will automatcially create field with UUUID
    //key EmployeeID :UUID;   previous1 commneted beacuse we use aspects to geneate IDs field
    FirstName  :  String(50);
    LastName   :  String(50);
    Department :  String(50);
    Salary     :  Integer ;
    HireDate   :  Date ;
    phoneNumber : customAspect.phoneNumber;  // created these field for validation pf phonenumber
    Email: customAspect.Email;               // created these field for email validation
    Gender : String(20)
    
}


context master {
    
entity businesspartner {
       key NODE_KEY :String(100) @title : '{i18n>businesspartner.NODE_KEY}' ;   //we have done these labels for all fields these is for i18n to multi language when we view fields in browser
        BP_ROLE   :Integer @title : '{i18n>businesspartner.BP_ROLE}' ;
        EMAIL_ADDRESS : String(100) @title : '{i18n>businesspartner.EMAIL_ADDRESS}';
        PHONE_NUMBER : Integer @title : '{i18n>businesspartner.PHONE_NUMBER}' ;
        FAX_NUMBER	: Integer @title : '{i18n>businesspartner.FAX_NUMBER}'  ;
        WEB_ADDRESS	: String(100) @title : '{i18n>businesspartner.WEB_ADDRESS}' ;
       //ADDRESS_GUID_NODE_KEY : String(100);   ---previous1
       ADDRESS_GUID:Association to one address   @title : '{i18n>businesspartner.ADDRESS_GUID}';
        /* now we are defining association- we have ADDRESS_GUID AS association for association we have remove field name nodekey from address guid node key , it will automatically apeneded*/
        BP_ID	 : Integer @title : '{i18n>businesspartner.BP_ID}';
        COMPANY_NAME : String(100) @title : '{i18n>businesspartner.COMPANY_NAME}';
        

    }

entity  product {
       key NODE_KEY : String(100);
        PRODUCT_ID : String(100);
        TYPE_CODE : String(10);
        CATEGORY : String(50);
        //SUPPLIER_GUID_NODE_KEY : String(100); commented for association, we use association
        SUPPLIER_GUID : Association to one businesspartner;
        TAX_TARIF_CODE	: Integer ;
        MEASURE_UNIT	: String(2);
        WEIGHT_MEASURE	: Decimal;
        WEIGHT_UNIT	  : String(4);
        CURRENCY_CODE	: String(5);
        PRICE	: Decimal ;
        WIDTH	:Decimal;
        DEPTH	:Decimal;
        HEIGHT	:Decimal;
        DIM_UNIT : String(2) ;
       // DESCRIPTION : String(500); previous -commented for locallized to use multilanguage support
       DESCRIPTION :localized String(500);

    }
    entity address {
        key  NODE_KEY : String (100);
        CITY	: String(100);
        POSTAL_CODE	: Integer;
        STREET	: String(100);
        BUILDING	: Integer;
        COUNTRY	: String(10);
        ADDRESS_TYPE: Integer;
        VAL_START_DATE	:Integer;
        VAL_END_DATE	:Integer;
        LATITUDE	: Decimal;
        LONGITUDE : Decimal;
        businesspartner : Association to one businesspartner on businesspartner.ADDRESS_GUID=$self
        /* we have added busineesspartner association which is on businesspartner address_guid
        its nothing but our address table node key , thats why we have give $self*/

     }
}

context transaction  {
    
    entity purchaseorder : customAspect.Amount {
       key NODE_KEY : String (100);
        PO_ID: Integer;
       // PARTNER_GUID_NODE_KEY: String (100);
       PARTNER_GUID :Association to one master.businesspartner;
        LIFECYCLE_STATUS	: String(10);
        OVERALL_STATUS : String(10);
        Items : Association to many poitems on Items.PARENT_KEY = $self
        

    }
    entity poitems : customAspect.Amount {
        key NODE_KEY	:String(100);
        //PARENT_KEY_NODE_KEY : String(100);
        PARENT_KEY : Association to one purchaseorder;
        PO_ITEM_POS	: Integer;
        //PRODUCT_GUID_NODE_KEY: String(100)
        PRODUCT_GUID: Association to one master.product;

    }
}

@cds.persistence.exists 
@cds.persistence.calcview 
Entity BP_AD {
key     NODE_KEY: String(100)  @title: 'NODE_KEY: NODE_KEY' ; 
        BP_ROLE: Integer  @title: 'BP_ROLE: BP_ROLE' ; 
        EMAIL_ADDRESS: String(100)  @title: 'EMAIL_ADDRESS: EMAIL_ADDRESS' ; 
        PHONE_NUMBER: Integer  @title: 'PHONE_NUMBER: PHONE_NUMBER' ; 
        FAX_NUMBER: Integer  @title: 'FAX_NUMBER: FAX_NUMBER' ; 
        WEB_ADDRESS: String(100)  @title: 'WEB_ADDRESS: WEB_ADDRESS' ; 
        ADDRESS_GUID_NODE_KEY: String(100)  @title: 'ADDRESS_GUID_NODE_KEY: ADDRESS_GUID_NODE_KEY' ; 
        BP_ID: Integer  @title: 'BP_ID: BP_ID' ; 
        COMPANY_NAME: String(100)  @title: 'COMPANY_NAME: COMPANY_NAME' ; 
}


@cds.persistence.exists 
@cds.persistence.calcview 
Entity PO_PI {
key     CURRENCY_CODE: String(40)  @title: 'CURRENCY_CODE: CURRENCY_CODE' ; 
        GROSS_AMOUNT: Decimal(15)  @title: 'GROSS_AMOUNT: GROSS_AMOUNT' ; 
        NET_AMOUNT: Decimal(15)  @title: 'NET_AMOUNT: NET_AMOUNT' ; 
        TAX_AMOUNT: Decimal(15)  @title: 'TAX_AMOUNT: TAX_AMOUNT' ; 
key     NODE_KEY: String(100)  @title: 'NODE_KEY: NODE_KEY' ; 
        PO_ID: Integer  @title: 'PO_ID: PO_ID' ; 
key     PARTNER_GUID_NODE_KEY: String(100)  @title: 'PARTNER_GUID_NODE_KEY: PARTNER_GUID_NODE_KEY' ; 
key     LIFECYCLE_STATUS: String(10)  @title: 'LIFECYCLE_STATUS: LIFECYCLE_STATUS' ; 
key     OVERALL_STATUS: String(10)  @title: 'OVERALL_STATUS: OVERALL_STATUS' ; 
}