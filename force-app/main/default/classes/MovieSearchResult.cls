public class MovieSearchResult extends OMDbResponse {

    @AuraEnabled public List<Movie> Search;
    @AuraEnabled public String totalResults;

    public MovieSearchResult(String errorMessage) {
        super(errorMessage);
    }
}
