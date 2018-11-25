public class ContactAndLeadSearch {

    public static  List<List< SObject>> searchContactsAndLeads(string str ){
        
        
     List<List< SObject>> szukaj = [FIND :str IN ALL FIELDS RETURNING Contact(FirstName,LastName) , Lead(FirstName,LastName)];
         return szukaj;
    }
   
}