public class RandomContactFactory {

    
    public static List<Contact> generateRandomContacts(Integer numberofcontacts, string lastnejm) {
        
         List<Contact> coont = new List<Contact>();

       
        for(Integer i=0;i<numberofcontacts;i++) {
            Contact c = new Contact(FirstName='dziecko'+i, LastName=lastnejm);
            coont.add(c);
        }
        return coont;

}
}