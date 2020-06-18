/** ************************************
* Author     :   Alex Chen        
* Description:   Lib_Log : 
* Test Class :   Lib_Log_Test
* Function List:
    
    get_ErrMessageInfo
    add_PageMessage
    add_Log
    add_Exception    
  
* History
* <Date>        <Authors Name> 	<Brief Description of Change>
* 20200318        Alex Chen       Create
* 20200612        Alex Chen       Modify
* 流程改善- Git Study -Commit 3   => LIB_DB-Email-Log
************************************** */
public with sharing class Lib_Log {

    @InvocableMethod
	public static void Debug(List<String> sMessage_L){ System.debug('@InvocableMethod='+sMessage_L); }

    /** 
    List<String> ss=new List<String>{'aa','bb'};
    System.Debug(ss); 
    System.Debug('Hello');
    */
    public static void Debug(String sMessage){         
        // System.Debug(new List<String>{sMessage}); 
    }

    public static string get_ErrMessageInfo( Exception e ){                
        string      ret    =e.getMessage() + '  ( ' + Lib_String.to_String(e.getStackTraceString())  + '  )' ;   
        system.debug('*************************************************** Commlib.get_ErrMessageInfo:ret='+ret);     
        return ret;
    }
    /*
    * add_PageMessage
    */    
    public static ErrResponse_Info add_PageMessage( String sSource,String sSource_Function,Exception e        ,ApexPages.Severity severity ){        

        String      sBatch_Seq ;
        Integer     iDurationTime ;
        ErrResponse_Info ret =add_PageMessage(sSource,sSource_Function,e ,severity, sBatch_Seq,iDurationTime);       
        return ret;
    }    
    //4
    public static ErrResponse_Info add_PageMessage( String sSource,String sSource_Function,String sMessage    ,ApexPages.Severity severity){        
        String      sException_Type ;
        String      sBatch_Seq ;
        Integer     iDurationTime ;
        ErrResponse_Info ret =add_PageMessage(sSource,sSource_Function,sMessage,severity,sException_Type,sBatch_Seq,iDurationTime);  
        return ret;
    }     
    //
    public static ErrResponse_Info add_PageMessage( String sSource,String sSource_Function,Exception e        ,ApexPages.Severity severity, String sBatch_Seq,Integer iDurationTime){        
        //Modify by Alex on 20170802 for 抓到Exception 時,連同如同行數等詳細錯誤一起顯示
        //string      sMessage        =e.getMessage() ;
        //string      sMessage        =e.getMessage() + '  ( ' + Commlib.ToString(e.getStackTraceString())  + '  )' ;
        string      sMessage    =get_ErrMessageInfo(e);                                    
        ///////////////////////////////////////////////////////////////////////////
        String      sException_Type =e.getTypeName();        
        ErrResponse_Info ret =add_PageMessage(sSource,sSource_Function,sMessage,severity,sException_Type,sBatch_Seq,iDurationTime);  
        return ret;
    }
    //6
    public static ErrResponse_Info add_PageMessage(String sSource,String sSource_Function,String sMessage,ApexPages.Severity severity,String sException_Type ,String sBatch_Seq,Integer iDurationTime){
        transient list<String> sMessage_L=new list<String>{sMessage} ;
        ErrResponse_Info ret =add_PageMessage(sSource,sSource_Function,sMessage_L,severity,sException_Type ,sBatch_Seq,iDurationTime);    
        return ret;
    }
    //5
     public static ErrResponse_Info add_PageMessage( String sSource,String sSource_Function,List<String> sMsg_L,ApexPages.Severity severity,Boolean Is_Log ){        
        ErrResponse_Info ret=new ErrResponse_Info();
        try{
            for(String sMsg:sMsg_L){
                if(!String.isBlank(sMsg)){
                    ApexPages.Message msg = new ApexPages.Message(severity, sMsg);
                    ApexPages.addMessage(msg);
                }
            }
        }
        catch(exception ex){ }
        if(Is_Log==true){
            String sMessage=String.Join(sMsg_L ,' \n ');
            ret =add_Exception(sSource,sSource_Function,sMessage,severity,null);
        }
        return ret;        
    }      
    //7
    public static ErrResponse_Info add_PageMessage(String             sSource,
                                             String             sSource_Function,
                                             List<String>       sMsg_L,
                                             ApexPages.Severity severity,
                                             String             sException_Type ,
                                             String             sBatch_Seq,
                                             Integer            iDurationTime
    ){       
        ErrResponse_Info ret=new ErrResponse_Info();
        try{
            for(String sMsg:sMsg_L){
                if(!String.isBlank(sMsg)){
                    ApexPages.Message msg = new ApexPages.Message(severity, sMsg);
                    ApexPages.addMessage(msg);
                }
            }
        }
        catch(exception ex){ }
        String sMessage=String.Join(sMsg_L ,' \n ');
        ret =add_Exception(sSource,sSource_Function,sMessage,String.valueOf(severity),sException_Type,null,sBatch_Seq,iDurationTime);        
        return ret;
    }
    ////////////////////////////////////////////
    
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /*       
    2.與 add_Exception 的差別是 add_Exception 有回ErrResponse_Info, add_Log 沒回,且 add_Log 沒 sException_Type 的參數
    3.add_Log 會判斷LogSetting__c決定是否要寫log, add_Exception 則一定會加
    4.基本上都是採用5個參數(第一類), 6個參數的多是應用在 finally 且地6個參數都是丟true等同沒發揮作用
    */
    public static void add_Log(  String  sSource,
                                String  sSource_Function,
                                String  sMessage,
                                String  sDebug_Level,
                                String  sReference_Id ,
                                String  sBatch_Seq,
                                Integer iDurationTime
    ){
        try{            
            //LogSetting__c LS=    LogSetting__c.getInstance('Log');
            //if(LS.Active__c) {
                //String sException_Type ;
                //Exception_Log__c ExLog=getException(sSource,sSource_Function,sMessage,sDebug_Level,sException_Type,sReference_Id,sBatch_Seq,iDurationTime);                                            
                //insert ExLog;
                //system.debug('****************** Commlib.add_Log='+ExLog);
            //}            
        }        
        catch(exception ex){                
                system.debug('****************** Commlib.add_Log:exception='+ get_ErrMessageInfo(ex) ); 
        }       
    }
    public static void add_Log(String sSource,String sSource_Function,String sMessage,String sDebug_Level,String sReference_Id){
        add_Log( sSource, sSource_Function, sMessage, sDebug_Level, sReference_Id , null,null);
    }        
    //應該找機會優化: 6
    public static void add_Log(  String  sSource,
                                String  sSource_Function,
                                String  sMessage,
                                String  sDebug_Level,
                                String  sReference_Id ,
                                boolean bIsLog
    ){
        //System.debug('Start add_Log without Active');
        if(bIsLog){
            try{
                String  sBatch_Seq      ;
                Integer iDurationTime   ;
                //add_Exception(sSource,sSource_Function,sMessage,sDebug_Level, null, sReference_Id);
                add_Log(sSource,sSource_Function,sMessage,sDebug_Level,sReference_Id ,sBatch_Seq,iDurationTime);
            }
            catch(exception ex){                
                system.debug('****************** Commlib.add_Log:exception='+ get_ErrMessageInfo(ex) ); 
            }
       }
    }
    ////////////////////////////////////////////
    /**
    Parameter count:4
    */
    public static ErrResponse_Info add_Exception( String sSource,
                                            String sSource_Function,
                                            Exception e    ,
                                            ApexPages.Severity severity){
        String  sReference_Id ;
        String  sBatch_Seq ;
        Integer iDurationTime ;
        ErrResponse_Info ret =add_Exception(sSource,sSource_Function,e  , severity , sReference_Id , sBatch_Seq ,iDurationTime );
        return ret;
    }    
    /**
    Parameter count:5
    */
    public static ErrResponse_Info add_Exception( String sSource,
                                            String sSource_Function,
                                            String sMessage,
                                            ApexPages.Severity severity  ,
                                            String sException_Type){
        ErrResponse_Info ret =add_Exception(sSource,sSource_Function,sMessage ,String.valueOf(severity) , sException_Type );
        return ret;
    }
    public static ErrResponse_Info add_Exception( String sSource,String sSource_Function,String sMessage,String sDebug_Level          ,String sException_Type){
        ErrResponse_Info ret =add_Exception(sSource,sSource_Function,sMessage ,sDebug_Level             , sException_Type ,null );
        return ret;
    }
    /**
    Parameter count:6
    */
    public static ErrResponse_Info add_Exception( String sSource ,
                                            String sSource_Function ,
                                            String sMessage ,
                                            String sDebug_Level ,
                                            String sException_Type ,
                                            String sReference_Id
    ){
        ErrResponse_Info ret =add_Exception(sSource,sSource_Function,sMessage ,sDebug_Level             , sException_Type ,sReference_Id,null,null );        
        return ret;
    }
    /**
    Parameter count:7
    */
    public static ErrResponse_Info add_Exception( String      sSource,
                                            String      sSource_Function,
                                            Exception   e    ,
                                            ApexPages.Severity severity ,
                                            String      sReference_Id ,
                                            String      sBatch_Seq    ,
                                            Integer     iDurationTime
    ){
        //Modify by Alex on 20170802 for 抓到Exception 時,連同如同行數等詳細錯誤一起顯示
        //string      sMessage        =e.getMessage() ;
        //string      sMessage    =e.getMessage() + '  ( ' + Commlib.ToString(e.getStackTraceString())  + '  )' ;
        string      sMessage    =get_ErrMessageInfo(e);
        ErrResponse_Info ret =add_Exception(sSource,sSource_Function, sMessage   ,String.valueOf(severity) , e.getTypeName() ,sReference_Id , sBatch_Seq ,iDurationTime );
        return ret;
    }
    /**
    Parameter count:8
    */
    public static ErrResponse_Info add_Exception( String  sSource,
                                            String  sSource_Function,
                                            String  sMessage,
                                            String  sDebug_Level,
                                            String  sException_Type,
                                            String  sReference_Id,
                                            String  sBatch_Seq,
                                            Integer iDurationTime
    ){
        ErrResponse_Info ret=new ErrResponse_Info();
        try{            
            //Exception_Log__c ExLog=getException(sSource,sSource_Function,sMessage,sDebug_Level,sException_Type,sReference_Id,sBatch_Seq,iDurationTime);            
            //insert ExLog;
            //system.debug('*************************************************** Commlib.add_Exception:ExLog='+ExLog); 
        }
        catch(exception ex){
            //throw   ex;
            system.debug('*************************************************** Commlib.add_Exception:ExLog:exception='+ get_ErrMessageInfo(ex) ); 
        }
        finally{
        }
        if(String.isBlank(sException_Type)) sException_Type='APEX ERRR';
        ret.errorCode   =sException_Type;
        ret.message     =sMessage;
        return ret;
    }

    
    
    /*
    //Parameter count:7
    public static Exception_Log__c getException(String              sSource,
                                                String              sSource_Function,
                                                Exception           e    ,
                                                ApexPages.Severity  severity ,
                                                String              sReference_Id ,
                                                String              sBatch_Seq    ,
                                                Integer             iDurationTime
    ){
        string  sMessage=get_ErrMessageInfo(e);
        Exception_Log__c ret =getException(sSource, sSource_Function , sMessage , String.valueOf(severity) , e.getTypeName() , sReference_Id , sBatch_Seq , iDurationTime );
        return ret;
    }    
    //Parameter count:8        
    public static Exception_Log__c getException(String  sSource,
                                                String  sSource_Function,
                                                String  sMessage,
                                                String  sDebug_Level,
                                                String  sException_Type,
                                                String  sReference_Id,
                                                String  sBatch_Seq,
                                                Integer iDurationTime)
    {                    
        Exception_Log__c ExLog=new Exception_Log__c();
        ExLog.Source__c                                                         =sSource ;
        ExLog.Source_Function__c                                                =sSource_Function ;            
        if(sMessage.length() <= 131072){ExLog.Message__c                        =sMessage ;
        }else{ExLog.Message__c                                                  =sMessage.subString(0, 131072) ; }
        //ExLog.Message__c                                                      =sMessage ;
        ExLog.Debug_Level__c                                                    =sDebug_Level;
        if(!String.isBlank(sException_Type))    ExLog.Exception_Type__c         =sException_Type ;
        if(!String.isBlank(sReference_Id))      ExLog.Reference_Id__c           =sReference_Id ;
        //Add by Alex
        if(!String.isBlank(sBatch_Seq))         ExLog.Reference_Information__c  =sBatch_Seq ;
        if(iDurationTime!=null)                 ExLog.Timer__c                  =iDurationTime ;        
        return ExLog;            
    }
    */

}