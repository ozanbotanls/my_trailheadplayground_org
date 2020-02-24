@isTest
public class TestOpportunityChangeTrigger {
	@isTest static void testCreateAndUpdateOpportunity () {
        Test.enableChangeDataCapture();
        Database.insertImmediate(new OpportunityChangeEvent(
          	Name = 'Sell 100 Widgets',
			StageName = 'Prospecting',
			CloseDate = Date.today().addMonths(3)
        ));
        Test.getEventBus().deliver();

        Opportunity[] oppRecs = [SELECT StageName FROM Opportunity];
        Opportunity opp = oppRecs[0];
        opp.StageName = 'Closed Won';
        update opp;
        // Call deliver to fire the trigger for the update operation.
        Test.getEventBus().deliver();
        
        // VERIFICATIONS
        // Check that the change event trigger created a task.
        Task[] taskList2 = [SELECT Id, Subject FROM Task];
        System.assertEquals(1, taskList2.size(),
          'The change event trigger did not create the expected task.');
  	}
}