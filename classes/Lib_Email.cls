/** ************************************
* Author     :   Alex Chen        
* Description:   Lib_Email : 
* Test Class :   Lib_Email_Test
* Function List:
    
    get_SingleEmailMessage
    get_EmailL_To_JSON_L
    send_EMail
    send_EMails_ByJSONL    
    send_EMails_With_future
    send_EMails_By_JSON

* History
* <Date>        <Authors Name> 	<Brief Description of Change>
* 20200318        Alex Chen       Create
* 20200612        Alex Chen       Modify
* 流程改善- Git Study -Commit 3   => LIB_DB-Email-Log
************************************** */
public without sharing class Lib_Email {

    public static boolean send_EMail(string strSubject, string strHtmlBody,string[] toAddresses)
    {
        boolean ret=true;
        try {
            Messaging.SingleEmailMessage mail = get_SingleEmailMessage(strSubject,strHtmlBody,toAddresses);
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        } catch(Exception ex) {
            //throw ex;
            // AddException( 'Utility_Info','SendMail',ex , ApexPages.Severity.Error) ;
        }
        return ret;
    }
    public static Messaging.SingleEmailMessage get_SingleEmailMessage(string strSubject, string strHtmlBody,string[] toAddresses)
    {
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        try {
            mail.setCharset('UTF-8');
            mail.setSubject(strSubject);
            mail.setHtmlBody(strHtmlBody);
            mail.setToAddresses(toAddresses);
        } catch(Exception ex) {
            //throw ex;
            // AddException( 'Utility_Info','get_SingleEmailMessage',ex , ApexPages.Severity.Error) ;
        }
        return mail;
    }
    public static Messaging.SingleEmailMessage get_SingleEmailMessage(String strSubject, String strHtmlBody ,
                                                                     String[] toAddresses,
                                                                     String[] ccAddresses,
                                                                     String[] bccAddresses)
    {
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        try {
            if(toAddresses!=null) if(toAddresses.size()>0)   mail.setToAddresses(toAddresses);
            if(ccAddresses!=null) if(ccAddresses.size()>0)   mail.setCcAddresses(ccAddresses);
            if(bccAddresses!=null) if(bccAddresses.size()>0) mail.setBccAddresses(bccAddresses);
            mail.setCharset('UTF-8');
            mail.setSubject(strSubject);
            mail.setHtmlBody(strHtmlBody);
            //mail.setToAddresses(toAddresses);
        } catch(Exception ex) {
            //throw ex;
            // AddException( 'Utility_Info','get_SingleEmailMessage',ex , ApexPages.Severity.Error) ;
        }
        return mail;
    }

    public static boolean send_EMails_ByJSONL(List<String> sEmail_JSON_L)
    {
        boolean ret=true;
        try {            
            transient List<Messaging.SingleEmailMessage> EmailMessage_L=new List<Messaging.SingleEmailMessage>();
            Integer iRow       =0;  
            Integer iMaxEMail  =100;            
            Integer iMinEMail  =5;     
            if(sEmail_JSON_L!=null){      
                System.debug('System.isBatch()='+System.isBatch() +':System.isFuture()='+System.isFuture()) ;
                if(sEmail_JSON_L.size()==1){
                    send_EMails_By_JSON(sEmail_JSON_L[0]);
                }
                else if( System.isBatch() || System.isFuture() ){                                        
                    ///////////////////////////////////////////////////////////////////                    
                    datetime NDate              = datetime.now().addSeconds(2);
                    string   sch                = NDate.format('ss mm HH dd MM')+ ' ? ' ;                    
                    //SendEmail_Schedule_View SJ  = new SendEmail_Schedule_View(sEmail_JSON_L);                                         
                    //string jobId = system.schedule('SendEmail_Schedule_View' +'_'+GUID(UserInfo.getUserId()), sch, SJ);
                }
                else{                 
                    for(String sEmail_JSON: sEmail_JSON_L){                      
                        send_EMails_With_future(sEmail_JSON);                             
                    }
                }
            }
        } catch(Exception ex) {
            throw ex;
        }
        return ret;
    }

    public static List<String> get_EmailL_To_JSON_L(List<Messaging.SingleEmailMessage> Email_L)
    {
        transient List<String> retL=new List<String>();
        try {            
            transient List<Messaging.SingleEmailMessage> EmailMessage_L=new List<Messaging.SingleEmailMessage>();
            Integer iRow       =0;  
            Integer iMaxEMail  =100;            
            Integer iMinEMail  =5;     
            if(Email_L!=null){                         
                for(Messaging.SingleEmailMessage EmailMessage: Email_L){
                    iRow++ ;
                    EmailMessage_L.add(EmailMessage);
                    if(Math.mod(iRow,iMaxEMail)==0){
                        String sEmail_List = JSON.serialize(EmailMessage_L) ;
                        System.debug('** get_EmailL_To_JSON_L:EmailMessage_L.size()='+Email_L.size()+':iRow='+ iRow +':sEmail_List='+sEmail_List);
                        retL.add(sEmail_List); 
                        EmailMessage_L.clear();
                        EmailMessage_L=new List<Messaging.SingleEmailMessage>();
                    }
                    else if(iRow==Email_L.size() ){
                        String sEmail_List = JSON.serialize(EmailMessage_L) ;
                        System.debug('** get_EmailL_To_JSON_L:EmailMessage_L.size()='+Email_L.size()+':iRow='+ iRow +':sEmail_List='+sEmail_List);
                        retL.add(sEmail_List); 
                        EmailMessage_L.clear();
                        EmailMessage_L=new List<Messaging.SingleEmailMessage>();
                    }          
                }                     
            }
        } catch(Exception ex) {
            throw ex;
        }
        return retL;
    }
    @future
    public static void send_EMails_With_future(String sEmails_JSON){
        send_EMails_By_JSON(sEmails_JSON);
    }
    public static void send_EMails_By_JSON(String sEmails_JSON){
        transient List<Messaging.SingleEmailMessage> EmailMessage_L=new List<Messaging.SingleEmailMessage>();
        transient List<Object> Obj_L  = (List<Object>)JSON.deserializeUntyped(sEmails_JSON);
        Integer  iRow =0;        
        Integer  iSend=0;      
        for(Object Obj:Obj_L){
            iRow++;
            Map<String, Object> Mail_Obj_M=(Map<String, Object>) Obj;
            ////////////////////////
            List<String> toAddresses;
            List<String> ccAddresses;
            List<String> bccAddresses;
            List<Object> toAddrObj_L    =(List<Object>) Mail_Obj_M.get('toAddresses');            
            List<Object> ccAddrObj_L    =(List<Object>) Mail_Obj_M.get('ccAddresses');
            List<Object> bccAddObj_L    =(List<Object>) Mail_Obj_M.get('bccAddresses');
            if(toAddrObj_L!=null){
                toAddresses=new List<String>();
                for(Object Addr_Obj: toAddrObj_L ){
                    String sAddr=(String) Addr_Obj;
                    toAddresses.add(sAddr);
                }
            }
            if(ccAddrObj_L!=null){
                ccAddresses=new List<String>();
                for(Object Addr_Obj: ccAddrObj_L ){
                    String sAddr=(String) Addr_Obj;
                    ccAddresses.add(sAddr);
                }
            }
            if(bccAddObj_L!=null){
                bccAddresses=new List<String>();
                for(Object Addr_Obj: bccAddObj_L ){
                    String sAddr=(String) Addr_Obj;
                    bccAddresses.add(sAddr);
                }
            }
            /////////////////////
            String       strSubject     =(String)       Mail_Obj_M.get('subject');
            String       strHtmlBody    =(String)       Mail_Obj_M.get('htmlBody');
            Messaging.SingleEmailMessage  EmailMessage =get_SingleEmailMessage(strSubject,strHtmlBody,toAddresses,ccAddresses,bccAddresses);
            EmailMessage_L.add(EmailMessage);
            //每10筆發1次, 最多發10次
            if(Math.mod(iRow,10)==0){
                if(iSend<10){
                    Messaging.sendEmail(EmailMessage_L);
                    System.debug('EmailMessage_L='+EmailMessage_L);
                    iSend++;
                    EmailMessage_L.clear();
                    EmailMessage_L=new List<Messaging.SingleEmailMessage>();
                }
            }
            else if(iRow==(Obj_L.size()) ){
                Messaging.sendEmail(EmailMessage_L);
                System.debug('EmailMessage_L='+EmailMessage_L);
            }            
        }

    }

    


}