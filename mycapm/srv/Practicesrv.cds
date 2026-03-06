using {india.db.transaction} from '../db/datamodel' ;

@impl: './Practice1.js'
service practicepoints {
    entity Readbp as projection on transaction.purchaseorder;

    entity UpdatePO as projection on transaction.purchaseorder;
}
