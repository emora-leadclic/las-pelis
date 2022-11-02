public virtual class OMDbResponse {

    private static final String RESPONSE_SUCCESS = 'True';
    private static final String RESPONSE_ERROR = 'False';

    public String Response;
    public String Error;

    public OMDbResponse(String errorMessage) {
        this.Response = RESPONSE_ERROR;
        this.Error = errorMessage;
    }

    public OMDbResponse() {
    }
}
