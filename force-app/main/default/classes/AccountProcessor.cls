global class AccountProcessor {
  @future
  public static void countContacts(List<Id> recordIds) {
    List<Account> konta = [Select Id,Number_of_Contacts__c,(Select id from Contacts) Name from Account Where Id IN :recordIds];
   
      for (Account acc: konta) {
          List<Contact> listc = acc.contacts;
      
           acc.Number_of_Contacts__c = listc.size();
        }
      update konta;
  }
}