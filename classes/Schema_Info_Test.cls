/* *************************************
* Author:        
* Company:       Fiti
* Description:   Schema_Info_Test : 
* Test to Class: Schema_Info
* History
* <Date>   		<Authors Name> 	<Brief Description of Change>
* 20200110  	Alex			Create  
************************************** */
@isTest
private class Schema_Info_Test {
    
    @TestSetup    
    static void Create_Test_Data(){   
    }

    @IsTest
    static void Test_getRecordType_Name_ID_M(){   
        Opportunity obj=new Opportunity();            
        Map<string,string> ret   = Schema_Info.RecordType_Name_ID_M(obj,true);
        System.debug(ret);  
        Map<string,string> ret1  = Schema_Info.RecordType_Name_ID_M('Lead',true);
        System.debug(ret1);  
    }

    @IsTest
    static void Test_getRecordType_APIName_ID_M(){   
        Opportunity obj=new Opportunity();            
        Map<string,string> ret   = Schema_Info.RecordType_API_ID_M(obj,true);
        System.debug(ret);
        Map<string,string> ret1  = Schema_Info.RecordType_API_ID_M('Account',true);
        System.debug(ret1);
    }

    /*
    @IsTest
    static void Test_getDescribeSObjectResult(){   
        Account obj=new Account();            
        Schema.DescribeSObjectResult        sr      = Schema_Info.getDescribeSObjectResult(obj);
        System.debug(sr); 
        Schema.DescribeSObjectResult        sr1     = Schema_Info.getDescribeSObjectResult('Case');
        System.debug(sr1);  
    }
    */
   

    @IsTest
    static void Test_getKeyPrefix(){   
        System.debug(Schema_Info.getKeyPrefix('Account')) ;
    }
   
   
     
}