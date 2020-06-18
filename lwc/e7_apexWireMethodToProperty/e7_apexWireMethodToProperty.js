/** 
* The *@wire* decorator is used to put the return value of the call to *getContactList() *into the contacts local property.  
  This happens automatically (to do it 'on demand' see the ApexImperativeMethod 
  (https://github.com/trailheadapps/lwc-recipes/tree/master/force-app/main/default/lwc/apexImperativeMethod) recipe.  
  @wire decorated properties are reactive (UI rerenders if its value changes).
* We still need the *@AuraEnabled* decorator as we did for an Aura Lightning Component.
* We are using the new (Winter 19) cacheable=true attribute which means to let the platform (LDS) take care of the data caching and renewal.
* In the markup, the *if:true* construct is used, which will poll to see if the *contacts.data* has been returned yet. If so, it will render the contacts in *for:each* iteration loop.  From the documentation (https://developer.salesforce.com/docs/component-library/documentation/lwc/lwc.data_wire_service_about): If the property decorated with @wire is used as an attribute in the template and its value changes, the wire service provisions the data and triggers the component to rerender. The property is private, but reactive, like a property decorated with @track.
* The wire service operates one way - it only gets data.  
  If we want to do CRUD operations we need to use 
  Lightning Data Service or the lightning/uirecordApi 
  (https://developer.salesforce.com/docs/component-library/documentation/lwc/lwc.reference_lightning_ui_api_record)
*/
import { LightningElement, wire, api, track } from 'lwc';
import getContactList             from '@salesforce/apex/ContactController.getContactList';
import getAccountList             from '@salesforce/apex/AccountController.getAccountList';
import getAccount                 from '@salesforce/apex/AccountController.getAccount';

export default class E7_apexWireMethodToProperty extends LightningElement { 
    @api acc;
    @wire(getContactList) contacts;
    @wire(getAccountList) accounts;
    @wire(getAccount)     acc1;
    @wire(getAccount)     getAcc({ error, data }) {
      if (data) {
        this.acc = data;
      }
      else if (error) {
        this.error = error;
      }
    }
}