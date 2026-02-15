using {india.db.transaction, india.db.master ,india.db as my} from '../db/datamodel' ;

service catalogService  @(requires: 'authenticated-user'){
    //@readonly//we have applied restriction on these service only get call allowed
    entity Employees
     @(restrict : [

  {
    grant : ['READ'],
    to : 'Viewer',
    where : 'Gender=$user.Gender'
  },

  {
    grant : ['READ', 'WRITE'],
    to : 'Admin',
  },

] )
as projection on my.Employees;

}


service Catalogservice @(path: 'CatalogServiceBTP') @(requires: 'authenticated-user'){
    entity businesspartner as projection on master.businesspartner;
    //below we have applied restriction on our service
    annotate Catalogservice.businesspartner with @(Capabilities: {
    InsertRestrictions: {Insertable: false},
    UpdateRestrictions: {Updatable: false},
    DeleteRestrictions: {Deletable: false},
  });

    entity product as projection on master.product;

    entity address as projection on master.address;
    annotate Catalogservice.address with @(Capabilities: {
    InsertRestrictions: {Insertable: true},
    UpdateRestrictions: {Updatable: true},
    DeleteRestrictions: {Deletable: true},
  });

    entity poitems as projection on transaction.poitems;
  annotate Catalogservice.poitems with @(Capabilities: {
    InsertRestrictions: {Insertable: true},
    UpdateRestrictions: {Updatable: true},
    DeleteRestrictions: {Deletable: true},
  });


    entity purchaseorder as projection on transaction.purchaseorder;
    annotate Catalogservice.purchaseorder with @(Capabilities: {
    InsertRestrictions: {Insertable: true},
    UpdateRestrictions: {Updatable: true},
    DeleteRestrictions: {Deletable: true},
  });

}


//Function highSal

@impl: './highSal.js'
service highSal {
  entity Employees as projection on my.Employees;
  function getHighestSalary()     returns Decimal(15, 2)
}


// Approve PO action
@impl: './approvePO.js'
service PurchaseService @(path: 'purchase') {
  entity PurchaseOrders as projection on transaction.purchaseorder;


  // an action that approves a purchase order, changes lifecycle status,
  // recalculates totals and returns a short message with the final status
  action ApprovePO(PO_ID: String) returns String;
}


// Action implementation
@impl: './incrementLogic.js'
service increment {
  entity Employees as projection on my.Employees;
  action hike(ID: UUID)

}


service CVsrv {
  entity BP_AD as projection on my.BP_AD;
  entity PO_PI as projection on my.PO_PI; 
}