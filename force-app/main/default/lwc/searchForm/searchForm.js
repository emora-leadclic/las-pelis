import { LightningElement, wire } from 'lwc';
import findMovies from '@salesforce/apex/OMDb.findMovies';

export default class SearchForm extends LightningElement {
    
    movies;

    searchMovies(event) {
        findMovies({
            searchText: event.detail.movieTitle
        }).then(searchResults => {
            this.movies = searchResults.Search;
        });
    }
}