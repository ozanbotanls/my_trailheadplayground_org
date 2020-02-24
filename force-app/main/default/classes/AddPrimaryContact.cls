public class AddPrimaryContact implements Queueable {

    Contact cnt;
    String stateAbv;
    public AddPrimaryContact(Contact cnt, String stateAbv) {
        this.cnt = cnt;
        this.stateAbv = stateAbv;
    }
    
    public void execute(System.QueueableContext cntx) {
        List<Account> accList = [SELECT Id FROM Account WHERE BillingState =: stateAbv];
        List<Contact> contactsToInsert = new List<Contact>();
        for (Account acc : accList) {
            Contact cntNew = cnt.clone(false, false, false, false);
            cntNew.AccountId = acc.Id;
            cntNew.LastName += ' ' + acc.Id;
            contactsToInsert.add(cntNew);
        }
        insert contactsToInsert;
    }
}