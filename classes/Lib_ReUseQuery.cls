/* *************************************
* Author     :   Alex Chen        
* Description:   Schema_Info : 
* Test Class :   Schema_Info_Test
* Function List:
    User_M
    get_User_M_ByProfileIDs
    UserLogin_M
    CronTrigger_M    

*Test:    

* History
* <Date>   		<Authors Name> 	<Brief Description of Change>
* 20200318        Alex Chen       Create
* 20200612        Alex Chen       Modify
* 流程改善- Git Study -Commit 4   => LIB_DB-Math-ReUseQuery
************************************** */
public without sharing class Lib_ReUseQuery {

    static map<id,Profile> pProfile {get;set;}
	public static map<id,Profile> Profile_M 
	{
		get{
			if (pProfile==null){
				pProfile=new map<id,Profile> ([SELECT Id, Name FROM Profile]);				
			}
			return pProfile;
		}
		set{pProfile=value;}
	}

    /** 
    目的:達成在一個Instance中只執行一次SOQL ,卻可以多次使用  
    */
    static map<id,User> pUser {get;set;}
    public static map<id,User> User_M
    {
        get{
            System.debug('** 同一個Instance內,查過不重查,可以減少SOQL的使用,建議使用在總比數1000 筆以下物件 , pUser='+pUser);
            if (pUser==null){                
                //IsPortalEnabled ,
                pUser=new map<id,User> ([Select Id ,UserType,IsActive ,
                                            ContactId                 , 
                                            Contact.Name              ,                                            
                                            Contact.AccountId         ,
                                            Contact.Account.Name      ,                                            
                                            Contact.Account.ParentId  ,                                            
                                            Name      , Email         ,
                                            ManagerId , Manager.Name  , Manager.IsActive , Manager.Email ,
                                            LastName  , FirstName     ,                                            
                                            ProfileId , Profile.Name  ,
                                            UserRoleId ,UserRole.Name 
                                        from User]);
            }
            return pUser;
        }
        set{pUser=value;}
    }
    static map<String,User> pName_User_M {get;set;}
    public static map<String,User> Name_User_M
    {
        get{
            if (pName_User_M==null){
                pName_User_M=new map<String,User>();
                for(User ur: User_M.values()){
                    if(!String.isBlank(ur.Name)) {
                        pName_User_M.put(ur.Name,ur);
                    }
                }
            }
            return pName_User_M;
        }
        set{pName_User_M=value;}
    }   
    
    /**    
    目的:透過 ProfileId 取回對應的 使用者,應用 USER_M 達成在一個Instance中只執行一次SOQL ,卻可以多次使用      
    */
    public static map<String,User> get_User_M_ByProfileIDs( Set<String> mProfileId_S)
    {
        transient map<String,User> ret=new map<String,User>();
        System.debug('** 進行String 與 ID轉換,才不會有15碼18碼比對問題');
        Set<ID> ProfileId_S=new Set<ID>();        
        for(String sValue:mProfileId_S){
            if(!String.isBlank(sValue)) ProfileId_S.add(sValue);
        }
        for(User ur: User_M.values()){            
            if(ProfileId_S!=null) {
                if( ProfileId_S.contains(ur.ProfileId) ) ret.put(ur.ID,ur);            
            }
        }
        return ret;
    }
    public static map<String,User> get_User_NameUser_M(Boolean IsActive)
    {
        transient map<String,User> ret=new map<String,User>();
        for(User ur: User_M.values()){
            if(ur.IsActive==IsActive) {
                ret.put(ur.Name,ur);
            }
        }
        return ret;
    }
    public static List<User> get_User_L_byName(String sName)
    {
        transient List<User> ret=new List<User>();
        for(User ur: User_M.values()){
            if(String.isBlank(sName)){
                if(ur.Name==sName && ur.IsActive) {
                    ret.add(ur);
                }
            }
        }
        return ret;
    }

    public static map<String,User> get_User_UserEmail_M_byEmail(String sEmail)
    {
        transient map<String,User> ret=new map<String,User>();
        for(User ur: User_M.values()){
            if(String.isBlank(sEmail)){
                if(ur.Email==sEmail && ur.IsActive) {
                    ret.put(ur.Email , ur);
                }
            }
        }
        return ret;
    }
    

    
    static map<id,UserLogin> pUserLogin {get;set;}
    public static map<id,UserLogin> UserLogin_M
    {
        get{
            if (pUserLogin==null){               
                pUserLogin=new map<id,UserLogin>();
                for(UserLogin uLogin:[SELECT Id, UserId, IsFrozen FROM UserLogin]){
                    pUserLogin.put(uLogin.UserId,uLogin);
                }
            }
            return pUserLogin;
        }
        set{pUserLogin=value;}
    }   

    static map<id,CronTrigger> pCronTrigger {get;set;}
    public static map<id,CronTrigger> CronTrigger_M
    {
        get{
            if (pCronTrigger==null){

                pCronTrigger=new map<id,CronTrigger> ([SELECT Id, CronJobDetailId,CronJobDetail.Name, CronJobDetail.JobType, 
                                PreviousFireTime, NextFireTime, State, StartTime, EndTime , TimesTriggered , CronExpression
                                FROM CronTrigger]);
            }
            return pCronTrigger;
        }
        set{pCronTrigger=value;}
    }

    /**
    * 取得所有的CaseStatus 資訊
    */
    static map<String,CaseStatus> pCaseStatus {get;set;}
    public static map<String,CaseStatus> CaseStatus_M
    {
        get{
            if (pCaseStatus==null){
                pCaseStatus=new map<String,CaseStatus> ();
                for(CaseStatus CS:[Select  Id , MasterLabel, IsDefault, IsClosed, SortOrder From CaseStatus ]){
                    pCaseStatus.put(CS.MasterLabel,CS);
                }
            }
            return pCaseStatus;
        }
        set{pCaseStatus=value;}
    }
    public static map<String,CaseStatus> get_CaseStatus_M_ByIsClose(Boolean bIsClosed)
    {
        map<String,CaseStatus> ret=new map<String,CaseStatus>();
        for(CaseStatus CS:CaseStatus_M.values()){
            if (CS.IsClosed==bIsClosed){
                ret.put(CS.MasterLabel,CS);
            }
        }
        return ret;
    }
    //////////////////////////////////////////////////////////
    /**
    * 取得所有的 LeadStatus 資訊
    */
    static map<String,LeadStatus> pLeadStatus {get;set;}
    public static map<String,LeadStatus> LeadStatus_M
    {
        get{
            if (pLeadStatus==null){
                pLeadStatus=new map<String,LeadStatus> ();
                for(LeadStatus OS:[SELECT Id, MasterLabel,  SortOrder, IsDefault, IsConverted
                                     FROM LeadStatus
                                        order by IsConverted,SortOrder])
                {
                    pLeadStatus.put(OS.MasterLabel,OS);
                }
            }
            return pLeadStatus;
        }
        set{pLeadStatus=value;}
    }
    public static map<String,LeadStatus> get_LeadStatus_M_ByIsConverted(Boolean bIsConverted)
    {
        map<String,LeadStatus> ret=new map<String,LeadStatus>();
        for(LeadStatus OS:LeadStatus_M.values()){
            if (OS.IsConverted==bIsConverted){
                ret.put(OS.MasterLabel,OS);
            }
        }
        return ret;
    }
    //////////////////////////////////////////////////////////
    /**
    * 取得所有的 OpportunityStage 資訊
    */
    static map<String,OpportunityStage> pOpportunityStage {get;set;}
    public static map<String,OpportunityStage> OpportunityStage_M
    {
        get{
            if (pOpportunityStage==null){
                pOpportunityStage=new map<String,OpportunityStage> ();
                for(OpportunityStage OS:[SELECT Id, MasterLabel, IsActive, IsClosed, IsWon, SortOrder, Description
                                        FROM OpportunityStage where IsActive=true
                                        order by IsClosed,IsWon ])
                {
                    pOpportunityStage.put(OS.MasterLabel,OS);
                }
            }
            return pOpportunityStage;
        }
        set{pOpportunityStage=value;}
    }
    public static map<String,OpportunityStage> get_OpportunityStage_M_ByIsClose(Boolean bIsClosed)
    {
        map<String,OpportunityStage> ret=new map<String,OpportunityStage>();
        for(OpportunityStage OS:OpportunityStage_M.values()){
            if (OS.IsClosed==bIsClosed){
                ret.put(OS.MasterLabel,OS);
            }
        }
        return ret;
    }

    /*
    static map<id,Holiday__c> pHoliday {get;set;}
	public static map<id,Holiday__c> Holiday_M 
	{
		get{
			if (pHoliday==null){
				pHoliday=new map<id,Holiday__c> ([Select Id, Name, Date__c, Name__c, BusinessArea__c, Is_Weekend__c From Holiday__c]);				
			}
			return pHoliday;
		}
		set{pHoliday=value;}
	}
    
    static map<String,CurrencyType> pCurrencyTypeM {get;set;}
	public static map<String,CurrencyType> CurrencyType_M 
	{
		get{
			if (pCurrencyTypeM==null){
				pCurrencyTypeM=new map<String,CurrencyType>();
				for(CurrencyType CY:[SELECT Id, IsoCode, ConversionRate, DecimalPlaces, IsActive, IsCorporate FROM CurrencyType where IsActive=true]){
					pCurrencyTypeM.put(CY.IsoCode,CY);
				}
			}
			return pCurrencyTypeM;
		}
		set{pCurrencyTypeM=value;}
	}
    */

}