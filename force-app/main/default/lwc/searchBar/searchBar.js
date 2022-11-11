import { LightningElement } from 'lwc';

const MIN_SERCH_TEXT_LENGTH = 3;

export default class SearchBar extends LightningElement {

    timer;

    handleSearchChanges(event) {
        clearTimeout(this.timer);
        if (event.target.value.length > MIN_SERCH_TEXT_LENGTH) {
            this.timer = setTimeout((movieTitle) => {
                this.dispatchEvent(new CustomEvent('search', {
                    detail: {
                        movieTitle: movieTitle
                    }
                }));
            }, 300, event.target.value);    
        } 
    }
}