public class Movie extends OMDbResponse {

    @AuraEnabled public String Title;
    @AuraEnabled public String Year;
    @AuraEnabled public String Rated;
    @AuraEnabled public String Released;
    @AuraEnabled public String Runtime;
    @AuraEnabled public String Genre;
    @AuraEnabled public String Director;
    @AuraEnabled public String Writer;
    @AuraEnabled public String Actors;
    @AuraEnabled public String Plot;
    @AuraEnabled public String Language;
    @AuraEnabled public String Country;
    @AuraEnabled public String Awards;
    @AuraEnabled public String Poster;
    @AuraEnabled public String Metascore;
    @AuraEnabled public String imdbRating;
    @AuraEnabled public String imdbVotes;
    @AuraEnabled public String imdbID;
    @AuraEnabled public String Type;
    @AuraEnabled public String DVD;
    @AuraEnabled public String BoxOffice;
    @AuraEnabled public String Production;
    @AuraEnabled public String Website;
    @AuraEnabled public List<Rating> Ratings;

    public Movie(String errorMessage) {
        super(errorMessage);
    }

    public class Rating {

        @AuraEnabled public String Source;
        @AuraEnabled public String Value;
    }
}
