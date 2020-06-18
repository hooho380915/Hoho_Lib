/**
 * 
 */
import { LightningElement, api } from 'lwc';

export default class E9_recordViewFormDynamicContact extends LightningElement {
    // Flexipage provides recordId and objectApiName
    @api recordId;
    @api objectApiName;
}