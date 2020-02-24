@IsTest
public class AnimalLocatorTest {

    @isTest static void testPostCallout() {
        Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock()); 
        String animalName = AnimalLocator.getAnimalNameById(1);
        System.assertEquals('chicken', animalName);
	}
}