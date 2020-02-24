public with sharing class AccountHandler {
    public static Account insertNewAccount(String accName) {
        try {
            Account acc = new Account(Name = accName);
            if (acc.getSObjectType().getDescribe().isCreateable()) {
                insert acc;
            }
            return acc;
        } catch (DmlException e) {
            System.debug('A DML exception has occurred: ' + e.getMessage());
            return null;
        }
    }
}