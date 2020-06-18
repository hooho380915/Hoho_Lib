import { LightningElement, api } from 'lwc';

export default class E3_contactTile extends LightningElement {
    // 當變數被定義為 @api , 則 被視為 property , 變數於 component 可輸入
    // *@api  meaning it is a public variable we can set from outside. 
    @api contact;
    @api memo;
    
}