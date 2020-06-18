/*
* In [simpleSub.js] we have a couple of @track properties that will auto update in the UI if detected to have changed.
* We use the [connectedCallback()] standard Web Component lifecycle method to do initialization - in this case calling the *registerListener() *pubsub method to setup the handler of the *sendone* event published from simplePub.  In Aura, we would have done this by with a proprietary *<aura:handler>* tag.
* When the event *sendone* is received, the [handleSendOne()] method is invoked which gets the data out of the event, and updates the local properties.  Since they are decorated with *@track* we see them updated in the UI immediately.
* We need to [unregisterAllListeners()] in the [disconnectedCallback()] lifecycle method.
*/
import { LightningElement, wire, track } from 'lwc';
import { CurrentPageReference } from 'lightning/navigation';  // using page ref to restrict scope
//
import { registerListener, unregisterAllListeners, } from 'c/pubsub';

export default class e6_SimpleSub extends LightningElement {
    @track receivedOne;
    @track someValue;
    @wire(CurrentPageReference) pageRef;

    disconnectedCallback() {
        unregisterAllListeners(this);
    }
    //
    connectedCallback() {
        registerListener('sendone', this.handleSendOne, this);
    }    
    handleSendOne(event) {
        this.receivedOne    = event.theString;
        this.someValue      = event.someValue;
    }
}