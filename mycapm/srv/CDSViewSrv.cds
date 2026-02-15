using { india.db.CDSViews as my} from '../db/cdsViews';

service CatalogservicCDS @(path: 'CDSViews'){
  entity ![PODetails]  as projection on my.PODetails;
  entity ![ItemView] as projection on my.ItemView; 
}