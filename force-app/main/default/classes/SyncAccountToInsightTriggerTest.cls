@IsTest
public class SyncAccountToInsightTriggerTest implements HttpCalloutMock {

    public HttpResponse respond(HttpRequest request) {
        // Create a mock response
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setStatusCode(200);
        String json = '{'+
        ' \"Client\": {'+
        '     \"Id\": 0,'+
        '     \"AuditId\": 7394,'+
        '     \"IsCurrent\": true,'+
        '     \"CurrentStatusId\": 1,'+
        '     \"Addressee\": \"Open\",'+
        '     \"IndustryId\": 18'+
        ' }'+
        '}';
        response.setBody(json);
        return response;
    }
    
    @testSetup
    static void setup() {
        Account ac = new Account(Name = 'Test Account');
        insert ac;
    }
    
    @IsTest
    static void testSyncAccountToInsight()  {
         // Set the mock response
         Test.setMock(HttpCalloutMock.class, new SyncAccountToInsightTriggerTest());
        Account ac = [SELECT Id, Name FROM Account WHERE Name = 'Test Account'];
        ac.Name = 'Updated Test Account';
       
        update ac;
         // Start the test
         Test.startTest();
       // Execute the batch job
       Database.executeBatch(new SyncAccountToInsightAccountBatch(new Set<Id>{ac.Id},true));
        // Stop the test
        Test.stopTest();     
        // Add assertions here to verify that the account was synced to Insight
    }
    
     @IsTest
    static void testSyncAccountToInsightUpdate()  {
         // Set the mock response
         Test.setMock(HttpCalloutMock.class, new SyncAccountToInsightTriggerTest());
        Account ac = [SELECT Id, Name FROM Account WHERE Name = 'Test Account'];
        ac.Name = 'Updated Test Account';
        ac.Insight_Id__c = '122312';
        update ac;
         // Start the test
         Test.startTest();
       // Execute the batch job
       Database.executeBatch(new SyncAccountToInsightAccountBatch(new Set<Id>{ac.Id},false));
        // Stop the test
        Test.stopTest();     
        // Add assertions here to verify that the account was synced to Insight
    }
    @IsTest static void testParse() {
        String json = '{'+
        ' \"Client\": {'+
        '     \"Id\": 0,'+
        '     \"AuditId\": 7394,'+
        '     \"IsCurrent\": true,'+
        '     \"CurrentStatusId\": 1,'+
        '     \"Addressee\": \"Open\"'+
        ' }'+
        '}';
        InsightClientRequestWrapper obj = InsightClientRequestWrapper.parse(json);
        System.assert(obj!= null);
    }
      @IsTest
    static void syncAccountFromInsightTest()  {
         // Set the mock response
         Test.setMock(HttpCalloutMock.class, new SyncAccountToInsightTriggerTest());
        Account ac = [SELECT Id, Name FROM Account WHERE Name = 'Test Account'];
        ac.Name = 'Updated Test Account';
        ac.Insight_Id__c = '122312';
        update ac;
         // Start the test
         Test.startTest();
       // Execute the batch job
        ClientInsightApiService.syncAccountFromInsight(new List<Id>{ac.Id});
        // Stop the test
        Test.stopTest();     
        // Add assertions here to verify that the account was synced to Insight
    }
    
}