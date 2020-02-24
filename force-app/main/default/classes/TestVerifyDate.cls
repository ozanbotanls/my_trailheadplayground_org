@isTest
public class TestVerifyDate {

    @isTest static void testDate() {
        Date date1 = System.today();
        Date date2 = date1.addMonths(1);
        Date resultDate = VerifyDate.CheckDates(date1, date2);
        Date resultDate2 = VerifyDate.CheckDates(date1, date2.addDays(10));
    }
}