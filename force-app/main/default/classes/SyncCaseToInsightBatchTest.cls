@IsTest
public class SyncCaseToInsightBatchTest {
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

        Case testCase = new Case(Subject = 'Test Case', Status = 'New', Origin = 'Email', AccountId = testAccount.Id, ContactId = testContact.Id , InsurancePolicy__c=testPolicy.Id);
        insert testCase;
    }
    
    @IsTest
    static void testSyncCaseToInsightBatch() {
        // Get the test case
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
        
        // Verify that the batch job was executed
        List<AsyncApexJob> batchJobs = [SELECT Id, JobType, ApexClassId, Status FROM AsyncApexJob WHERE JobType = 'BatchApex' AND ApexClass.Name = 'SyncCaseToInsightBatch'];
        System.assertEquals(1, batchJobs.size(), 'SyncCaseToInsightBatch should have been executed');
    }
}