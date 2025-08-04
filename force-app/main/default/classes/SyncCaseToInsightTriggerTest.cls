@IsTest
public class SyncCaseToInsightTriggerTest implements HttpCalloutMock {

    public HttpResponse respond(HttpRequest request) {
        // Create a mock response
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setStatusCode(200);
        String jsonClaimData = '{'
        + '"Claim": {'
        + '"Id": "123456",'
        + '"CreatedWho": "John Doe",'
        + '"PolicyTransactionId": "634345",'
        + '"ParentId": "12321",'
        + '"IsOpen": true,'
        + '"StatusId": "13",'
        + '"Description": "Claim for vehicle damage",'
        + '"ClientId": "4522",'
        + '"InsurerId": "64"'
        + '}}';
        response.setBody(jsonClaimData);
        return response;
    }

    @testSetup
    static void setupTestData() {
       
        // Create test data
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;
        
        Contact testContact = new Contact(FirstName = 'Test', LastName = 'Contact', AccountId = testAccount.Id, Email = 'test@example.com');
        insert testContact;
        
        // Link the Policies record with the case
        InsurancePolicy testPolicy = new InsurancePolicy(NameInsuredId=testAccount.Id, Name = '23232',Insight_Id__c = '12121');
        insert testPolicy;

        Case testCase = new Case(Subject = 'Test Case', Status = 'New', Origin = 'Email', AccountId = testAccount.Id, ContactId = testContact.Id ,  InsurancePolicy__c=testPolicy.Id);
        insert testCase;
       
    }
    
    @IsTest
    static void testSyncCaseToInsightTrigger() {
        // Get the test case
          // Set the mock response
         Test.setMock(HttpCalloutMock.class, new SyncCaseToInsightTriggerTest());
        Case testCase = [SELECT Id, Status FROM Case WHERE Subject = 'Test Case'];
        
        // Update the case status to 'Advised to Insurer'
        testCase.Status = 'Advised to Insurer';
        update testCase;
         // Start the test
         Test.startTest();
        
         // Execute the batch job
         Database.executeBatch(new SyncCaseToInsightBatch(new Set<Id>{testCase.Id}));
         
         // Stop the test
         Test.stopTest();
    }

    @IsTest static void testParse() {
        String json = '{'+
        ' \"Claim\": {'+
        '     \"Id\": 0,'+
        '     \"ParentId\": 7394,'+
        '     \"IsOpen\": true,'+
        '     \"StatusId\": 1,'+
        '     \"StatusName\": \"Open\",'+
        '     \"LossDate\": \"2017-08-23\",'+
        '     \"ReportedDate\": \"2017-06-13\",'+
        '     \"InsurerClaimsRef\": \"MVCLM1234\",'+
        '     \"Excess\": 1000,'+
        '     \"EstimateOfLossAmount\": 200000,'+
        '     \"PaidAmount\": 0,'+
        '     \"SubjectOfLoss\": \"\",'+
        '     \"ResultOfLoss\": \"\"'+
        ' }'+
        '}';
        InsightCaseRequestWrapper obj = InsightCaseRequestWrapper.parse(json);
        System.assert(obj!= null);
    }
}