public without sharing class InsightPushEventProcessor {
        static LoggerUtility logger;
        public static void processEvent(string jsonInput, RestRequest request)
        {logger = LoggerUtility.getLogger();
            String serviceName;
            try{
            
            Map<String,Object> deserializedPayload = (Map<String, Object>) JSON.deserializeUntyped(jsonInput);
           // Map<string,object> eventData = (Map<String,Object>)deserializedPayload.get('Event');
            serviceName = (string)deserializedPayload.get('EventCode');
            logger.addAPILogWithPayload('Insight Push - '+serviceName,jsonInput);
              // Check EventCode and call the respective handler class
              if (serviceName.endsWith('PolicyTransaction')) {
                System.debug('Processing CreatePolicyTransaction...');
                PolicyTransactionHandler.handle(jsonInput);
            }
            if (serviceName.endsWith('Claim')) {
                System.debug('Processing CreatePolicyTransaction...');
                PolicyClaimHandler.handle(jsonInput);
            } else {
                System.debug('No handler found for EventCode: ' + serviceName);
            }
           
        } catch(Exception ex)
        {
            logger.addErrorLog(ex,'Insight Push - '+serviceName, jsonInput);
        }
        finally
        {
           
            logger.saveLogs();}
        
        
        }
}