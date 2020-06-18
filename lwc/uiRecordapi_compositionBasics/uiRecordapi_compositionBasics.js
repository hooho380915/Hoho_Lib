// UiRecordapi_compositionBasics.js
import { LightningElement, api, wire } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';

/*
 取得資料的方式
 1. 搭配 lightning-record-view-form ,lightning-output-field , 並指定 targetConfig 到 object
 2. 透過 @AuraEnabled 由Apex 取得資料
 3. 使用 uiRecordApi 指定Id與 field Name 
*/

/** 
 * 取得欄位時,要連同物件名及欄位名 
*/
const FIELDS = [
    'Contact.Name',
    'Contact.Title',
    'Contact.Phone',
    'Contact.Email',
];
const FIELDS2 = [
    'Account.Name',
    'Account.Rating',
    'Account.Phone',
    'Account.Active__c',
];
export default class UiRecordapi_compositionBasics extends LightningElement {
    @api recordId;

    //這是另類的Query, 直接指定ID,取得Fields
    @wire(getRecord, { recordId: '$recordId', fields: FIELDS })
    contact;

    @wire(getRecord, { recordId: '$recordId', fields: FIELDS2 })
    account;


    get aname() {
        return this.account.data.fields.Name.value;
    }
    get aphone() {
        return this.account.data.fields.Phone.value;
    }

    ////////////////////////////////////
    get name() {
        return this.contact.data.fields.Name.value;
    }

    get title() {
        return this.contact.data.fields.Title.value;
    }

    get phone() {
        return this.contact.data.fields.Phone.value;
    }

    get email() {
        return this.contact.data.fields.Email.value;
    }
}