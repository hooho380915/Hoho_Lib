/***************************************************************************
* Create Date: 2013/05/01, Marc Benioff
* Comments: 請描述Class及Trigger目的，透過呼叫使用此Class 的描述。
* Test Method : “test”<MainClassName>
* Update: 2015/05/02, Emily Chang, For Issue #01. or Case #CS12345678.
* Update: 2017/05/01, Jason Chen, For Issue #02. or Case #CS23456789.

* Comments: 將調整的部份描述於此。

* Block Comments 以　／＊　＊／的註解方式
* 主要用途在於提供Class、Methods及Algorithms等描述，
* 請置放於所有Methods的最前端，勿置於Methods之中，避免往後要暫時或永久Disable程式時，造成困擾。

* <access> class <name> { 
* Class以大寫字母開頭，
* class Name： 名稱可以包含字母數字字符。它應該是唯一的，以大寫字母開頭。它不應包含(_)下劃線和空格。單詞應與首字母大寫連接。 
***************************************************************************/    
public without sharing class SampleLayoutClass {  

 	//a.Static Block{                 
		//1.Static variable      
            //1.1盡可能避免使用靜態變量            
        //Code here ..
        
		//2.Static Methods       
		//Code here ..
	//} 
 
	//b.Non-Static Variables{
		//1.變量名稱應該有意義。
		//2.名稱應避免縮寫。例如：computeAverage（）; 而不是：compAvg（）;
			//EX: Account accountRecord; 而不是：Account a;
		//3.必須避免使用取反的boolean變量。EX:  boolean isError;  而不是：isNoError 
		//4.SFDC關鍵字不能用為 變量
		
		//Code here ..
	//}
	
	//c. Constructors {
		//Code here ..
	//}
	
	//1.function的名稱應以小寫字母開頭，其後的單詞應以大寫字母開頭
	//2.變量名應該有意義。
	//3.任何@AuraEnabled方法都像Web服務一樣是global function
	//4.function 應具有try-catch-finally塊以處理可能的異常。 try catch塊應該出現在確定異常性質及其處理方式的邏輯位置。
	//5.function 應在開始，結束或返回之前具有Debug語句。它還應包括Input和Output參數，以幫助調試代碼
	
	//d. getter & setter methods  (Property){
        //1.getter和setter方法的命名約定是“ get” /“ set”，後跟變量名稱，名稱的首字母大寫
        //2.範例
        //I. 
        public string mcustomerID{get; set;}
        //II. 
        public string customerID;    // Variable declaration section         
        public string getCustomerID() {  //Get method definition    
            String ret;
            //Code here    
            return ret ;
        }     
        public string setCustomerID() {  //set method definition        
            String ret;
            //Code here    
            return ret ;
        } 

		//Code here ..
	//}
	
	//e. Action Methods {	

        /***************************************************************************
         * Comments : 請描述此段Methods目的，如果目的過於雜亂，請重新設計架構。
         * input	: Map<Account ID, Account> ,String
         * output   : String 
         ***************************************************************************/
		public String doAddValue(Map<ID, Account> acc_M, String para1) {     
            String ret;
			system.debug('Entering <Method Name>: '+ '<I/P parameters>');     
			//…     
            system.debug('Exiting <Method Name>: ' + '<return value if any>');     
            return ret;   
        }   
        //Code here ..
	//}
	
	//f. Logical Methods {
    public void   Logical_Methods(){
        //For Loop: 
            //The traditional for loop:         
            //for(init_statement; exit_condition; increment_ statement) {              
            for(Integer i=0; i<10; i++){
              // code_block}
            }
            
                
            
            //The list or set iteration for loop: 
            //for(variable : list_or_set) {     
            List<Account> acc_L=[select Id from Account limit 10];
            // for(Account acc : acc_L) {  
            //     // code_block 
            // } 
            
            //The SOQL for loop: 
            //for(variable : [soql_query]) {  
            //for(Account acc : [select Id from Account limit 10]) {          
            //    // code_block 
            //} 
        // end for

        // While Loop: 
            // boolean isDone =false;
            // //..            
            // while(!isDone) {      
            //     //doSomething();     
            //     //isDone = moreToDo();  
            // } 
        //end While

        //if-else:
            // Boolean condition=true;
            // //..
            // //..
            // if(condition) {
            //     //statements;  
            // }
            // 
            // if(condition) {
            //     //statements;  
            // } 
            // else {
            //     //statements;  
            // }  
            // 
            // if(condition) {     
            //     //statements;  
            // } 
            // else if(condition) {
            //     //statements; 
            // } 
            // else {
            //     //statements;  
            // }
        //End if

        //Code here ..
    }   
	//}
	
	//g. Inner Classes and Functions {
		//Code here ..
	//}
}

