import { LightningElement, api } from 'lwc';
import STATIC_RESOURCES from '@salesforce/resourceUrl/LasPelis';

export default class SearchListItem extends LightningElement {

    @api movie;
    posterPlaceholderURL = STATIC_RESOURCES + '/poster-placeholder.jpg';

    handleMovieClick() {
        this.dispatchEvent(new CustomEvent('movieselected', {
            detail: {
                movieId: this.movie.imdbID
            },
            bubbles: true,
            composed: true
        }));
    }

    get moviePoster() {
        if (this.movie.Poster && this.movie.Poster != 'N/A') {
            return this.movie.Poster;
        }
        return this.posterPlaceholderURL;
    }
}