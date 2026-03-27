using {india.db.transaction} from '../db/datamodel';

service pofunction {
    entity Readbp as projection on transaction.purchaseorder;

    entity UpdatePo as projection on transaction.purchaseorder;
}

