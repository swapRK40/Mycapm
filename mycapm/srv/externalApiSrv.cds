using { india.db.ExternalData } from '../db/externalApiDatamodel';

service ExternalApiService {

    entity ExternalApi as projection on ExternalData;

}