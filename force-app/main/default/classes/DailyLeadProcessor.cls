public class DailyLeadProcessor implements Schedulable {

    public void execute(System.SchedulableContext ctx) {
        for(List<Lead> leadList : [SELECT Id, LeadSource FROM Lead WHERE LeadSource = null LIMIT 200]) {
            for(Lead lead : leadList) {
                lead.LeadSource = 'Dreamforce';
            }
            update leadList;
        }
    }
}