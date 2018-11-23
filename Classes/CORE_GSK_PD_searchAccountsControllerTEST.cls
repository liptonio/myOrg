/**********************************************************************
 Name:  CORE_GSK_PD_searchAccountsControllerTEST()
 Copyright © 2018  GSK
 ======================================================
======================================================
Purpose:                                                            
SBC test class: Veeva network has to be disabled                                                            
======================================================
======================================================
History                                                            
-------                                                            
VERSION                 AUTHOR            DATE              DETAIL            Description
1.0                   MACIEJ MACIAG      24.06.2018                        INITIAL DEVELOPMENT
***********************************************************************/

@isTest
public class CORE_GSK_PD_searchAccountsControllerTEST {
    
    @isTest
    public static  void testWebServiceForHCO() {
        
        Account a = new Account(LastName='Lopez-Gonzalez Garrido, Carlos Consulta',FirstName='HCO90806');
        ApexPages.StandardController testSetController = new ApexPages.StandardController(a);
        CORE_GSK_PD_searchAccountsController controller = new CORE_GSK_PD_searchAccountsController(testSetController);
        
        CORE_GSK_PD_searchAccountsController.searchTextName = 'roberto';   
        CORE_GSK_PD_searchAccountsController.searchTextLocation =  'spain';
        controller.currentAccountType = 'HCO';
        controller.accInTerritory = 'true'; 
        controller.currentAccountId = '0015800000YMVlGAAX';    
        controller.currentAccountName = 'roberto';
        // Invoke the continuation by calling the action method
        Continuation conti = (Continuation)controller.runAccountSync();
        
        // Verify that the continuation has the proper requests
        Map<String, HttpRequest> requests = conti.getRequests();
        
        system.assert(requests.size() == 1);
        system.assert(requests.get(controller.requestLabel) != null);
        
        // Perform mock callout 
        // (i.e. skip the callout and call the callback method)
        HttpResponse response = new HttpResponse();
        response.setStatusCode(200);
        response.setBody('[{"mdmId":"HCO90806","veevaId":"HCO_EU1_0015800000YMVlGAAX","status":"Active","name":"Lopez-Gonzalez Garrido, Carlos Consulta","firstName":"test","lastName":"test","recordType":"Organization_vod","addresses":[{"primary":"true","addressLine1":"Teniente Arrabal, 9","addressLine2":"Edificio Anteo 3.1Âº A","addressLine3":"","city":"Ceuta","country":""}],"primaryParentIdentifier":"TBC"}]');
        
        // Set the fake response for the continuation     
        Test.setContinuationResponse(controller.requestLabel, response);
        // Invoke callback method
        Object result = Test.invokeContinuationMethod(controller, conti);
        // result is the return value of the callback
        
        
        
        test.startTest();
        controller.setAccountDetailsInApex();
        List<SelectOption> options = controller.getAcountsForRecordType();
        test.stopTest();
        
        system.assertEquals(options.get(0).getValue(), 'All');
        System.assertEquals(null, result);					 // check if result is not null JSON etc.
       // System.assertEquals(a, controller.accountResult[0]); // check if both account are the same
        
        
    }
    
    @isTest
    public static  void testWebServiceForHCP() {
    Account a = new Account(LastName='Lopez-Gonzalez Garrido, Carlos Consulta',FirstName='HCO90806');
        ApexPages.StandardController testSetController = new ApexPages.StandardController(a);
        CORE_GSK_PD_searchAccountsController controller = new CORE_GSK_PD_searchAccountsController(testSetController);
        
        CORE_GSK_PD_searchAccountsController.searchTextName = 'roberto';   
        CORE_GSK_PD_searchAccountsController.searchTextLocation =  'spain';
         controller.currentAccountType = 'HCP';
        controller.accInTerritory = 'true'; 
        controller.currentAccountId = '0015800000YMVlGAAX';    
        controller.currentAccountName = 'roberto';
        // Invoke the continuation by calling the action method
        Continuation conti = (Continuation)controller.runAccountSync();
        
        // Verify that the continuation has the proper requests
        Map<String, HttpRequest> requests = conti.getRequests();
        
        system.assert(requests.size() == 1);
        system.assert(requests.get(controller.requestLabel) != null);
        
        // Perform mock callout 
        // (i.e. skip the callout and call the callback method)
        HttpResponse response = new HttpResponse();
        response.setStatusCode(200);
        response.setBody('[{"mdmId":"HCP1156675","veevaId":"HCP_EU1_0015800000YMVlGAAX","status":"Active","firstName":"Lopez-Gonzalez Garrido","lastName":"Carlos Consulta","recordType":"Organization_vod","addresses":[{"primary":"true","addressLine1":"Teniente Arrabal, 9","addressLine2":"Edificio Anteo 3.1Âº A","addressLine3":"","city":"Ceuta","country":""}],"primaryParentIdentifier":"TBC"}]');
        
        // Set the fake response for the continuation     
        Test.setContinuationResponse(controller.requestLabel, response);
        // Invoke callback method
        Object result = Test.invokeContinuationMethod(controller, conti);
        // result is the return value of the callback
        
        
        
        test.startTest();
        controller.setAccountDetailsInApex();
        List<SelectOption> options = controller.getAcountsForRecordType();
        test.stopTest();
        
        system.assertEquals(options.get(0).getValue(), 'All');
        System.assertEquals(null, result);	    
        
    }
    
