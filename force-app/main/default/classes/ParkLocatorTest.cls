@isTest
private class ParkLocatorTest{
    @isTest static void testCallout() {              
        // This causes a fake response to be generated
        Test.setMock(WebServiceMock.class, new ParkServiceMock());
        // Call the method that invokes a callout
        string ct = 'Germany';
		List<String> test = new String[]{'Germany'};
        List<String> result = ParkLocator.country(ct);
        // Verify that a fake result is returned
        System.assertEquals(test, result); 
    }
}