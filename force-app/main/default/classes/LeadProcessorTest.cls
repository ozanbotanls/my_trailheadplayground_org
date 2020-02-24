@isTest
public class LeadProcessorTest {
    @testSetup 
    static void setup() {
        List<Lead> leadList = new List<Lead>();
        for (Integer i = 0; i < 200; i++) {
            leadList.add(new Lead(
            	FirstName = 'test ' + i,
                LastName = 'test ' + i,
                Company = 'Lightspeed HQ'
            ));
        }
        insert leadList;
    }
    
    @isTest 
    static void testLeadProcessor() {
        Test.startTest();
        LeadProcessor leadProc = new LeadProcessor();
        Id batchId = Database.executeBatch(leadProc);
        Test.stopTest();
        for (Lead lead : [SELECT ID, Name, LeadSource FROM Lead]) {
        	System.assertEquals('Dreamforce', lead.LeadSource);
        }
    }

}