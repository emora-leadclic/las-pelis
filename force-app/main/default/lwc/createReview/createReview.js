import { LightningElement, api } from 'lwc';
import saveReview from '@salesforce/apex/ReviewService.createNewReview';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

import AUTHOR_FIELD from '@salesforce/schema/Review__c.Author__c';
import REVIEW_FIELD from '@salesforce/schema/Review__c.Review__c';
import RATING_FIELD from '@salesforce/schema/Review__c.Rating__c';
import REVIEW_OBJECT_NAME from '@salesforce/schema/Review__c';

const SUCCESS_TITLE = 'Review Created!';
const SUCCESS_VARIANT = 'success';
const ERROR_TITLE = 'Error';
const ERROR_VARIANT = 'error';


export default class CreateReview extends LightningElement {

    @api movieId;

    reviewObjectName = REVIEW_OBJECT_NAME;
    ratingFieldName = RATING_FIELD;
    reviewFieldName = REVIEW_FIELD;
    authorFieldName = AUTHOR_FIELD;

    handleSubmit(event) {
        event.preventDefault();
        let review = event.detail.fields;
        review.MovieId__c = this.movieId;
        saveReview({
            review: review
        }).then(saveResult => {
            if (saveResult.isSuccess) {
                this.dispatchEvent(new CustomEvent('reviewcreated'));
                this.dispatchEvent(new ShowToastEvent({
                    title: SUCCESS_TITLE,
                    variant: SUCCESS_VARIANT
                }));   
                this.resetForm();
            } else {
                this.dispatchEvent(new ShowToastEvent({
                    title: ERROR_TITLE,
                    variant: ERROR_VARIANT,
                    message: saveResult.errorMessage
                }));        
            }
        } );
    }

    resetForm() {
        const inputFields = this.template.querySelectorAll('lightning-input-field' );
        if (inputFields) {
            inputFields.forEach(field => {
                field.reset();
            });
        }
    }
}