trigger SyncAccountToInsight on Account (after insert) {//, after update
    
    // Check if trigger is active using Custom Metadata
    Integration_Settings__mdt triggerSetting = Integration_Settings__mdt.getInstance('Account');
    
    // Only proceed if trigger is explicitly activated via custom metadata
    if (triggerSetting != null && triggerSetting.isActive__c) {
        
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
        
    } else {
        System.debug('SyncAccountToInsight trigger bypassed - either no metadata record found or isActive__c is false');
        return;
    }
}