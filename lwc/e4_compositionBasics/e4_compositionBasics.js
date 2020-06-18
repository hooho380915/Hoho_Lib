import { LightningElement } from 'lwc';

export default class E4_compositionBasics extends LightningElement {
    myContact =
        {
            Name: 'Amy Taylor',
            Title: 'VP of Engineering',
            Phone: '6172559632',
            Picture__c:
                'https://s3-us-west-1.amazonaws.com/sfdc-demo/people/amy_taylor.jpg',
        };
    myMemo = 'Test';
}