using { india.db as my } from '../db/datamodel';

service NewCQLService {
    @readonly
    entity readEmployees as projection on my.Employees;

    @insertonly
entity insertEmployee as projection on my.Employees;
   
   @updateonly
entity updateEmployee as projection on my.Employees;

@deletonly
entity deleteEmployee as projection on my.Employees;
}

