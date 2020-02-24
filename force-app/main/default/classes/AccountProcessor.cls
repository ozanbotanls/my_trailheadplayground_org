public class AccountProcessor {

    @future
    public static void countContacts(List<Id> accIds) {
        
        for (List<Account> accList : [SELECT Number_of_Contacts__c, (SELECT Id FROM Contacts) FROM Account WHERE ID IN : accIds]) {
            for (Account acc : accList) {
                acc.Number_of_Contacts__c = acc.Contacts.size();
            }
            update accList;
        }
    }
}