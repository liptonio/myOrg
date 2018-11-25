@isTest
public class TestRestrictContactByName {    
    @isTest static void ContactWithInvalidLastName() {
      
       String s = 'INVALIDNAME';
       String s1 = 'anna';
       Contact cott = new Contact(LastName=s);
       
       Contact cott1 = new Contact(LastName=s1);
       insert cott1;
 
       // Tescik
      Test.startTest();  
         
        try{
            insert cott;
    } catch(Exception e) {
      System.AssertEquals('The Last Name "INVALIDNAME" is not allowed for DML:',e.getMessage());
      //  System.assertEquals(Database, actual)
}       
     Database.SaveResult result = Database.update(cott, false);
     Test.stopTest();
        
   }
    
 }