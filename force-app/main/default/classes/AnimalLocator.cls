public class AnimalLocator {

         public static string getAnimalNameById(Integer ID) {
         string finalresponse = '';    
              
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/'+ ID);
        request.setMethod('GET');  
        HttpResponse response = http.send(request); 
        if (response.getStatusCode() == 200) { 
            Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
			Map<String, Object> animals = (Map<String, Object>) results.get('animal');
  		     system.debug(results);
             system.debug(animals);
             finalresponse = string.valueof(animals.get('name'));
             system.debug(finalresponse);
        }
  
        return finalresponse;
    }
    
    }