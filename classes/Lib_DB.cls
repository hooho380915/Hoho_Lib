/**  ------------------------------------------------------------
* Author:        Alex Chen
* Company:       
* Description:   Lib_DB
* Test Class:    Lib_DB_Test
* Function List:    
    do_SaveResult_Log
    do_Insert
    do_Update
    do_Delete 
* History
* <Date>        <Authors Name>      <Brief Description of Change>
* 20200318      Alex Chen           Modify
* 20200612        Alex Chen       Modify
* 流程改善- Git Study -Commit 2   => LIB_Chatter-Date-DB
* 20200612        Alex Chen       Modify
* 流程改善- Git Study -Commit 3   => LIB_DB-Email-Log
* 20200612        Alex Chen       Modify
* 流程改善- Git Study -Commit 4   => LIB_DB-Math-ReUseQuery
* 20200612        Alex Chen       Modify
* 流程改善- Git Study -Master 1   => LIB_D
* Barnch 3
* Barnch 5
* Barnch 7
* Master 13
* Master Push 2 
* Master Push 3 
* Master Push 6
------------------------------------------------------------ */
public inherited sharing class Lib_DB {                    
    /** 
     * Branch 10
     * Master 11
    */
    public static List<sObject> do_SaveResult_Log(  Database.SaveResult[] srL ,
                                                    String                sType        ,
                                                    List<sObject>         Obj          ,
                                                    String                sSource      
    ){                               
        String sReference_Id;
        //紀錄成功失敗
        //transient List<Database.SaveResult> ret_S_L=new List<Database.SaveResult>();
        transient Map<id,sObject>           Obj_M   =new Map<id,sObject>();
        transient List<sObject>             Obj_S_L =new List<sObject>();
        transient List<Database.SaveResult> ret_F_L =new List<Database.SaveResult>();    
        try{                       
            for (sObject  s : Obj) {if (s.Id!=null) Obj_M.put(s.Id,s); }
            // if(Obj_M.size()>0)  sReference_Id=String.valueOf(Obj_M.keySet());             
            for (Database.SaveResult sr : srL) {
                System.Debug('****** DB Result:1:' + 'sSource=' +sSource +':sType='+sType +':' + JSON.serialize(sr));  
                if (sr.isSuccess()) {                    
                    if(Obj_M.containsKey(sr.getId())) Obj_S_L.add( Obj_M.get( sr.getId() )  );  
                    System.Debug('****** DB Result:Success:2:' + 'sSource=' +sSource +':sType='+sType +':sr=' + JSON.serialize(sr));               
                }
                else {                      
                    System.Debug('****** DB Result:Fail:3:' + 'sSource=' +sSource +':sType='+sType +':sr=' + JSON.serialize(sr));  
                    ret_F_L.add(sr);                    
                }
            }
        }
        catch(exception ex){                
        }                       
        if(String.isBlank(sType)) sType='do_SaveResult_Log';
        
        if(ret_F_L.size()>0){ System.Debug('****** DB Result:Fail:' + 'sSource=' +sSource +':sType='+sType +':ret_F_L=' + JSON.serialize(ret_F_L));  }
        if(Obj_S_L.size()>0){ System.Debug('****** DB Result:Success:' + 'sSource=' +sSource +':sType='+sType +':Obj_S_L=' + JSON.serialize(Obj_S_L));  }
        return Obj_S_L ;
    }

    /** 
    * Lib_DB.do_Insert(Obj,sSource,bAllOrNone);
    */
    public static Database.SaveResult do_Insert( sObject Obj,
                                                String  sSource ,                                                 
                                                Boolean bAllOrNone
    ){
        transient List<sObject> Obj_L=new List<sObject>();
        Obj_L.add(Obj);
        Database.SaveResult[] ret_L =do_Insert(Obj_L,sSource,bAllOrNone);
        return ret_L[0];
    } 
    public static Database.SaveResult[] do_Insert(List<sObject>  Obj,
                                                 String         sSource ,                                                 
                                                 Boolean        bAllOrNone
    ){        
        Database.SaveResult[] ret;
        if(Obj!=null){
            if(Obj.size()>0){
                try{                    
                    System.Debug('**** do_Insert:sSource='+sSource +':bAllOrNone'+bAllOrNone + ':Obj.size()='+Obj.size());
                    ret=Database.insert(Obj,bAllOrNone);
                    //測試用
                    //ret=Database.insert(Obj,false);
                }
                catch(Exception e){             
                    System.Debug('**** Exception:' + Lib_Log.get_ErrMessageInfo(e));
                    throw e;
                }
                do_SaveResult_Log(ret,'Insert',Obj,sSource );
            }else{
                System.Debug('**** do_Insert:sSource='+sSource +':bAllOrNone'+bAllOrNone +':Obj size 0');
            }
        }
        else{
            System.Debug('**** do_Insert:sSource='+sSource +':bAllOrNone'+bAllOrNone +':Obj is null');
        }
        return ret;
    }

    /** 
    * Lib_DB.do_Update(Obj,sSource,bAllOrNone);
    */
    public static Database.SaveResult do_Update(  sObject Obj,
                                                 String  sSource ,                                                 
                                                 Boolean bAllOrNone
    ){
        transient List<sObject> Obj_L=new List<sObject>();
        Obj_L.add(Obj);
        Database.SaveResult[] ret_L =do_Update(Obj_L,sSource,bAllOrNone);        
        return ret_L[0];
    }
    public static Database.SaveResult[] do_Update(List<sObject>  Obj,
                                                 String         sSource ,                                                
                                                 Boolean        bAllOrNone
    ){               
        Database.SaveResult[] ret;
        if(Obj!=null){
            if(Obj.size()>0){
                try{
                    System.Debug('**** do_Update:sSource='+sSource +':bAllOrNone'+bAllOrNone +':Obj.size()='+Obj.size() +':Obj='+Obj );
                    ret=Database.Update(Obj,bAllOrNone);
                    // ret=Database.Update(Obj,false);
                }
                catch(Exception e ){ 
                    System.Debug('**** Exception:' + Lib_Log.get_ErrMessageInfo(e));
                    throw e;
                }
                do_SaveResult_Log(ret,'Update',Obj,sSource);
            }
            else{
                System.Debug('**** do_Update:sSource='+sSource +':bAllOrNone'+bAllOrNone +':Obj size 0');
            }
        }
        else{
            System.Debug('**** do_Update:sSource='+sSource +':bAllOrNone'+bAllOrNone +':Obj is null');
        }
        return ret;
    }

    /** 
     * 
    */
    public static Database.DeleteResult do_Delete(sObject Obj,
                                                 String  sSource ,                                                 
                                                 Boolean bAllOrNone
    ){
        transient List<sObject> Obj_L=new List<sObject>();
        Obj_L.add(Obj);
        Database.DeleteResult[] ret_L =do_Delete(Obj_L,sSource,bAllOrNone);        
        return ret_L[0];
    }
    public static Database.DeleteResult[] do_Delete( List<sObject>  Obj,
                                                    String         sSource ,                                                
                                                    Boolean        bAllOrNone
    ){               
        Database.DeleteResult[] ret;
        if(Obj!=null){
            if(Obj.size()>0){               
                try{
                    System.Debug('**** do_Delete:sSource='+sSource +':bAllOrNone'+bAllOrNone +':Obj.size()='+Obj.size());
                    ret=Database.Delete(Obj,bAllOrNone);      
                }
                catch(Exception e ){ 
                    System.Debug('**** Exception:' + Lib_Log.get_ErrMessageInfo(e));
                    throw e;
                }                 
            }
            else{
                System.Debug('**** do_Delete:sSource='+sSource +':bAllOrNone'+bAllOrNone +':Obj size 0');
            }
        }
        else{
            System.Debug('**** do_Delete:sSource='+sSource +':bAllOrNone'+bAllOrNone +':Obj is null');
        }
        return ret;
    }    

}
