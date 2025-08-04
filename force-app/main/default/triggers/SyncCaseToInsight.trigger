trigger SyncCaseToInsight on Case (after insert, after update) {
    
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
    }