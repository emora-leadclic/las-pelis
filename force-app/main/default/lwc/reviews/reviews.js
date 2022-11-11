import { LightningElement, api, wire } from 'lwc';
import getReviews from '@salesforce/apex/ReviewService.getReviewsByMovieId';
import { refreshApex } from '@salesforce/apex';

const TABLE_COLUMNS = [
    { label: 'Autor', fieldName: 'Author__c' },
    { label: 'Valoración', fieldName: 'Rating__c'},
    { label: 'Fecha', fieldName: 'CreatedDate', type: 'date' },
    { label: 'Review', fieldName: 'Review__c'}
];

export default class Ratings extends LightningElement {

    @api movieId;
    columns = TABLE_COLUMNS;

    @wire(getReviews, {movieId: '$movieId'})
    reviews;

    @api
    refresh() {
        refreshApex(this.reviews);
    }

    get hasReviews() {
        return this.reviews.data && this.reviews.data.length > 0;
    }
}