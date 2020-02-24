@RestResource(urlMapping='/Accounts/*/contacts')
global with sharing class AccountManager {

  	@HttpGet
	global static Account getAccount() {
        RestRequest request = RestContext.request;
        // grab the accId from the end of the URL
        String accId = request.requestURI.substringBetween('Accounts/','/contacts');
        Account acc = [SELECT Id, Name, (SELECT Id, Name FROM Contacts) FROM Account WHERE Id =: accId];
        return acc;
    }
}