/** *************************************
* Author     :   Alex Chen        
* Description:   Lib_Utility : 
* Test Class :   
* History
* <Date>   		<Authors Name> 	<Brief Description of Change>
* 20200319      Alex Chen       Modify
************************************** */
public without sharing class Lib_Utility {

    /*
    System.deubg( Lib_Utility.Sleep(1000) );
    */
    public static void Sleep(Integer SleepMillisecond) {
        System.debug('** Start Sleep');
        Long startTime  = DateTime.now().getTime();
        Long finishTime = DateTime.now().getTime();
        while ((finishTime - startTime) < SleepMillisecond) {
            finishTime = DateTime.now().getTime();
        }
        System.debug('** End Sleep');
    }
    /*
    *
    */
    public static string GenActiveCode(integer iSize){
        List<String> baseCodeL = new List<String> { 'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z','0','1','2','3','4','5','6','7','8','9','a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z'};
        string ret='';
        for(integer i=0;i<iSize;i++){
            Integer iIndex = Math.floor(Math.random()* (baseCodeL.size())).intValue() ;
            ret+=baseCodeL[iIndex];
        }        
        return ret;
    }
    // System.debug( Lib_Utility.GUID() ) ;
    public static string GUID(){
        String ret=GUID('');
        return ret;
    }
    //因為排序問題,所以將前置詞放到中間
    // Lib_Utility.GUID('hoho');
    public static string GUID(String sMid){
        if(!String.isBlank(sMid)) sMid='_' + sMid ;
        //Mark by Alex on 20190226 => 這個時間表達方式不夠友善
        //String ret=String.valueOf(Datetime.now().getTime()) + sMid +'_'+ GenActiveCode(4);
        String ret=Datetime.now().format('YYYYMMddHHmmssSS') + sMid +'_'+ GenActiveCode(4);
        return ret;
    }

   
    public static List<String> SetToList(Set<String> s) {
		transient List<String> ret=new List<String>();
		if (s.size()>0) ret.addAll(s);
		return ret;
	}
   
    public static Approval.ProcessResult Do_Approval(String sId)
    {
        // Create an approval request for the Request_Form__c
        Approval.ProcessResult result;
        Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
        req1.setObjectId(sId);
        // Submit the approval request for the account
        //Approval.ProcessResult result = Approval.process(req1);
        result = Approval.process(req1);
        return result ;
        //
    }

    
   
}