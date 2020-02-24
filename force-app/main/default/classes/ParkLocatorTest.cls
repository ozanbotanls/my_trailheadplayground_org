@isTest
private class ParkLocatorTest {
    @isTest static void testCallout() {              
        Test.setMock(WebServiceMock.class, new ParkServiceMock());
        String[] parkingLots = ParkLocator.country('Germany');
        System.assertEquals(3, parkingLots.size()); 
    }
}