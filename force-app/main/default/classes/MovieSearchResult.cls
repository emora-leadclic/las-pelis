public class MovieSearchResult extends OMDbResponse{

    public List<Movie> Search;
    public String totalResults;

    public MovieSearchResult(String errorMessage) {
        super(errorMessage);
    }
}
