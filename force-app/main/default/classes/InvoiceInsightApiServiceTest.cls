@IsTest
public class InvoiceInsightApiServiceTest {
    
    // Mock HTTP callout class
    private class MockHttpResponse implements HttpCalloutMock {
        private Integer statusCode;
        private String body;
        
        public MockHttpResponse(Integer statusCode, String body) {
            this.statusCode = statusCode;
            this.body = body;
        }
        
        public HttpResponse respond(HttpRequest request) {
            HttpResponse response = new HttpResponse();
            response.setStatusCode(statusCode);
            response.setBody(body);
            return response;
        }
    }
    
    @IsTest
    static void testInvokeAPI_Success() {
        // Set up mock response
        String mockResponseBody = '{"Invoice": {"Id": "INV123456_6735_1", "InvoiceNumber": 123456, "TransactionItemAmount": 1204.96}}';
        Test.setMock(HttpCalloutMock.class, new MockHttpResponse(200, mockResponseBody));
        
        // Create service instance
        InvoiceInsightApiService service = new InvoiceInsightApiService('Get_Invoice', 'INV123456_6735_1');
        
        // Execute method to test
        Test.startTest();
        String result = service.invokeAPI();
        Test.stopTest();
        
        // Verify results
        System.assertNotEquals('Failed', result);
        System.assertEquals(mockResponseBody, result);
    }
    
    @IsTest
    static void testInvokeAPI_Failure() {
        // Set up mock response for failure
        Test.setMock(HttpCalloutMock.class, new MockHttpResponse(400, 'Error occurred'));
        
        // Create service instance
        InvoiceInsightApiService service = new InvoiceInsightApiService('Get_Invoice', 'INV123456_6735_1');
        
        // Execute method to test
        Test.startTest();
        String result = service.invokeAPI();
        Test.stopTest();
        
        // Verify results
        System.assertEquals('Failed', result);
    }
    
    
}