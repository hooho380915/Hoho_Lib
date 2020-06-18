public without sharing class AccountController {

    @AuraEnabled(cacheable=true)
    public static Account getAccountById( String recordId ) {
        Account ret;
        List<Account> retL=[  SELECT   Id , Name , Rating ,
                                    Phone , Site , Active__c
                                FROM Account 
                                Where Id =: recordId
                                WITH SECURITY_ENFORCED                                
                            ];
        if(retL.size()>0) ret=retL[0];
        return ret ;
    }

    @AuraEnabled(cacheable=true)
    public static Account getAccount() {
        Account ret;
        List<Account> retL=[  SELECT   Id , Name , Rating ,
                                    Phone , Site , Active__c
                                FROM Account                                 
                                WITH SECURITY_ENFORCED 
                                Limit 10
                            ];
        if(retL.size()>0) ret=retL[0];
        //
        return ret ;
    }

    @AuraEnabled(cacheable=true)
    public static List<Account> getAccountList() {
        Account ret;
        List<Account> retL=[  SELECT   Id , Name , Rating ,
                                    Phone , Site , Active__c
                                FROM Account                                 
                                WITH SECURITY_ENFORCED 
                                Limit 10
                            ];
        //
        return retL ;
    }
    
}