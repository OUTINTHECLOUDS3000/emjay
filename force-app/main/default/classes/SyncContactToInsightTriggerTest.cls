@IsTest
public class SyncContactToInsightTriggerTest implements HttpCalloutMock {

    public HttpResponse respond(HttpRequest request) {
        // Create a mock response
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setStatusCode(200);
        String jsonContactData = '{'
        + '"Contact": {'
        + '"Id": "123456",'
        + '"CreatedWho": "John Doe",'
        + '"RowVersion": "634345",'
        + '"CreatedWhen": "2023-11-2"'
        + '}}';
        response.setBody(jsonContactData);
        return response;
    }

    @testSetup
    static void setupTestData() {
        // Create test data
        Account testAccount = new Account(Name = 'Test Account',Insight_Id__c='12312');
        insert testAccount;
        
        Contact testContact = new Contact(FirstName = 'Test', LastName = 'Contact', AccountId = testAccount.Id, Email = 'test@example.com');
        insert testContact;
    }
    
    @IsTest
    static void testSyncContactToInsightTrigger() {
        // Get the test contact

        // Set the mock response
        Test.setMock(HttpCalloutMock.class, new SyncContactToInsightTriggerTest());
        Contact testContact = [SELECT Id, FirstName, LastName, Email FROM Contact WHERE FirstName = 'Test' AND LastName = 'Contact'];
        
        // Update the contact's email address   
        testContact.Email = 'test@newemail.com';
       // update testContact;
         // Start the test
         Test.startTest();
       // Execute the batch job
       Database.executeBatch(new SyncContactToInsightBatch(new Set<Id>{testContact.Id},true));
        // Stop the test
        Test.stopTest();
    }
     @IsTest
    static void testSyncContactToInsightTriggerUpdate() {
        // Get the test contact

        // Set the mock response
        Test.setMock(HttpCalloutMock.class, new SyncContactToInsightTriggerTest());
        Contact testContact = [SELECT Id, FirstName, LastName, Email FROM Contact WHERE FirstName = 'Test' AND LastName = 'Contact'];
        
        // Update the contact's email address   
        testContact.Insight_Id__c = '3254235234';
        update testContact;
         // Start the test
         Test.startTest();
       // Execute the batch job
       Database.executeBatch(new SyncContactToInsightBatch(new Set<Id>{testContact.Id},false));
        // Stop the test
        Test.stopTest();
    }

    @IsTest static void testParse() {
        String json = '{'+
        ' \"Contact\": {'+
        '     \"Id\": 0,'+
        '     \"ParentId\": 7394,'+
        '     \"IsPrimary\": true,'+
        '     \"ContactTypeId\": 1,'+
        '     \"Addressee\": \"Open\"'+
        ' }'+
        '}';
        InsightContactRequestWrapper obj = InsightContactRequestWrapper.parse(json);
        System.assert(obj!= null);
    }
    
     @IsTest
    static void syncContactFromInsightTest()  {
        // Get the test contact

        // Set the mock response
        Test.setMock(HttpCalloutMock.class, new SyncContactToInsightTriggerTest());
        Contact testContact = [SELECT Id, FirstName, LastName, Email FROM Contact WHERE FirstName = 'Test' AND LastName = 'Contact'];
        
        // Update the contact's email address   
        testContact.Insight_Id__c = '3254235234';
        update testContact;
         // Start the test
         Test.startTest();
     
       ContactInsightApiService.syncContactFromInsight(new List<Id>{testContact.Id});
        // Stop the test
        Test.stopTest();

    }
}