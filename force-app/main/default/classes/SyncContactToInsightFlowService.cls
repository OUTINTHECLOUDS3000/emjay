public class SyncContactToInsightFlowService {

    @InvocableMethod(label='Sync Contact To Insight' description='Performs a callout to an external system' callout=true)
    public static void syncContactToInsight(List<Id> recordIds) {
        string contactId = recordIds[0];
        List<Contact> conList = [Select Id,Insight_Id__c FROM Contact where Id=:contactId];
       if(conList!=null && conList.Size()>0)
       {
           Contact con = conList[0];
            // Call the api and pass the id of the record to be fetched and the api to be used
            if (con.Insight_Id__c == null) { 
                InsightAPIController.ExecuteInsightAPI('Create_Contact', con.Id);
            } else{
                InsightAPIController.ExecuteInsightAPI('Update_Contact', con.Id);
            }
       }
    }
}