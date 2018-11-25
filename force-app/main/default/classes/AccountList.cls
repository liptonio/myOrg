public without sharing class AccountList {
    @Auraenabled
    public static List<Account> getAccounts()
    { 
        List<Account> ACC = [Select Id,BillingLatitude, BillingLongitude,Name from Account WHERE BillingLatitude != NULL ];
        return ACC;
    }
}