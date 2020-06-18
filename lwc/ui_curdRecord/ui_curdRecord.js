// Ui_curdRecord.js
import { LightningElement, api, wire } from 'lwc';
//大括弧內的文字是有特定的,並不是變數,不可以亂用
import {getRecord    ,
        updateRecord ,
        createRecord ,
        deleteRecord ,
        getFieldValue 
        } from 'lightning/uiRecordApi';
import { ShowToastEvent }   from 'lightning/platformShowToastEvent';
import { NavigationMixin }  from 'lightning/navigation';
import ID_FIELD             from '@salesforce/schema/Account.Id';
import getContactList       from '@salesforce/apex/ContactController.getContactList';
import getSingleContact     from '@salesforce/apex/ContactController.getSingleContact';
import getAccountById       from '@salesforce/apex/AccountController.getAccountById';
import getAccount           from '@salesforce/apex/AccountController.getAccount';
import getAccountList       from '@salesforce/apex/AccountController.getAccountList';

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
    'Account.Id'    ,
    'Account.Name'  ,
    'Account.Rating',
    'Account.Phone' ,
    'Account.Site'  ,
    'Account.Active__c',
];
/* eslint-disable no-console */
/* eslint-disable no-alert */
/**
 * 很奇怪的是, 
 * Console.log 不能在 default class 下直接使用,但可以在 class 底下的 function 使用
 * ＠wrie 要在 default class 下用,不能在 class 底下的 function 使用
 * 
 *  "executable statements" inside a function
 */
export default class Ui_curdRecord extends LightningElement {
    @api accs;
    @api acc1;
    @api accName ;
    @api accPhone;
    @api recordId;
    @api objectApiName = 'Account';    
    
    //這是另類的Query, 直接指定ID,取得Fields

    @wire(getRecord, { recordId: '$recordId', fields: FIELDS2 }) account;        
    //@wire(getAccountById, { recordId: '$recordId' }) account;
    //@wire(getAccount) account;
    //@wire(getSingleContact) contact;
    

    accountId;
    name = '';
    Site = '';
    Phone= '';
    Rating= '';

    CreateAccount() {

        console.log('CreateAccount');
        // const fields = {};
        //透過 @salesforce/schema/Account.Name 取回欄位並放置於list 中
        //fields[NAME_FIELD.fieldApiName] = this.name;
        //fields[SITE_FIELD.fieldApiName] = this.Site;
        /*
        fields['Name'] = this.name;
        fields['Phone'] = this.Phone;
        fields['Rating'] = this.Rating;
        const recordInput = { apiName: 'Account' , fields };
        */
        /**
         * createRecord ( apiName,fields) 建立資料
         * apiName : 透過 @salesforce/schema/Account 取得
         * fields  : list with @salesforce/schema/Account.fieldsXXXX ...
         */
        let record = {
            apiName: 'Account',
            fields: {
                Name: this.template.querySelector("[data-field='Name']").value,
                Phone: this.template.querySelector("[data-field='Phone']").value,
                Site: this.template.querySelector("[data-field='Site']").value,
                Rating: this.template.querySelector("[data-field='Rating']").value,
            },
        };
        createRecord(record)
            .then(account => {
                // this.accountId = account.id;
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
    
    UpdateAccount(){     
        console.log('UpdateAccount');           
        let record = {
            fields: {
                Id    : this.recordId,
                Name  : this.template.querySelector("[data-field='Name']").value,
                Phone : this.template.querySelector("[data-field='Phone']").value,
                Site  : this.template.querySelector("[data-field='Site']").value,
                Rating: this.template.querySelector("[data-field='Rating']").value, 
            },
        };
        updateRecord(record)
        .then(account => {            
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

    /*
    async ReadAccount() {        
        // const AccL = await getAccountList();
        // if(AccL.data){
        //     acc=AccL.data[3];
        // }
        const AccL = await getAccountList()
            .then(AccL => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Account Read',
                        variant: 'success',
                    }),
                );
                recordId = AccL.data[4].Id;
            })
            .catch(error => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error Read record',
                        message: error.body.message,
                        variant: 'error'
                    })
                );
            });        
    }
    */
    ReadAccount() {

        getAccountList()
            .then(result => {                
                //this.accs = result;   
                this.acc1 = result[4];                
                accName = getFieldValue(this.acc1, 'Name');
                //accPhone = getFieldValue(this.acc1, 'Phone');             
            })
            .catch(error => {
                this.error = error;
            });

        // const AccL = await getAccountList();
        // if(AccL.data){
        //     acc=AccL.data[3];
        // }
        /*
        const AccL =  getAccountList()
            .then(AccL => {                
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Account Read',
                        variant: 'success',
                    }),
                );         
                console.log('AccL.data');
                console.log('AccL.data.length()');
                console.log('AccL.data.length()=' + AccL.data.length());
                console.log('AccL.data=' + AccL.data) ;
                recordId = AccL.data[4].Id;
                account=AccL.data[3]       ;
            })
            .catch(error => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error Read record',
                        message: error.body.message,
                        variant: 'error'
                    })
                );
            });
        */
    }

    DeleteAccount() {        
        deleteRecord(this.recordId)
            .then( ()=>{                
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Account deleted',
                        variant: 'success',
                    }),
                );
                // Navigate to a record home page after
                // the record is deleted, such as to the
                // contact home page
                this[NavigationMixin.Navigate](
                    {
                        type: 'standard__objectPage',
                        attributes: {
                            objectApiName: 'Account',
                            actionName: 'home',
                        },
                    })
                ;
            })
            .catch( error => {
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