/* *************************************
* Author     :   Alex Chen        
* Description:   Lib_Schema : 
* Test Class :   Lib_Schema_Test
* Function List:
    get_KeyPrefix
    get_RecordType_NameID_M
    get_RecordType_APIID_M
    get_FieldType
    get_FieldLableName
    get_PickList_LabelValue_M
    get_PickList_ValueLabel_M

*Test:    
    System.debug( Lib_Schema.get_KeyPrefix('Opportunity')) ;    
    System.debug( Lib_Schema.get_RecordType_NameID_M(  'Opportunity'   ,true));     
    System.debug( Lib_Schema.get_RecordType_APIID_M(   'Opportunity'   ,true));     
    System.debug( Lib_Schema.get_FieldType (           'Opportunity'   ,'StageName') );        
    System.debug( Lib_Schema.get_FieldLableName (      'Opportunity'   ,'StageName') );   
    System.debug( Lib_Schema.get_PickList_LabelValue_M('Opportunity'   ,'StageName') );      
    System.debug( Lib_Schema.get_PickList_ValueLabel_M('Opportunity'   ,'StageName') ); 

    Opportunity Opp=new Opportunity();    
    System.debug( Lib_Schema.get_RecordType_NameID_M(  Opp ,true)); 
    System.debug( Lib_Schema.get_RecordType_APIID_M(   Opp ,true));     
    System.debug( Lib_Schema.get_FieldType (           Opp ,'StageName') );   
    System.debug( Lib_Schema.get_FieldLableName (      Opp ,'StageName') );   
    System.debug( Lib_Schema.get_PickList_LabelValue_M(Opp ,'StageName') );
    System.debug( Lib_Schema.get_PickList_ValueLabel_M(Opp ,'StageName') );

* History
* <Date>   		<Authors Name> 	<Brief Description of Change>
************************************** */
public without sharing class Lib_Schema {

    //Static block{
        /**          
         System.debug('getQueryBodyStr='+Lib_Schema.getQueryBodyStr('Case') );
        */
        public static String getQueryBodyStr(string sObjectName){
            String ret='' ;
            ret += 'Select ' ;
            ret += getObjectFields(sObjectName) ;
            ret += ' From ' + sObjectName +' ';            
            return ret ;
        }
        /** 
         System.debug('getObjectFields='+Lib_Schema.getObjectFields('Case') );
        */
        public static String getObjectFields(string sObjectName){
            String ret='';
            map<string, schema.sobjecttype>  allSObjects= schema.getglobaldescribe();
            schema.sobjecttype               q          = allsobjects.get(sObjectName);
            schema.describesobjectresult     d          = q.getdescribe();
            map<string, schema.sobjectfield> m          = d.fields.getmap();
            //for(String skey:m.keyset()){
            //    if(skey=='businesshoursid') system.debug(m.get(sKey));
            //}
            set<string>                      s          = m.keyset(); 
            List<String>                     l          = new List<String>();
            l.addAll(s);
            ret=String.join(l,',');
            return ret ;
        }
    //}  
    


    /** 
    Opportunity obj=new Opportunity();         
    Schema.DescribeSObjectResult sr1 = Lib_Schema.getDescribeSObjectResult(obj);
    Schema.DescribeSObjectResult sr2 = Lib_Schema.getDescribeSObjectResult('Opportunity');
    System.debug('** sr1:'+ sr1);           
    System.debug('** sr2:'+ sr2);   
    System.debug('** ' + sr1.fields.getMap().get('StageName').getDescribe() );
    System.debug('** ' + sr2.fields.getMap().get('StageName').getDescribe() );
    */
    private static Schema.DescribeSObjectResult getDescribeSObjectResult(sObject obj){       
        Schema.SObjectType           st     = obj.getSObjectType();
        Schema.DescribeSObjectResult ret    = st.getDescribe();    
        return ret;          
    }   
    private static Schema.DescribeSObjectResult getDescribeSObjectResult(String sObjAPIName){  
        Schema.DescribeSObjectResult ret  ;
        Map<String, Schema.SObjectType> gd =Schema.getGlobalDescribe();
        //System.debug('gd='+gd);
        if(gd.containsKey(sObjAPIName)){
            Schema.SObjectType  Obj = gd.get(sObjAPIName);            
            ret                     = Obj.getDescribe();    
        }
        return ret;          
    }   
    /**
    Opportunity Opp=new Opportunity();
    System.debug( Lib_Schema.getFieldDescribeFieldResult (Opp,'StageName') );
    System.debug( Lib_Schema.getFieldDescribeFieldResult ('Opportunity','StageName') );   
    */
    private static Schema.DescribeFieldResult getFieldDescribeFieldResult(sObject obj,String sFieldAPIName){
        Schema.DescribeSObjectResult sr     = getDescribeSObjectResult(obj);
        Schema.DescribeFieldResult   ret    = sr.fields.getMap().get(sFieldAPIName).getDescribe();                
        return ret;          
    }
    private static Schema.DescribeFieldResult getFieldDescribeFieldResult(String obj,String sFieldAPIName){             
        Schema.DescribeSObjectResult sr     = getDescribeSObjectResult(obj);        
        Schema.DescribeFieldResult   ret    = sr.fields.getMap().get(sFieldAPIName).getDescribe();                
        return ret;          
    }
    
    /**
    System.debug( Lib_Schema.getSchema_RecordTypeInfo_L('Opportunity'));
    */
    private static List<Schema.RecordTypeInfo> getSchema_RecordTypeInfo_L( sObject obj){
        List<Schema.RecordTypeInfo> ret =new List<Schema.RecordTypeInfo>();
        Schema.DescribeSObjectResult Sr = Lib_Schema.getDescribeSObjectResult(obj) ;         
        ret=sr.getRecordTypeInfos();
        return ret;
    }
    private static List<Schema.RecordTypeInfo> getSchema_RecordTypeInfo_L( String sObjAPIName){
        List<Schema.RecordTypeInfo> ret =new List<Schema.RecordTypeInfo>();
        Schema.DescribeSObjectResult Sr = Lib_Schema.getDescribeSObjectResult(sObjAPIName) ;        
        ret=sr.getRecordTypeInfos();
        return ret;
    }
    /** 
    * 取得物件的紀錄類型Map:此方式高效.不耗 SOQL,     
    EX:
    Opportunity obj=new Opportunity();                  
    System.debug(Lib_Schema.get_RecordType_NameID_M(obj,true));    
    System.debug(Lib_Schema.get_RecordType_NameID_M('Opportunity',true));        
    */   
    public static Map<string,string> get_RecordType_NameID_M(sObject obj, Boolean IsActive){
        Map<string,string> ret =new Map<string,string>();        
        ret=get_RecordType_NameID_M(getSchema_RecordTypeInfo_L(obj) ,IsActive);
        return ret;
    }        
    public static Map<string,string> get_RecordType_NameID_M(String sObjAPIName , Boolean IsActive){
        Map<string,string> ret =new Map<string,string>();        
        ret=get_RecordType_NameID_M(getSchema_RecordTypeInfo_L(sObjAPIName) , IsActive );
        return ret;
    }  
    public static Map<string,string> get_RecordType_NameID_M(List<Schema.RecordTypeInfo> RTI_L , Boolean IsActive){
        Map<string,string> ret =new Map<string,string>();                
        for(Schema.RecordTypeInfo RTI: RTI_L){            
            Boolean isDefaultDo=true;
            if (IsActive!=null) if(RTI.isActive()!=IsActive) isDefaultDo=false;                
            if(isDefaultDo)     ret.put(RTI.getName() ,RTI.getRecordTypeId() );
        }
        return ret;
    }
    /** 
    * 取得物件的紀錄類型Map:此方式高效.不耗 SOQL, 
    * Add by Alex on 20200108    
    EX:
    Opportunity obj=new Opportunity();            
    System.debug(Lib_Schema.get_RecordType_APIID_M(obj,true)); 
    System.debug(Lib_Schema.get_RecordType_APIID_M('Opportunity',true));       
    */    
    public static Map<string,string> get_RecordType_APIID_M(sObject obj, Boolean IsActive){
        Map<string,string> ret =new Map<string,string>();        
        ret=get_RecordType_APIID_M(getSchema_RecordTypeInfo_L(obj) ,IsActive);
        return ret;
    }
    public static Map<string,string> get_RecordType_APIID_M(String sObjAPIName , Boolean IsActive){
        Map<string,string> ret =new Map<string,string>();        
        ret=get_RecordType_APIID_M(getSchema_RecordTypeInfo_L(sObjAPIName) , IsActive );
        return ret;
    }       
    public static Map<string,string> get_RecordType_APIID_M(List<Schema.RecordTypeInfo> RTI_L , Boolean IsActive){
        Map<string,string> ret =new Map<string,string>();                
        for(Schema.RecordTypeInfo RTI: RTI_L){            
            Boolean isDefaultDo=true;
            if (IsActive!=null) if(RTI.isActive()!=IsActive) isDefaultDo=false;                
            if(isDefaultDo)     ret.put(RTI.getDeveloperName() ,RTI.getRecordTypeId() );            
        }
        return ret;
    }
    /*
    public static Map<string,string> get_RecordType_APIID_M(sObject obj){
        Map<string,string> ret =new Map<string,string>();        
        ret=get_RecordType_APIID_M(obj,null);
        return ret;
    }   
    public static Map<string,string> get_RecordType_APIID_M(String sObjAPIName){
        Map<string,string> ret =new Map<string,string>();        
        ret=get_RecordType_APIID_M(sObjAPIName , null );
        return ret;
    }   
    */
   
    /////////////////////////////////////////////////////////////////////////////////
    /** 
    * 傳入物件API名稱,傳回在Salesforc上的代碼
    Test:
    System.debug(Lib_Schema.get_KeyPrefix('Account')) ;
    */
    public static string get_KeyPrefix(string pName){
        string ret;    
        map<String, Schema.SObjectType>  gdMap = Schema.getGlobalDescribe();            
        for(SOBjectType so: gdMap.values()){
            Schema.DescribeSobjectResult  sdr = so.getDescribe();
            if(sdr.getName() == pName){
                ret = sdr.getKeyPrefix();
            }
        }
        return ret;
    }

    /**
    * 傳入物件sObject 及欄位API名稱,傳回欄位Label Name
    */
    public static Schema.DisplayType get_FieldType(sObject obj , string sFieldAPIName){
        Schema.DisplayType ret;      
		try{
			//Schema.SObjectType 			 st 	= obj.getSObjectType();
			//Schema.DescribeSObjectResult   sr 	= st.getDescribe();
			//Schema.DescribeFieldResult 	 fr     = sr.fields.getMap().get(sFieldAPIName).getDescribe();
            Schema.DescribeFieldResult   fr     = getFieldDescribeFieldResult(obj,sFieldAPIName);  			
			ret	= fr.getType();			
		}
		catch(Exception ex){
			ret=null;
		}
        return ret;
    }
    public static Schema.DisplayType get_FieldType(String obj , string sFieldAPIName){
        Schema.DisplayType ret;      
		try{		
            Schema.DescribeFieldResult   fr     = getFieldDescribeFieldResult(obj,sFieldAPIName);  			
			ret	= fr.getType();			
		}
		catch(Exception ex){ ret=null; }
        return ret;
    }

    /*
    Opportunity Opp=new Opportunity();
    System.debug( Lib_Schema.get_FieldLableName (Opp,'StageName') );
    System.debug( Lib_Schema.get_FieldLableName ('Opportunity','StageName') );    
    */
    public static string get_FieldLableName(sObject obj , string sFieldAPIName){
        string ret='';
        try{           
            Schema.DescribeFieldResult   fr     = getFieldDescribeFieldResult(obj,sFieldAPIName);      
            ret = fr.getLabel();
        }
        catch(Exception ex){
            ret='';
        }
        return ret;
    }
    public static string get_FieldLableName(String obj , string sFieldAPIName){
        string ret='';
        try{           
            Schema.DescribeFieldResult   fr     = getFieldDescribeFieldResult(obj,sFieldAPIName);      
            ret = fr.getLabel();
        }
        catch(Exception ex){
            ret='';
        }
        return ret;
    }

    /**   
    Opportunity Opp=new Opportunity();
    System.debug( Lib_Schema.get_PickList_LabelValue_M(Opp            ,'StageName') );
    System.debug( Lib_Schema.get_PickList_LabelValue_M('Opportunity'  ,'StageName') );  
    */
    public static Map<String,String> get_PickList_LabelValue_M(sObject obj,String sFieldAPIName){
        transient Map<String,String> ret=new Map<String,String>();
        Schema.DescribeFieldResult   fr     = getFieldDescribeFieldResult(obj,sFieldAPIName);        
        for (Schema.PicklistEntry f : fr.getPicklistValues()){            
            ret.put(f.getLabel(),f.getValue());
        }
        return ret;          
    }
    public static Map<String,String> get_PickList_LabelValue_M(String obj,String sFieldAPIName){
        transient Map<String,String> ret=new Map<String,String>();
        Schema.DescribeFieldResult   fr     = getFieldDescribeFieldResult(obj,sFieldAPIName);        
        for (Schema.PicklistEntry f : fr.getPicklistValues()){            
            ret.put(f.getLabel(),f.getValue());
        }
        return ret;          
    }
    /** 
    Opportunity Opp=new Opportunity();
    System.debug( Lib_Schema.get_PickList_ValueLabel_M (Opp            ,'StageName') );
    System.debug( Lib_Schema.get_PickList_ValueLabel_M ('Opportunity'  ,'StageName') );    
    */
    public static Map<String,String> get_PickList_ValueLabel_M(sObject obj,String sFieldAPIName){
        transient Map<String,String> ret=new Map<String,String>();
        Schema.DescribeFieldResult   fr     = getFieldDescribeFieldResult(obj,sFieldAPIName);        
        for (Schema.PicklistEntry f : fr.getPicklistValues()){            
            ret.put(f.getValue() , f.getLabel() );
        }
        return ret;          
    }
    public static Map<String,String> get_PickList_ValueLabel_M(String obj,String sFieldAPIName){
        transient Map<String,String> ret=new Map<String,String>();
        Schema.DescribeFieldResult   fr     = getFieldDescribeFieldResult(obj,sFieldAPIName);        
        for (Schema.PicklistEntry f : fr.getPicklistValues()){            
            ret.put(f.getValue() , f.getLabel() );
        }
        return ret;          
    }
    
    
    

}