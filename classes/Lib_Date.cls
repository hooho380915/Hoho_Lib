/** *************************************
* Author     :   Alex Chen        
* Description:   Lib_Date : 
* Test Class :   
* History
* <Date>        <Authors Name>      <Brief Description of Change>
* 20200318      Alex Chen           Modify
* 20200612        Alex Chen       Modify
* 流程改善- Git Study -Commit 2   => LIB_Chatter-Date-DB
* Master 13
<<<<<<< HEAD
<<<<<<< HEAD
* Master 14
=======
* Master Push 3
>>>>>>> 8328b502c83c4f2e7add65d8326e992807c9b2a1
=======
* Master Push 3
>>>>>>> 8328b502c83c4f2e7add65d8326e992807c9b2a1
************************************** */
public without sharing class Lib_Date {


    public static Integer DurationTime(Datetime dStarttime){
        Datetime dNow=datetime.now();
        Double nret=(dNow.getTime()-dStarttime.getTime());
        Integer ret = nret.intValue();
        return ret;
    }

    //////////////////////////////////////////
    public static integer dayOfWeek (Date dDate)
    {        
        //星期天:0 星期一為1
        integer ret=null;   
        if (dDate!=null){     
            Date sunday7 = Date.newInstance(1900, 1, 7);        
            ret=Math.mod(sunday7.daysBetween(dDate), 7);
        }
        //星期天:1 星期一為2
        return ret+1; 
    }
    public static Integer dayOfWeek (String sDay_of_week)
    {        
        Integer ret;
        if(sDay_of_week=='SUN') ret= 1;
        if(sDay_of_week=='MON') ret= 2;
        if(sDay_of_week=='TUE') ret= 3;
        if(sDay_of_week=='WED') ret= 4;
        if(sDay_of_week=='THU') ret= 5;
        if(sDay_of_week=='FRI') ret= 6;
        if(sDay_of_week=='SAT') ret= 7;
        //
        if(sDay_of_week=='1') ret= 1;
        if(sDay_of_week=='2') ret= 2;
        if(sDay_of_week=='3') ret= 3;
        if(sDay_of_week=='4') ret= 4;
        if(sDay_of_week=='5') ret= 5;
        if(sDay_of_week=='6') ret= 6;
        if(sDay_of_week=='7') ret= 7;
        return ret;
    }
    public static List<String> Convert_Day_of_month (String sDay_of_month)
    {        
                
        List<String>   ret_L=new List<String>();
        if(sDay_of_month.contains('?')){}        
        else if(sDay_of_month.contains('*')){  
            ret_L=new List<String>{'1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24','25','26','27','28','29','30','31'} ;
        }
        else if(sDay_of_month.contains('-')){
            List<String>  sDayOfMonth_L=sDay_of_month.split('-');            
            for(Integer i=Integer.valueOf(sDayOfMonth_L[0]);i<=Integer.valueOf(sDayOfMonth_L[1]);i++){
                ret_L.add(String.valueOf(i));
            }
        }        
        else if(sDay_of_month.contains(',')){            
            for(String sDayOfWeek:sDay_of_month.split(',')){
                ret_L.add(String.valueOf(sDayOfWeek));
            }
        }        
        return ret_L;
    }
    public static List<String> Convert_Day_of_week (String sDay_of_week)
    {        
                
        List<String>   ret_L=new List<String>();
        if(sDay_of_week.contains('?')){}        
        else if(sDay_of_week.contains('*')){  
            ret_L=new List<String>{'1','2','3','4','5','6','7'} ;
        }        
        else if(sDay_of_week.contains('#')){
            // #2=>代表第二周
            List<String>  sDayOfWeek_L=sDay_of_week.split('#');  
            ret_L.add( String.valueOf(sDayOfWeek_L[0]) );            
            //sDayOfWeek_L[1]; // 第幾個星期
        }
        else if(sDay_of_week.contains('L')){
            ret_L.add( sDay_of_week );
            //List<String>  sDayOfWeek_L=sDay_of_week.split('L');  
            //ret_L.add( String.valueOf(sDayOfWeek_L[0]) );                        
            //sDayOfWeek_L[1]; // 第幾個星期
        }
        else if(sDay_of_week.contains('-')){
            List<String>  sDayOfWeek_L=sDay_of_week.split('-');            
            for(Integer i=dayOfWeek(sDayOfWeek_L[0]);i<=dayOfWeek(sDayOfWeek_L[1]);i++){
                ret_L.add(String.valueOf(i));
            }
        }   
        else if(sDay_of_week.contains(',')){            
            for(String sDayOfWeek:sDay_of_week.split(',')){
                ret_L.add(String.valueOf(sDayOfWeek));
            }
        }        
        return ret_L;
    }
    
    public static Datetime Match_LastWeekDateTime (Integer iWeeKDayNo,Date dEndDayOfMonth,Time tTime )
    {        
        DateTime ret;
        for(Integer i=0;i>-7;i--){
            Date dDay=dEndDayOfMonth.addDays(i);
            if( dayOfWeek( dDay )== iWeeKDayNo){
                //符合設定的日期
                ret=Datetime.newInstance(dDay, tTime);                
            }
        }
        return ret;
    }
    public static Datetime Match_SpecifyWeekDateTime(Integer iWeeKDayNo, Integer iWeeKNo, Date dStartDayOfMonth,Time tTime )
    {        
        DateTime ret;
        for(Integer i=0;i>7;i++){
            Date dDay=dStartDayOfMonth.addDays(i);
            if( dayOfWeek( dDay )== iWeeKDayNo){
                //符合設定的日期
                ret =Datetime.newInstance(dDay.addDays( (iWeeKNo-1)*7) , tTime);                
            }
        }
        return ret;
    }
    
    
    /*
    public static Date ToDate(String s) {
        Date ret=null;
        List<String> retL=new List<String>();
        if(s!=null) {
            s=s.replace('/','-');
            if(s.contains('-')){
                retL= s.split('-');
            }
            if(retL.size()==3){
                Integer nOne    =Integer.valueOf(retL[0]);
                Integer nTwo    =Integer.valueOf(retL[1]);
                Integer nThree  =Integer.valueOf(retL[2]);
                if(retL[0].length()==3){
                    ret=Date.newInstance(nOne+1911, nTwo, nThree);
                }else {
                    try{
                        ret=Date.parse(s);
                    }Catch(Exception e){
                        try{
                            ret=Date.valueOf(s);
                        }Catch(Exception ex){}
                    }
                }
            }
        }
        return ret;
    }
    */

}