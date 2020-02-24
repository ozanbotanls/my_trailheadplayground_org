@isTest
public class AccountProcessorTest {

    @isTest static void testCountContacts() {
        Account acc = new Account (Name = 'test1');
        insert acc;
        Contact cnt = new Contact (LastName = 'test1 contact', AccountId = acc.Id);
        insert cnt;
        Test.startTest();
        AccountProcessor.countContacts(new List<Id> { acc.Id });
        Test.stopTest();
        Account accSelected = [SELECT Number_of_Contacts__c FROM Account WHERE ID =: acc.Id];
        System.assertEquals(1, accSelected.Number_of_Contacts__c);
    }
}