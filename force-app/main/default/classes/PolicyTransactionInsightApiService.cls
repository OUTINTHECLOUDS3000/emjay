public class PolicyTransactionInsightApiService extends InsightApiServiceBase  implements IApiInsightService{

        string serviceName;
        string transactionId;
        public PolicyTransactionInsightApiService(String apiName,  string recordId) { 
            super(apiName); 
            serviceName = apiName;
            transactionId = recordId;
        } 
       
        public string invokeAPI()
        {
            string returnStatus;
            setRequestBody();
            HttpResponse response =  performCallout(); 
            system.debug(response.getBody());
            if(response.getStatusCode()  == 200)
        {
            //parseResponse(response.getBody());
            returnStatus = response.getBody();
        }
        else{
            returnStatus = 'Failed';
        }
            return returnStatus;
        }
        
        private void setRequestBody()
        { 
            string requestBody;
            requestBody= generatePayload();
            system.debug('requestBdy'+ requestBody);
            setBody(requestBody);
        }
        
        private void setCustomHeaders()
        {
            Map<String, String> headers = new Map<String, String>();
            setHeaders(headers);
        }
        
        private string generatePayload()
        {
            string payload;
            if(serviceName.toLowerCase() == 'get_policytransaction')
            {
                payload =  getTransactionPayload();
            }
            return payload;
        }
    
        private string getTransactionPayload()
        {
            Map<String,String> payload = new Map<String,String>();
            payload.put('Id',transactionId);
            return JSON.serialize(payload);
        }
}