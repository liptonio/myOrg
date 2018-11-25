public class ContactSearch {
    
    public static List<Contact> searchForContacts(string lastName , string mailingpostalcode ){
    List<Contact> cos1 = [Select ID,Mailingpostalcode,LastName,Name From Contact WHERE LastName =:lastName AND Mailingpostalcode =: mailingpostalcode ];
        
         return cos1;
    }
   
     

}