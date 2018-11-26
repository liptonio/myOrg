/**********************************************************************
 Name:  CORE_GSK_PD_searchAccountsController()
 Copyright © 2018  GSK
 ======================================================
======================================================
Purpose:                                                            
SBC: Veeva network has to be disabled                                                            
======================================================
======================================================
History                                                            
-------                                                            
VERSION                 AUTHOR            DATE              DETAIL            Description
1.0                   MACIEJ MACIAG      24.06.2018                        INITIAL DEVELOPMENT
***********************************************************************/


public without sharing class CORE_GSK_PD_searchAccountsController {  
    

    
    public static String searchTextName {get;set;}      				// Account name from VF page
    public static String searchTextLocation {get;set;}  				// Location 
    public string currentAccountId {get;set;}          			   	    // Current ID of clicked account on VF page
    public string currentAccountName {get;set;}							// Current account name displayed in right section of a page
    public string currentAccountType {get;set;}			 				// Current account type which render displyed images
    public string currentPrimaryParentName {get;set;}					// Current primary parent name 
    public string selectedAccounts{get;set;}							// Variable to hold picklist value from VF Page HCO/HCP
    public string accInTerritory {get;set;}								// Variable to indicate if displayed account is in my territory
    public List<Accounts> accountResultSorted  {get;set;}				// Variable to store sorted list of accounts from Reltio	
    public List<Accounts> accountResult  {get;set;}						// Account list from Reltio database	
    public integer insideTerritoryCount {get;set;}						// Variable to store number of accounts inside my territory
    public integer outsideTerritoryCount {get;set;}						// Variable to store number of accounts outside of my territory
    public integer limitRows {get;set;}									// Variable to store maximum number of accounts beeing displayed on page
    public string requestLabel;											// Variable to hold HTTP request for the callout that is associated with Continuation Object.
    public boolean rerenderFlag {get;set;}								// Flag to toggle visibility result and professional section of visualforce page
    public boolean newAccountToggle {get;set;}							// Flag to toggle visibility of new account button
    public List<Address_vod__c> addresList = new List<Address_vod__c>();//Variable to store list of addreses 
    Map<String,List<RelAddress>> listOfAdr = new Map<String,List<RelAddress>>();//Variable to store list of addresses per account
    
    
    public CORE_GSK_PD_searchAccountsController(ApexPages.StandardController controller) {
        limitRows = 0;
        insideTerritoryCount = 0;
        outsideTerritoryCount = 0;
        accountResultSorted = new List<Accounts>();
        accountResult = new List<Accounts>();
        rerenderFlag=false;
		newAccountToggle=false;        
        currentAccountName = '';
        searchTextName = '';
        searchTextLocation = '';
        currentAccountId = '';
        currentAccountName = '';
        currentAccountType = '';
        accInTerritory = '';     
        
    }
    
    public Object runAccountSync(){
        
        Id currentId = Userinfo.getUserId();				
        String countryCode =  [SELECT Country FROM User WHERE Id =:currentId LIMIT 1].Country;
        
        Continuation con = new Continuation(120);		    //Creates an instance of the Continuation class by using the specified timeout in seconds. The timeout maximum is 120 seconds.
        
        if (string.isEmpty(searchTextName)  || searchTextName == null )    {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,Label.CORE_GSK_PD_Two_Char));
        } else if(searchTextName.length() <2) {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,Label.CORE_GSK_PD_Two_Char));
        }else{ 
            if(selectedAccounts == 'All') {
                selectedAccounts = '';
            }
            String encodedType ='';
            
            // MK: spaces to commas replacement
            String encodedName = EncodingUtil.urlEncode(searchTextName.replaceAll(' ', ','), 'UTF-8'); 
            String encodedLocation = EncodingUtil.urlEncode(searchTextLocation.replaceAll(' ', ','), 'UTF-8');
            
            if(selectedAccounts != null){
                encodedType = EncodingUtil.urlEncode(selectedAccounts, 'UTF-8');    
            }
            
            accountResult.clear();						
            con.continuationMethod='processResponse';        //The name of the callback method that is called after the callout response returns.
            Http http = new Http();
            HttpRequest req = new HttpRequest();	
            req.setEndpoint('callout:CORE_GSK_PD_Reltio/mdmEntities?searchTerms='+encodedName+'&location='+encodedLocation+'&type='+encodedType+'&countryISO='+countryCode);
            req.setMethod('GET');
            
            this.requestLabel = con.addHttpRequest(req);    //Adds the HTTP request for the callout that is associated with this continuation.
        } 
        return con;    
    }
    
    public void processResponse(){
        limitRows =0;
        insideTerritoryCount = 0;
        outsideTerritoryCount = 0;
        accountResultSorted.clear();
        
        HttpResponse response = Continuation.getResponse(this.requestLabel);  //Returns the response for the request that corresponds to the specified label.
        
        if (response.getStatusCode() == 200) {
            String stringAccountId = '';
            String accountType = '';
            List<Account> allAccountsInMyTerritory = [SELECT Id, Name FROM Account USING SCOPE My_Territory ORDER BY Id DESC];
            
            Set<Id> allAccountsInMyTerritoryId = new Set<Id>();
            for(Account accs : allAccountsInMyTerritory ){
                allAccountsInMyTerritoryId.add(accs.id);
            }
            
            List<RelAccount>  relAccountList = (List<RelAccount>) JSON.deserialize(response.getBody(), List<RelAccount>.class);
            
            for(RelAccount relacc: relAccountList){
                
                // if there is no veeva ID, skip this record
                if (relacc.veevaId == null || relacc.veevaId.length() == 0) 
                    continue;
                
                limitRows++;
                if(limitRows <= 50) {
                    
                    if(!string.isEmpty(relacc.veevaId)){
                        stringAccountId = relacc.veevaId.substring(relacc.veevaId.lastIndexOf('_')+1,relacc.veevaId.length());
                        accountType = relacc.veevaId.substring(0,relacc.veevaId.indexOf('_'));
                    }
                    Id accountId = (Id) stringAccountId;    
                    listOfAdr.put(accountId,relacc.addresses);
                    
                    Accounts acc = new Accounts();
                    if(accountType == 'HCP'){
                        
                        List<RelAddress> adrrr1 = listOfAdr.get(stringAccountId);
                        if(adrrr1 != null ){
                            for(RelAddress adsr : adrrr1){
                                if(adsr.primary == 'true'){
                                    acc.accAddress = adsr.addressLine1  +' ,'+ adsr.city +' ,'+ adsr.country;
                                }   
                            }  
                        }
                        acc.primaryParentName = relacc.primaryParentName;
                        acc.accType = 'HCP';    
                        acc.accName = relacc.firstName +','+relacc.lastName+ '  '+'@ '+relacc.primaryParentName;
                        acc.accId = accountId;
                        if(allAccountsInMyTerritoryId.contains(accountId)){
                            insideTerritoryCount++;
                            acc.isInTerritory = 'true';
                            
                        } else {
                            acc.isInTerritory = 'false';
                            outsideTerritoryCount++;
                        }                        
                    }
                    if(accountType == 'HCO'){
                        List<RelAddress> adrrr1 = listOfAdr.get(stringAccountId);
                        if(adrrr1 != null ){
                            for(RelAddress adsr : adrrr1){
                                if(adsr.primary == 'true'){
                                    acc.accAddress = adsr.addressLine1  +' ,'+ adsr.city +' ,'+ adsr.country;
                                }   
                            }  
                        }
                        
                        acc.primaryParentName = relacc.primaryParentName;
                        acc.accType = 'HCO';
                        acc.accName = relacc.name+'  '+'@ '+relacc.primaryParentName;
                        acc.accId = accountId;
                        if(allAccountsInMyTerritoryId.contains(accountId)){
                            acc.isInTerritory = 'true';
                            insideTerritoryCount++;
                        }else {
                            acc.isInTerritory = 'false';
                            outsideTerritoryCount++;
                        }
                        
                    }   
                    accountResult.add(acc);  
                }
            }
            
            for(Accounts acas: accountResult){
                if(acas.isInTerritory =='true'){
                    if(accountResultSorted.size() == 0){
                        accountResultSorted.add(acas);  
                    } else {
                        accountResultSorted.add(0,acas);
                    }
                    
                }
                if(acas.isInTerritory =='false'){
                    accountResultSorted.add(acas);
                }
            } 
            if (accountResultSorted.size() >= 50 ) {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Warning,Label.CORE_GSK_PD_50Acc));  
            }
            relAccountList.clear();
            
            if(accountResultSorted.size() > 0 || !accountResultSorted.isEmpty() ){
                currentAccountId = accountResultSorted.get(0).accId;
                currentAccountName = accountResultSorted.get(0).accName;
                currentAccountType = accountResultSorted.get(0).accType;
                accInTerritory = accountResultSorted.get(0).isInTerritory;
                currentPrimaryParentName = accountResultSorted.get(0).primaryParentName;
                rerenderFlag = true;
                newAccountToggle = true;
                
                
                
            } else {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,Label.CORE_GSK_PD_No_accounts));  
                rerenderFlag=false;
                newAccountToggle=true;
            }
        } else if (response.getStatusCode() == 500){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,Label.CORE_GSK_PD_No_accounts));  // server error needs to be checked !!
            rerenderFlag=false;
            newAccountToggle=false;
        } else if (response.getStatusCode() == 501){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,Label.CORE_GSK_PD_No_accounts));
            rerenderFlag=false;
            newAccountToggle=false;
        } else {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,Label.CORE_GSK_PD_Integration_Error));
            rerenderFlag=false;
            newAccountToggle=false;
        }
        
    }
    
    public List<Selectoption> getAcountsForRecordType() {
        List<Selectoption> listOfAccounts = new List<selectoption>();
        listOfAccounts.add(new selectOption('All', 'All'));
        listOfAccounts.add(new selectOption('HCP', 'HCP'));
        listOfAccounts.add(new selectOption('HCO', 'HCO'));
        return listOfAccounts;
    }
    
    public  List<RelAddress> getDetails(){
        
        List<RelAddress> adrrr = listOfAdr.get(currentAccountId);
        
        return adrrr;   
    }
    
    public PageReference getTerritory(){
        // cast currentAccountId to Id type to convert 15digit to 18 digit ID
        Id accountId = (Id) currentAccountId;   		
        
        List<UserTerritory> utList = [select Id, UserId, TerritoryId from UserTerritory where UserId = :UserInfo.getUserId()];
        String territoryNames ='';
        List<Id> territoryIds = new List<Id>();
        
        // get only territory ID to list<ID>
        for(UserTerritory utl : utList){
            territoryIds.add(utl.TerritoryId);
        }

        
        List<Territory> terList = [SELECT Name FROM Territory WHERE Id IN: territoryIds];
        // get only territory names for current user
        for(Territory trName : terList){
            territoryNames += trName.Name + ';';     
        }
        // check if user has territory
        if (utList.size() == 0) { 
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,Label.CORE_GSK_PD_NoTerritory_Assigned));
            return null;
        } else {
            List<Account_Territory_Loader_vod__c> userATL = [SELECT Id, Territory_vod__c, Territory_To_Add_vod__c, External_ID_vod__c, Account_vod__c FROM Account_Territory_Loader_vod__c WHERE Account_vod__c =:accountId LIMIT 1];
            
            if(userATL.size() > 0) {
                userATL[0].Territory_To_Add_vod__c = territoryNames;
                try{
                    update userATL;
                    
                } catch(Exception e) {
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,e.getMessage()));
                }
            } else {
                Account_Territory_Loader_vod__c newATL = new Account_Territory_Loader_vod__c();
                newATL.Territory_To_Add_vod__c = territoryNames;
                newATL.Account_vod__c = currentAccountId;
                try{
                    insert newATL;
                    
                } catch(Exception e) {
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,e.getMessage()));
                }
            }
            
            PageReference acctPage = new PageReference('/' + accountId);   
            acctPage.setRedirect(true);
            return acctPage;
        }
    }
    public PageReference setAccountDetailsInApex() {    // Javascript method to hold paramiters such as Id,Name for selected account to render right section of page
        return null;
    }
    public PageReference redirect() {					// PageReference method to redirec to existing account in veeva database
        
        PageReference acctPage = new PageReference('/' + currentAccountId);   
        acctPage.setRedirect(true);
        return acctPage;
    }
    // Wraper class to hold response objects
    public class RelAccount {
        public string mdmId {get;set;}
        public string firstName {get;set;}
        public string lastName {get;set;}
        public string veevaId {get;set;}
        public string name {get;set;}
        public string primaryParentName {get;set;}
        List<RelAddress> addresses {get;set;}
        public RelAccount() {}
        
    }
    // Wraper class to hold list of addresses
    public class RelAddress {
        public string addressLine1 {get;set;}
        public string primary {get;set;}
        public string city {get;set;}
        public string country {get;set;}
        public RelAddress(){}
    }
    // Wraper class to hold accounts beeing received from MDM
    public class Accounts {
        public string accAddress {get;set;}
        public string accType {get;set;}
        public string isInTerritory {get;set;}
        public string accName {get;set;}
        public string accId {get;set;}
        public string primaryParentName {get;set;}
        public Accounts() {}
    }
    
}