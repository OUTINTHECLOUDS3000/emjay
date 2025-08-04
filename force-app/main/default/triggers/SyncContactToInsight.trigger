trigger SyncContactToInsight on Contact (after insert) {//, after update
    
    // Do not run the logic again, if trigger is run from the batch class
    Set<Id> contactLstToSync = new Set<Id>();
    if(!System.IsBatch())
    {
      for(Contact con : Trigger.new)
      {
          if(Trigger.isInsert || (Trigger.isUpdate && (Trigger.oldMap.get(con.Id).Insight_Id__c == con.Insight_Id__c)))
          {
            contactLstToSync.add(con.Id);
          }
      }
    }
    if(!contactLstToSync.isEmpty())
    {
        SyncContactToInsightBatch batch = new SyncContactToInsightBatch(contactLstToSync,false);
        Database.executeBatch(batch, 1);
    }
}