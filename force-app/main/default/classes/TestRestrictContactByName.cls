@isTest
public class TestRestrictContactByName {
	
    @isTest static void testContact() {
        Contact cnt = new Contact (LastName = 'INVALIDNAME');
        insert cnt;
        cnt.Description = 'update desc';
        update cnt;
    }
}