@isTest
public class DailyLeadProcessorTest {

    @testSetup
    static void setup() {
        List<Lead> leadsToInsert = new List<Lead>();
        for (Integer i = 0; i < 200; i++) {
            leadsToInsert.add(new Lead(
            	LastName = 'test ' + i,
                Company = 'test company'
            ));
        }
        insert leadsToInsert;
    }
    
    public static String CRON_EXP = '0 0 0 10 2 ? 2020';
    
    @isTest
    static void testDailyLeadProcessor() {
        Test.startTest();
        String jobId = System.schedule(
            'ScheduledApexTest',
            CRON_EXP, 
            new DailyLeadProcessor()
        );         
        Test.stopTest();
        System.assertEquals(200, [SELECT count() FROM Lead WHERE LeadSource = 'Dreamforce']);
    }
}