/** 
 * 
*/
import { LightningElement, wire, track } from 'lwc';
import getContactList from '@salesforce/apex/ContactController.getContactList';

export default class E8_apexWireMethodToFunction extends LightningElement {
    @track contacts;
    @track error;

    @wire(getContactList)
    wiredContacts({ error, data }) {
        if (data) {
            this.contacts = data;
        }
        else if (error) {
            this.error = error;
        }
    }
}