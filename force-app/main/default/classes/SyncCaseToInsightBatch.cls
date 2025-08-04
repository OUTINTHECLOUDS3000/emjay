public with sharing class SyncCaseToInsightBatch implements Database.Batchable<sObject>,  Database.AllowsCallouts {
    private Set<Id> recordSet;
    public SyncCaseToInsightBatch(Set<Id> RecordIds) {
        this.recordSet = RecordIds;
    }
        public Database.QueryLocator start(Database.BatchableContext bc) {
          
            // Create a query to fetch only the records needed 
            return Database.getQueryLocator([
                SELECT Id, AccountId,Claim_Insight_Id__c FROM Case WHERE Id IN :recordSet
            ]);
        }
    
        public void execute(Database.BatchableContext bc, List<sObject> scope) {
            for (SObject record : scope) {
                Id recordId = record.Id;
                // Call the api and pass the id of the record to be fetched and the api to be used
                if (record.get('Claim_Insight_Id__c') == null) { 
                    InsightAPIController.ExecuteInsightAPI('Create_Claim', recordId);
                } 
                /*else {
                    // If the record was already processed the batch will skip it to avoid exceptions
                    InsightAPIController.ExecuteInsightAPI('Update_Contact', recordId);
                }*/
            }
        }
    
        public void finish(Database.BatchableContext bc) {
            // Final logging or cleanup if necessary
            System.debug('SyncCaseToInsightBatch processing completed.');
        }
}