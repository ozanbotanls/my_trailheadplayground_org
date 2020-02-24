public class ContactAndLeadSearch {

    public static List<List<sObject>> searchContactsAndLeads(String searchText) {
        
        List<List<sObject>> foundRecords = [FIND :searchText IN NAME FIELDS RETURNING Contact(Name), Lead(Name)];
        return foundRecords;
    }
}