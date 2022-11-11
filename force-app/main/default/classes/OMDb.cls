public class OMDb {

    private static final Integer STATUS_CODE_SUCCESS = 200;
    private static final String URL_PARAMETER_API_KEY = 'apikey';
    private static final String URL_PARAMETER_SEARCH_TITLE = 's';
    private static final String URL_PARAMETER_MOVIE_ID = 'i';
    private static final String REST_METHOD_GET = 'GET';
    private static final String ERROR_MESSAGE_UNKNOWN = 'An unknown error has occured. Please try later.';

    @AuraEnabled
    public static MovieSearchResult findMovies(String searchText) {
        return (new OMDb()).findMoviesByTitle(searchText);
    }

    @AuraEnabled(cacheable=true)
    public static Movie getMovie(String movieId) {
        return (new OMDb()).getMovieById(movieId);
    }

    public OMDbSetting__mdt integrationSettings;
    private Map<String, String> urlParameters;
    
    public OMDb() {
        this.integrationSettings = getOMDbSettings();
    }

    private OMDbSetting__mdt getOMDbSettings() {
        return [
            SELECT 
                APIKey__c, HostData__c, HostImages__c
            FROM
                OMDbSetting__mdt
            WHERE
                IsSandbox__c = :isCurrentEnvironmentSandbox()
        ];
    }

    private Boolean isCurrentEnvironmentSandbox() {
        return [SELECT IsSandbox FROM Organization][0].IsSandbox;
    }

    public MovieSearchResult findMoviesByTitle(String searchText) {
        setURLParameters(URL_PARAMETER_SEARCH_TITLE, searchText);
        try {
            HttpRequest request = generateHttpRequest();
            HttpResponse response = (new Http()).send(request);
            if (response != null && response.getStatusCode() == STATUS_CODE_SUCCESS) {
                return (MovieSearchResult) JSON.deserialize(response.getBody(), MovieSearchResult.class);
            }    
        } catch(Exception e) {
            return new MovieSearchResult(e.getMessage());
        }
        return new MovieSearchResult(ERROR_MESSAGE_UNKNOWN);
    }

    public Movie getMovieById(String movieId) {
        setURLParameters(URL_PARAMETER_MOVIE_ID, movieId);
        try {
            HttpRequest request = generateHttpRequest();
            HttpResponse response = (new Http()).send(request);
            if (response != null && response.getStatusCode() == STATUS_CODE_SUCCESS) {
                return (Movie) JSON.deserialize(response.getBody(), Movie.class);
            }    
        } catch(Exception e) {
            return new Movie(e.getMessage());
        }
        return new Movie(ERROR_MESSAGE_UNKNOWN);
    }

    private void setURLParameters(String attributeName, String attributeValue) {
        this.urlParameters = new Map<String, String> {
            URL_PARAMETER_API_KEY => integrationSettings.APIKey__c,
            attributeName => attributeValue
        };
    }

    private HttpRequest generateHttpRequest() {
        HttpRequest request = new HttpRequest();
        request.setMethod(REST_METHOD_GET);
        request.setEndpoint(buildHttpRequestEndpoint());
        return request;
    }

    private String buildHttpRequestEndpoint() {
        PageReference pageReference = new PageReference(IntegrationSettings.HostData__c);
        pageReference.getParameters().putAll(urlParameters);
        return pageReference.getUrl();
    }
}
