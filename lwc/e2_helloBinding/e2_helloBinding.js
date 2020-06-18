//同名 js 一定要存在
//一定要有 LightningElement
//From 後面要用單引號 ,且lwc 要小寫
//大括弧內的東西是要導入的功能,ex: LightningElement , track
//@track裝飾器使UI跟踪JavaScript變量的更改
//  //@track
//=> 無法確認 @track 的用處, 似乎不用也可以
import { LightningElement, track } from 'lwc';

//注意,要了解 class Name 大小寫有無差異
//=> 只要有 default class 關鍵字,至於 class Name 是什麼則不影響
//=> 另外 default class 一定要存在,要不無法讓 Template 被解析解析
export default class E2_helloBinding extends LightningElement {
    Name1 = 'Alex';

    @track Name2 = 'Doris';

    //event 是畫面傳過來的
    handleChange1(event) {
        this.Name1 = event.target.value;
    }
    handleChange2(event) {
        this.Name2 = event.target.value;
    }
}
