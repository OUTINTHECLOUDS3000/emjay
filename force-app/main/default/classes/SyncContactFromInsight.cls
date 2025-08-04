public class SyncContactFromInsight {
 
  @InvocableMethod(label='Sync Account From Insight' description='Performs a callout to an external system' callout=true)
  public static void syncAccountFromInsight(List<Id> recordIds) {
       string accountId = recordIds[0];
       InsightAPIController.ExecuteInsightAPI('Get_Account', accountId);
  }
}