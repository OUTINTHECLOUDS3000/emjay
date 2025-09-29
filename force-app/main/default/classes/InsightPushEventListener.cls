//emjayib--emjaydev.sandbox.my.salesforce-sites.com/services/apexrest/api/webhooks/Insight/listner
@RestResource(urlMapping='/api/webhooks/Insight/listner')
global class InsightPushEventListener {
    @HttpPost
    global static void Listner() {
        
            RestRequest request = RestContext.request ;
            RestResponse response = RestContext.response ;
            system.debug('event received' + request.requestBody.toString());
             // Check if trigger is active using Custom Metadata
            Integration_Settings__mdt triggerSetting = Integration_Settings__mdt.getInstance('Insight_Integeration');
            
            // Only proceed if trigger is explicitly activated via custom metadata
            if (triggerSetting != null && triggerSetting.isActive__c) {
        
            InsightPushEventProcessor.processEvent(request.requestBody.toString(), RestContext.request);
            response.statusCode = 200 ;
            response.responseBody  = Blob.valueof('success') ;
                
    }
        else {
        System.debug('InsightPushEventListener listner bypassed - either no metadata record found or isActive__c is false');
        return;
    }
    }
}