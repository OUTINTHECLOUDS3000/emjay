@IsTest
public class FetchInsightReferenceDataTest {
    
    // Mock HTTP callout class
    public class MockHttpResponseGenerator implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            String jsonString = '{' +
    '"Results": [' +
        '{' +
            '"Id": 101,' +
            '"Name": "Alice"' +
        '},' +
        '{' +
            '"Id": 102,' +
            '"Name": "Bob"' +
        '}' +
    ']' +
'}';
            res.setBody(jsonString);
            res.setStatusCode(200);
            return res;
        }
    }

    @IsTest
    static void testFetchInsightReferenceData() {
        // Set up test data
        Insight_ReferenceData_API_Configuration__mdt config = new Insight_ReferenceData_API_Configuration__mdt(
            DeveloperName = 'TestConfig',
            Endpoint__c = '/testEndpoint'
        );

        // Set up the mock HTTP callout
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());

        // Start the test
        Test.startTest();

        // Execute the batch job
        Database.executeBatch(new FetchInsightReferenceData());

        // Stop the test
        Test.stopTest();

        // Add assertions here to validate the expected behavior
    }
}