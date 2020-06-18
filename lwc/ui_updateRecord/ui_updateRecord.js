// Ui_getRecord.js
import { LightningElement, api, wire } from 'lwc';
//大括弧內的文字是有特定的,並不是變數,不可以亂用
import { getRecord    }     from 'lightning/uiRecordApi';
import { updateRecord }     from 'lightning/uiRecordApi';
import { createRecord }     from 'lightning/uiRecordApi';
import { ShowToastEvent }   from 'lightning/platformShowToastEvent';
import ID_FIELD from '@salesforce/schema/Account.Id';

/*
 取得資料的方式
 1. 搭配 lightning-record-view-form ,lightning-output-field , 並指定 targetConfig 到 object
 2. 透過 @AuraEnabled 由Apex 取得資料
 3. 使用 uiRecordApi 指定Id與 field Name 
*/

/** 
 * 取得欄位時,要連同物件名及欄位名 
*/
const FIELDS2 = [
    'Account.Id',
    'Account.Name',
    'Account.Rating',
    'Account.Phone',
    'Account.Site',
    'Account.Active__c',
];
export default class Ui_updateRecord extends LightningElement {
    @api recordId;
    @api objectApiName = 'Account';    

    //這是另類的Query, 直接指定ID,取得Fields
    @wire(getRecord, { recordId: '$recordId', fields: FIELDS2 })
    account;

    accountId;
    name = '';
    Site = '';
    Phone= '';
    Rating= '';

    handleNameChange(event) {
        this.accountId = undefined;
        this.name = event.target.value;
    }
    handlePhoneChange(event) {
        this.accountId = undefined;
        this.Phone = event.target.value;
    }
    handleRatingChange(event) {
        this.accountId = undefined;
        this.Rating = event.target.value;
    }

    /*
    get accId() {
        accountId = this.account.data.fields.Id.value;
        return accountId ;
    }
    get aname() {
        return this.account.data.fields.Name.value;
    }
    get aPhone() {
        return this.account.data.fields.Phone.value;
    }
    get aRating() {
        return this.account.data.fields.Rating.value;
    }
    */

    UpdateAccount(){
                
        let record = {
            fields: {
                Id    : this.recordId,
                Name  : this.template.querySelector("[data-field='Name']").value,
                Phone : this.template.querySelector("[data-field='Phone']").value,
                Rating: this.template.querySelector("[data-field='Rating']").value, 
            },
        };

       
        updateRecord(record)
        .then(account => {
            this.accountId = account.id;            
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'Account created',
                    variant: 'success',
                }),
            );
        })            
        .catch(error => {            
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error creating record',
                    message: error.body.message,
                    variant: 'error'
                })
            );
        });        
        /*
        .then(() => {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'Contact updated',
                    variant: 'success'
                })
            );
            // Display fresh data in the form
            return refreshApex(this.contact);
        })
        */
        
    }

    CreateAccount() {
        const fields = {};
        //透過 @salesforce/schema/Account.Name 取回欄位並放置於list 中
        //fields[NAME_FIELD.fieldApiName] = this.name;
        //fields[SITE_FIELD.fieldApiName] = this.Site;

        fields['Name'] = this.name;
        fields['Phone'] = this.Phone;
        fields['Rating'] = this.Rating;

        //
        const recordInput = { apiName: 'Account' , fields };
        /**
         * createRecord ( apiName,fields) 建立資料
         * apiName : 透過 @salesforce/schema/Account 取得
         * fields  : list with @salesforce/schema/Account.fieldsXXXX ...
         */
        createRecord(recordInput)
        .then(account => {
            this.accountId = account.id;
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'Account created',
                    variant: 'success',
                }),
            );
        })
        .catch(error => {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error creating record',
                    message: error.body.message,
                    variant: 'error',
                }),
            );
        });
    }

    
}