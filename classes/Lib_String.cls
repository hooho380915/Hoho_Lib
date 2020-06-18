/** ************************************
* Author     :   Alex Chen        
* Description:   Lib_String : 
* Test Class :   Lib_String_Test
* Function List:
    to_String
    to_StringEx

* History
* <Date>        <Authors Name> 	<Brief Description of Change>
20200318        Alex Chen       Create
************************************** */
public without sharing class Lib_String {
    /*
    List<String> sL=new List<String>{'a','b','c'};
    String arf2=' - ';
    System.debug( Lib_String.Join(sL,arf2) );
    */
    public static String Join(List<String> sArray_L ,String sJoin) {
        String ret='';
        ret=String.join(sArray_L, sJoin);  
        return ret;
    }    
    /*
    Set<String> sL=new Set<String>{'a','b','c'};
    String arf2=' - ';
    System.debug( Lib_String.Join(sL,arf2) );
    */
    public static String Join(Set<String> sArray_S ,String sJoin) {        
        String ret='';
        transient List<String> sArray_L=new List<String>();
        sArray_L.addAll(sArray_S);
        ret=String.join(sArray_L, sJoin);  
        return ret;
    }    
    /*
    System.debug( Lib_String.ToASCII('Hello 你好') );
    */
    public static List<Integer> ToASCII(String s) {
        List<Integer> ret = new List<Integer>();
        try{
            if(s!=null) ret= s.getChars();
        }
        Catch(Exception ex){}        
        return ret;
    }    
    public static String to_String( List<Integer> ASCII_L) {
        String ret='';
        try{
            if(ASCII_L!=null) if(ASCII_L.size() >0 ) ret = String.fromCharArray(ASCII_L);
        }
        Catch(Exception ex){}        
        return ret;
    }
    public static String to_String(List<sObject> s) {
        String ret='';
        try{
            if(s!=null) ret= String.valueOf(s);
        }
        Catch(Exception ex){}        
        return ret;
    }
    public static String to_String(String s) {
        String ret='';
        if(s!=null) ret= s.trim();
        return ret;
    }
    public static String to_String(Integer s){
        String ret='';
        if(s!=null) ret= String.valueOf(s);
        return ret;
    }
    public static String to_String(Decimal s) {
        String ret='';
        if(s!=null) ret= String.valueOf(s);
        return ret;
    }
    public static String to_String(Double s) {
        String ret='';
        if(s!=null) ret= String.valueOf(s);
        return ret;
    }
    public static String to_String(Date s) {
        String ret='';
        if(s!=null) ret= String.valueOf(s);
        return ret;
    }
    public static String to_String(Datetime s) {
        String ret='';
        if(s!=null) ret= String.valueOf(s);
        return ret;
    }
    
    public static String to_StringEx(Boolean s) {
        String ret='';
        if(s!=null) {
            if(s){
                ret='Y';
            }else{
                ret='N';
            }
        }
        return ret;
    }
    public static String to_StringEx(Datetime s) {
        String ret='';
        if(s!=null) {
            ret= String.valueOf(s);
            ret= ret.replace('-', '');
            ret= ret.replace(':', '');
            ret= ret.replace(' ', '');
        }
        return ret;
    }

}