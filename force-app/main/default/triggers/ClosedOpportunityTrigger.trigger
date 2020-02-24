trigger ClosedOpportunityTrigger on Opportunity (after insert, after update) {
    List<Task> taskList = new List<Task>();
    for (Opportunity opp : Trigger.new) {
        if (opp.StageName == 'Closed Won') {
            taskList.add(new Task(
                WhatId = opp.Id,
                Subject = 'Follow Up Test Task'
            ));
        }
    }
    insert taskList;
}