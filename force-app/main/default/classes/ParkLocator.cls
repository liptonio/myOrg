public class ParkLocator {

   	
    public static list<String> country(String Country) {
        ParkService.ParksImplPort parks = new ParkService.ParksImplPort();
        return parks.byCountry(Country);
    }
}