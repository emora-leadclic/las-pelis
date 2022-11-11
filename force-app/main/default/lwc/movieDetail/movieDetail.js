import { LightningElement, api, wire } from 'lwc';
import getMovie from '@salesforce/apex/OMDb.getMovie';
import STATIC_RESOURCES from '@salesforce/resourceUrl/LasPelis';

export default class MovieDetail extends LightningElement {

    @api movieId;
    movie;
    posterPlaceholderURL = STATIC_RESOURCES + '/poster-placeholder.jpg';

    @wire(getMovie, {movieId: '$movieId'})
    wiredMovie({error, data}) {
        if (data) {
            this.movie = data;
            console.log(data);
        } else if (error) {
            console.log(error);
        }
    }

    get moviePoster() {
        if (this.movie.Poster && this.movie.Poster != 'N/A') {
            return this.movie.Poster;
        }
        return this.posterPlaceholderURL;
    }

    navigateToSearch() {
        this.dispatchEvent(new CustomEvent('back'));
    }

    refreshReviews() {
        this.template.querySelector('c-reviews').refresh();
    }
}