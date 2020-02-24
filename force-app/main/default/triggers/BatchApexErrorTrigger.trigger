trigger BatchApexErrorTrigger on BatchApexErrorEvent (after insert) {

    List<BatchLeadConvertErrors__c> batchEventList = new List<BatchLeadConvertErrors__c>();
    for (BatchApexErrorEvent batchEvent : Trigger.new) {
        BatchLeadConvertErrors__c batchErr = new BatchLeadConvertErrors__c(
            AsyncApexJobId__c = batchEvent.AsyncApexJobId,
            Records__c = batchEvent.JobScope,
            StackTrace__c = batchEvent.StackTrace
        );
        batchEventList.add(batchErr);
    }
    if (!batchEventList.isEmpty()) {
        insert batchEventList;
    }
}