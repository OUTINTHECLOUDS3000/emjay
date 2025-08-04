@IsTest
public class SyncAccountToInsightTest {
    @testSetup
    static void setup() {
        Account ac = new Account(Name = 'Test Account');
        insert ac;
    }
    
    @IsTest
    static void testSyncAccountToInsight() {
        Account ac = [SELECT Id, Name FROM Account WHERE Name = 'Test Account'];
        ac.Name = 'Updated Test Account';
        update ac;
         // Start the test
         Test.startTest();
       // Execute the batch job
       Database.executeBatch(new SyncAccountToInsightAccountBatch(new Set<Id>{ac.Id}));
        // Stop the test
        Test.stopTest();     
        // Add assertions here to verify that the account was synced to Insight
    }
}