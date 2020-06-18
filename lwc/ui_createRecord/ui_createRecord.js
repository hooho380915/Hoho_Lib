import { LightningElement } from 'lwc';
import { createRecord }     from 'lightning/uiRecordApi';
import { ShowToastEvent }   from 'lightning/platformShowToastEvent';
import ACCOUNT_OBJECT       from '@salesforce/schema/Account';
import NAME_FIELD           from '@salesforce/schema/Account.Name';
import SITE_FIELD           from '@salesforce/schema/Account.Site';

export default class Ui_createRecord extends LightningElement {
    accountId;
    name = '';
    Site = '';

    handleNameChange(event) {
        this.accountId = undefined;
        this.name = event.target.value;
    }
    handleSiteChange(event) {
        this.accountId = undefined;
        this.Site = event.target.value;
    }
    createAccount() {
        const fields = {};
        //透過 @salesforce/schema/Account.Name 取回欄位並放置於list 中
        fields[NAME_FIELD.fieldApiName] = this.name;
        fields[SITE_FIELD.fieldApiName] = this.Site;
        //
        const recordInput = { apiName: ACCOUNT_OBJECT.objectApiName, fields };
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