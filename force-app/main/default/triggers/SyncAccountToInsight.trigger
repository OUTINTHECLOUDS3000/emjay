trigger SyncAccountToInsight on Account (after insert) {//, after update
    
    // Do not run the logic again, if trigger is run from the batch class
    Set<Id> accountLstToSync = new Set<Id>();
    if(!System.IsBatch())
    {
      for(Account acc : Trigger.new)
      {
          if(Trigger.isInsert || (Trigger.isUpdate && (Trigger.oldMap.get(acc.Id).Insight_Id__c == acc.Insight_Id__c) && (Trigger.oldMap.get(acc.Id).Insight_Row_Version__c == acc.Insight_Row_Version__c)))
          {
            accountLstToSync.add(acc.Id);
          }
      }
    }
    if(!accountLstToSync.isEmpty())
    {
        SyncAccountToInsightAccountBatch batch = new SyncAccountToInsightAccountBatch(accountLstToSync,false);
        Database.executeBatch(batch, 1);
    }
}