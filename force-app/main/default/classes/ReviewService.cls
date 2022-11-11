public with sharing class ReviewService {

    private static final String ERROR_MESSAGE_EMPTY_MOVIE_ID = 'The movie Id is missing.';
    private static final String ERROR_MESSAGE_EMPTY_REVIEW = 'The review body is missing.';
    private static final String ERROR_MESSAGE_INVALID_RATING = 'The selected rating is invalid.';
    private static final Integer MIN_RATING_VALUE = 0;
    private static final Integer MAX_RATING_VALUE = 10;

    @AuraEnabled(cacheable=true)
    public static List<Review__c> getReviewsByMovieId(String movieId) {
        return [
            SELECT
                Id, Review__c, CreatedDate, Author__c, Rating__c
            FROM
                Review__c
            WHERE
                MovieId__c = :movieId
            ORDER BY
                CreatedDate DESC
        ];
    }

    @AuraEnabled
    public static ReviewCreationResponse createNewReview(Review__c review) {
        try {
            if (String.isBlank(review.MovieId__c)) {
                throw new ReviewServiceException(ERROR_MESSAGE_EMPTY_MOVIE_ID);
            }
            if (String.isBlank(review.Review__c)) {
                throw new ReviewServiceException(ERROR_MESSAGE_EMPTY_REVIEW);
            }
            if (!hasValidRating(review.Rating__c)) {
                throw new ReviewServiceException(ERROR_MESSAGE_INVALID_RATING);
            }
            if (String.isBlank(review.Author__c)) {
                review.Author__c = System.Label.ANONYMOUS_AUTHOR;
            }
            insert review;
            return new ReviewCreationResponse();    
        } catch(Exception e) {
            return new ReviewCreationResponse(e.getMessage());
        }
    }

    private static Boolean hasValidRating(Decimal rating) {
        return rating != null && rating >= MIN_RATING_VALUE && rating <= MAX_RATING_VALUE;
    }

    public class ReviewCreationResponse {

        @AuraEnabled public Boolean isSuccess;
        @AuraEnabled public String errorMessage;

        public ReviewCreationResponse() {
            this.isSuccess = true;
        }

        public ReviewCreationResponse(String errorMessage) {
            this.isSuccess = false;
            this.errorMessage = errorMessage;
        }
    }

    public class ReviewServiceException extends Exception {}
}
