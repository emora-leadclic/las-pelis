import { LightningElement } from 'lwc';

export default class LasPelisPage extends LightningElement {

    isMovieDetailView = false;
    selectedMovieId;

    setNewMovie(event) {
        this.isMovieDetailView = true;
        this.selectedMovieId = event.detail.movieId;
    }

    navigateToSearch() {
        this.isMovieDetailView = false;
    }
}