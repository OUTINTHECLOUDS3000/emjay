public class SyncAccountToInsightFlowService {
   
    @InvocableMethod(label='Sync Account To Insight' description='Performs a callout to an external system' callout=true)
    public static void syncAccountToInsight(List<Id> recordIds) {
        string accountId = recordIds[0];
        List<Account> accList = [Select Id,Insight_Id__c FROM Account where Id=:accountId];
       if(accList!=null && accList.Size()>0)
       {
           Account acc = accList[0];
            // Call the api and pass the id of the record to be fetched and the api to be used
            if (acc.Insight_Id__c == null) { 
                InsightAPIController.ExecuteInsightAPI('Create_Client', acc.Id);
            } else{
                InsightAPIController.ExecuteInsightAPI('Update_Client', acc.Id);
            }
       }
    }
}