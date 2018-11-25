public class AddPrimaryContact implements Queueable{
    
    private Contact contacts;
    private string State;
    
    public AddPrimaryContact(Contact contacts, string state) {
        this.contacts = contacts;
        this.state = state;
    }

    public void execute(QueueableContext context) {
         List<Account> ListAccount = [SELECT ID, Name ,(Select id,FirstName,LastName from Contacts ) FROM ACCOUNT WHERE BillingState = :state LIMIT 200];
         List<Contact> lstContact = new List<Contact>();
        for (Account acc : ListAccount) {
            Contact con = contacts.clone(false,false,false);
            // perform other processing or callout
        }
        update ListAccount;
    }
    
}