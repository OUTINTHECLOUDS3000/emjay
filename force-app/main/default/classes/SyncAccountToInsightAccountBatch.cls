public class SyncAccountToInsightAccountBatch implements Database.Batchable<sObject>,  Database.AllowsCallouts, Database.Stateful {

    private Set<Id> recordSet;
    public Set<Id> recordsToUpdate = new Set<Id>();
    boolean latestVersionRequired;
    public SyncAccountToInsightAccountBatch(Set<Id> RecordIds, boolean isLatestVersion) {
        this.recordSet = RecordIds;
        latestVersionRequired  = !isLatestVersion;
    }

    public Database.QueryLocator start(Database.BatchableContext bc) {
      
        // Create a query to fetch only the records needed (replace `Account` with the actual object if needed)
        return Database.getQueryLocator([
            SELECT Id, Insight_Id__c FROM Account WHERE Id IN :recordSet
        ]);
    }

    public void execute(Database.BatchableContext bc, List<sObject> scope) {
        for (SObject record : scope) {
            Id recordId = record.Id;
            // Call the api and pass the id of the record to be fetched and the api to be used
            if (record.get('Insight_Id__c') == null) { 
                InsightAPIController.ExecuteInsightAPI('Create_Client', recordId);
            } else {
                // If the record was updated first time then get the latest record from the Insight using GET Callout
                if(latestVersionRequired){ // this flag will be true, if executed from Trigger Context.
                    recordsToUpdate.add(recordId); // Store the Ids to call the batch again for UPDATE callout in the finish method
                    InsightAPIController.ExecuteInsightAPI('Get_Client', recordId);
            }
            else{
                InsightAPIController.ExecuteInsightAPI('Update_Client', recordId);
            }
        }
    }
}

    public void finish(Database.BatchableContext bc) {
        // Final logging or cleanup if necessary
        System.debug('SyncAccountToInsightAccountBatch processing completed.');
        if(!recordsToUpdate.isEmpty()){
            // Again calling the same with set of record IDs that has updated, but this time passing the Flag as true, because GET request already made.
            Database.executeBatch(new SyncAccountToInsightAccountBatch(recordsToUpdate,true));
        }
    }
}