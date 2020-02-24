public class ContactSearch {

    public static List<Contact> searchForContacts(String lastName, String postalCode) {
        List<Contact> foundContacts = new List<Contact>(
            [SELECT Id, Name FROM Contact WHERE LastName =: lastName AND MailingPostalCode =: postalCode]
		);
        return foundContacts;
    }
}