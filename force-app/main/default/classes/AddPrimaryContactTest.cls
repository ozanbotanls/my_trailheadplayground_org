@isTest
public class AddPrimaryContactTest {

    @testSetup
    static void setup() {
        List<Account> accsToInsert = new List<Account>();
        for (Integer i = 0; i < 50; i++) {
            accsToInsert.add(new Account (
            	Name = 'ny test ' + i,
                BillingState = 'NY'
            ));
            accsToInsert.add(new Account (
            	Name = 'ca test ' + i,
                BillingState = 'CA'
            ));
        }
        insert accsToInsert;
    }
    
    @isTest
    static void testAddPrimaryContact() {
        Contact cnt = new Contact(LastName = 'testCnt');  	
		AddPrimaryContact contactProcessor = new AddPrimaryContact(cnt, 'CA');
        Test.startTest();
        System.enqueueJob(contactProcessor);
        Test.stopTest();
        System.assertEquals(50, [Select count() from Contact WHERE Account.BillingState = 'CA']);
    }
}