public class FetchInsightReferenceData implements Database.Batchable<Insight_ReferenceData_API_Configuration__mdt>, Database.Stateful , Database.AllowsCallouts{
    
        // To store API responses for processing
        private Map<String, String> apiResponses = new Map<String, String>();
    
        // Query custom metadata
        public Iterable<Insight_ReferenceData_API_Configuration__mdt> start(Database.BatchableContext bc) {
            return (List<Insight_ReferenceData_API_Configuration__mdt>)Database.Query('SELECT DeveloperName,Endpoint__c FROM Insight_ReferenceData_API_Configuration__mdt');
        }
    
        // Execute for each batch of custom metadata
        public void execute(Database.BatchableContext bc, List<Insight_ReferenceData_API_Configuration__mdt> scope) {
            for (Insight_ReferenceData_API_Configuration__mdt config : scope) {
                if (String.isNotBlank(config.Endpoint__c)) {
                    try {
                        // Callout to the API
                        HttpRequest request = new HttpRequest();
                        request.setEndpoint('callout:Insight_API_Credentials'+config.Endpoint__c); 
                        request.setMethod('POST');
                        request.setHeader('Content-Type', 'application/json');
                        request.setHeader('INSIGHT-USERNAME', '{!$Credential.Username}');
                        request.setHeader('INSIGHT-PASSWORD',  '{!$Credential.Password}');
                       
                        Map<String, Object> requestBody = new Map<String, Object>();
                        requestBody.put('PageNumber', 1);
                        requestBody.put('RowsPerPage', 100);
                        String jsonBody = JSON.serialize(requestBody);
                        request.setBody(jsonBody);
                        Http http = new Http();
                        HttpResponse response = http.send(request);
    
                        // Check if response is successful
                        if (response.getStatusCode() == 200) {
                            system.debug('responseBody'+ response.getBody());
                            apiResponses.put(config.DeveloperName, response.getBody());
                        } else {
                            System.debug('Failed API call for ' + config.DeveloperName + ' with status: ' + response.getStatus());
                        }
                    } catch (Exception e) {
                        System.debug('Error while calling API for ' + config.DeveloperName + ': ' + e.getMessage());
                    }
                }
            }
        }
    
        // Finalize by caching the API response data
        public void finish(Database.BatchableContext bc) {
            InsightReferenceDataCustomMetadataHelper.insertCustomMetadataRecord(apiResponses);
        }
    }