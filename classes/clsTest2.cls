public with sharing class clsTest2 {

        public clsTest2(){
            sID='5002w000004GvAqAAK';
            CA=[Select Id,Account1__c,Account2__c,Account3__c from Case where id=:sID Limit 1];
        }
        public String sID   {get;set;}
        public String sName {get;set;}
        public String sPhone{get;set;}
        public Case   CA    {get;set;}

        public void Do_Refresh(){
            CA=[Select Id,Account1__c,Account2__c,Account3__c from Case where id=:sID Limit 1];
        }
}