public without sharing class AccountList {
    @Auraenabled
    public static List<Account> getAccounts()
    { 
        return ([Select Id,BillingLatitude, BillingLongitude,Name from Account]); 
    }
}