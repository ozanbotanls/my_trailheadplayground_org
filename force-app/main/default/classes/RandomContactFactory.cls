public class RandomContactFactory {

    public static List<Contact> generateRandomContacts(Integer numberOfContact, String lastName) {      
        List<Contact> cntList = new List<Contact>();
        for (Integer i = 0; i < numberOfContact; i++) {
            Contact newCnt = new Contact(
            	FirstName = 'testCnt' + i,
                LastName = lastName
            );
            cntList.add(newCnt);
        }
        return cntList;
    }
}