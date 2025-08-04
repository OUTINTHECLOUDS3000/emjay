//emjayib--emjaydev.sandbox.my.salesforce-sites.com/services/apexrest/api/webhooks/Insight/listner
@RestResource(urlMapping='/api/webhooks/Insight/listner')
global class InsightPushEventListener {
    @HttpPost
    global static void Listner() {
        
            RestRequest request = RestContext.request ;
            RestResponse response = RestContext.response ;
            system.debug('event received' + request.requestBody.toString());
            InsightPushEventProcessor.processEvent(request.requestBody.toString(), RestContext.request);
            response.statusCode = 200 ;
            response.responseBody  = Blob.valueof('success') ;
    }
}