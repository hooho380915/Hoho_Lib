import { LightningElement } from 'lwc';

export default class E5_paginator extends LightningElement {
    //因為 dispatchEvent 了一個 new CustomEvent('previous')
    //所以 元件上就會多一個event 屬性 onprevious
    handlePrevious(event) {
        this.dispatchEvent(new CustomEvent('previous'));
    }
    //因為 dispatchEvent 了一個 new CustomEvent('next')
    //所以 元件上就會多一個event 屬性 onnext
    //本身是onclick 連結的, 所以對應的function 可以有event, 但沒有也可以
    handleNext() {
        this.dispatchEvent(new CustomEvent('next'));
    }
}
