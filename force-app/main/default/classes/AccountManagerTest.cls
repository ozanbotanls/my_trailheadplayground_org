@isTest 
private class AccountManagerTest {
    static testMethod void testRestService() {
        Account objAccount = new Account(Name = 'REST Apex Test Account');
        insert objAccount;
        Contact objContact = new Contact(LastName = 'REST Apex Test Contact', AccountId = objAccount.Id);
        insert objContact;
        Id recordId = objAccount.Id;
        RestRequest request = new RestRequest();
        request.requestUri =
            'https://resourceful-fox-jx90ak-dev-ed.my.salesforce.com//services/apexrest/Accounts/'
            + recordId +'/contacts';
        request.httpMethod = 'GET';
        RestContext.request = request;
        Account thisAccount = AccountManager.getAccount();
        // Verify results
        System.assert(thisAccount != null);
        System.assertEquals('REST Apex Test Account', thisAccount.Name);
        System.assertEquals('REST Apex Test Contact', thisAccount.Contacts[0].Name);
    }
}