    @isTest
    public static  void testWebServiceFailure() {
        
        Account a = new Account(LastName='Lopez-Gonzalez Garrido, Carlos Consulta',FirstName='HCO90806');
        ApexPages.StandardController testSetController = new ApexPages.StandardController(a);
        CORE_GSK_PD_searchAccountsController controller = new CORE_GSK_PD_searchAccountsController(testSetController);
        
        CORE_GSK_PD_searchAccountsController.searchTextName = 'testt';   
        CORE_GSK_PD_searchAccountsController.searchTextLocation =  'testt';
        controller.currentAccountId = '';    
        controller.currentAccountName = '';
        // Invoke the continuation by calling the action method
        Continuation conti = (Continuation)controller.runAccountSync();
        
        // Verify that the continuation has the proper requests
        Map<String, HttpRequest> requests = conti.getRequests();
        
        system.assert(requests.size() == 1);
        system.assert(requests.get(controller.requestLabel) != null);
        
        // Perform mock callout 
        // (i.e. skip the callout and call the callback method)
        HttpResponse response = new HttpResponse();
        response.setStatusCode(500);
        response.setBody('[{"mdmId":"HCP1156675","veevaId":"HCP_EU1_0015800000YMVlGAAX","status":"Active","firstName":"Lopez-Gonzalez Garrido","lastName":"Carlos Consulta","recordType":"Organization_vod","addresses":[{"primary":"true","addressLine1":"Teniente Arrabal, 9","addressLine2":"Edificio Anteo 3.1Âº A","addressLine3":"","city":"Ceuta","country":""}],"primaryParentIdentifier":"TBC"}]');
        
        // Set the fake response for the continuation     
        Test.setContinuationResponse(controller.requestLabel, response);
        // Invoke callback method
        Object result = Test.invokeContinuationMethod(controller, conti);
        // result is the return value of the callback
        
        
        
        test.startTest();
        controller.setAccountDetailsInApex();
        List<SelectOption> options = controller.getAcountsForRecordType();
        test.stopTest();
        
        system.assertEquals(String.valueOf(ApexPages.getMessages()[0].getDetail()),'No accounts returned. Please narrow down search criteria');
		//system.assertEquals(String.valueOf(ApexPages.getMessages()[1]),'No accounts returned. Please narrow down search criteria');           
    
    }
    
    @isTest
    public static  void testRedirect() {  
        Account acc = new Account(FirstName='Pawel',LastName='Franco');
        insert acc;
        
        pageReference pager = new PageReference('/'+acc.id);
        Test.setCurrentPage(pager);
        
        test.startTest();
        ApexPages.StandardController testSetController = new ApexPages.StandardController(acc);
        CORE_GSK_PD_searchAccountsController controller = new CORE_GSK_PD_searchAccountsController(testSetController);
        controller.currentAccountId = acc.id;
        PageReference result = controller.redirect();
        
        test.stopTest();
        System.assertEquals(pager.getUrl(),result.getUrl());
        
    }
    
    
    @isTest(SeeAllData=true)    // DML Operation are not allowed on userTerritory object
    public static void testTerritory(){
        
        List<UserTerritory> utList = [select Id, UserId, TerritoryId from UserTerritory where UserId = :Userinfo.getUserId()];
        String territoryNames ='';
        List<Id> territoryIds = new List<Id>();
        
        for(UserTerritory utl : utList){
            territoryIds.add(utl.TerritoryId);
        }
        List<Territory> terList = [SELECT Name FROM Territory WHERE Id IN: territoryIds];
        
        test.startTest();
        ApexPages.StandardController testSetController = new ApexPages.StandardController(utList[0]);
        CORE_GSK_PD_searchAccountsController controller = new CORE_GSK_PD_searchAccountsController(testSetController);
        controller.currentAccountName = 'Lopez-Gonzalez Garrido, Carlos Consulta';
        controller.currentAccountId = '0015800000YMVlGAAX'; 
        controller.getTerritory();   
        controller.getDetails();
        controller.setAccountDetailsInApex();
        test.stopTest();      
    }
    
}