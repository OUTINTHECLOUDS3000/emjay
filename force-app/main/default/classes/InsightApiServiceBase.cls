public abstract class InsightApiServiceBase {   
    private String serviceApiName;
    HttpRequest req;
    Insight_API_Configuration__mdt config;
    LoggerUtility logger;
    
    public InsightApiServiceBase(String apiName) {
        logger = LoggerUtility.getLogger();
        serviceApiName = apiName;
        IntializeConfiguration();
    } 
    
    public HttpResponse performCallout() {
        req.setEndpoint('callout:Insight_API_Credentials'+config.Endpoint__c); 
        req.setMethod(config.HTTP_Method__c);
        Http http = new Http();
        HttpResponse response ;
        try {
            response =  http.send(req);
            logger.addAPILog(serviceApiName,req,false,response);
        } catch (Exception e) {
            logger.addAPILog(serviceApiName,req,true,e.getMessage());
            //throw new CalloutException('Callout failed: ' + e.getMessage());
        }
        return response;
    }
    
    private void IntializeConfiguration()
    {
        req = new HttpRequest();
        Map<String, String> authHeaders = new Map<String, String>();
        authHeaders.put('Content-Type', 'application/json');
        authHeaders.put('INSIGHT-USERNAME', '{!$Credential.Username}');
        authHeaders.put('INSIGHT-PASSWORD', '{!$Credential.Password}');
        setHeaders(authHeaders);
        config = [SELECT Endpoint__c, HTTP_Method__c
                  FROM Insight_API_Configuration__mdt
                  WHERE DeveloperName = :serviceApiName
                  LIMIT 1];
    }
    
    // Set Headers
    protected void setHeaders(Map<String, String> headers) {
        for (String key : headers.keySet()) {
            system.debug(headers.get(key));
            req.setHeader(key, headers.get(key));
        }
    }
    
    // Set Body
    protected void setBody(string requestData) {
        if (requestData != null) {
            req.setBody(requestData);
        }
    }
}