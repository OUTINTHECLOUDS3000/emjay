trigger SyncCaseToInsight on Case (after insert, after update) {
     // Check if trigger is active using Custom Metadata
    Integration_Settings__mdt triggerSetting = Integration_Settings__mdt.getInstance('Case');
    
    // Only proceed if trigger is explicitly activated via custom metadata
    if (triggerSetting != null && triggerSetting.isActive__c) {
    
        // Do not run the logic again, if trigger is run from the batch class
        Set<Id> caseLstToSync = new Set<Id>();
        if(!System.IsBatch())
        {
          for(Case ca : Trigger.new)
          {
              if(Trigger.isInsert || (Trigger.isUpdate && (Trigger.oldMap.get(ca.Id).Status != ca.Status) && ca.status =='Advised to Insurer'))
              {
                caseLstToSync.add(ca.Id);
              }
             
          }
        }
        if(!caseLstToSync.isEmpty())
        {
            SyncCaseToInsightBatch batch = new SyncCaseToInsightBatch(caseLstToSync);
            Database.executeBatch(batch, 1);
        }
    } else {
        System.debug('SyncCaseToInsight trigger bypassed - either no metadata record found or isActive__c is false');
        return;
    }
    }