/** *************************************
* Author     :   Alex Chen        
* Description:   Lib_Math : 
* Test Class :   Lib_Math_Test
* Function List:
* History
* <Date>   		<Authors Name> 	<Brief Description of Change>
* 20200318        Alex Chen       Create
* 20200612        Alex Chen       Modify
* 流程改善- Git Study -Commit 4   => LIB_DB-Math-ReUseQuery
* Master 13
************************************* */
public without sharing class Lib_Math {

    public static Integer ToInt(Integer iValue) {
        if(iValue==null) iValue=0;
        return iValue;
    }
    public static Integer ToInt(Double nValue) {
        integer ret;
        if(nValue==null) nValue=0;
        ret=Math.round(nValue);
        return ret;
    }
    public static Integer ToInt(Decimal nValue) {
        integer ret;
        if(nValue==null) nValue=0;
        ret=Math.round(nValue);
        return ret;
    }
    public static Integer ToInt(String sValue) {
        integer ret=0;
        if(!String.isBlank(sValue)) {
            sValue=sValue.replace(',','');
        }else{
            sValue='0';
        }
        try{
            ret=Integer.valueOf(sValue);
        }
        catch(Exception ex){

        }
        return ret;
    }
    /////////////////////// ToDouble /////////////////////////
    public static Double ToDouble(Double nValue) {
        if(nValue==null) nValue=0;
        return nValue;
    }
    public static Double ToDouble(Decimal nValue) {
        if(nValue==null) nValue=0;
        return nValue;
    }
    public static Double ToDouble(String sValue) {
        Double ret=0.00;
        if(!String.isBlank(sValue)) {
            sValue=sValue.replace(',','');
        }else{
            sValue='0';
        }
        try{
            ret=Double.valueOf(sValue);
        }
        catch(Exception ex){

        }
        return ret;
    }

}