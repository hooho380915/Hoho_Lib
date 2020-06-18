import { LightningElement, track } from 'lwc';

export default class E5_eventSimple extends LightningElement {
    @track page = 1;

    handlePrevious() {
        if (this.page > 1) {
            this.page = this.page - 1;
        }
    }

    doNext() {
        this.page = this.page + 2;
    }
}