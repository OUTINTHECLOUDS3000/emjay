public class InvoiceInsightApiService extends InsightApiServiceBase  implements IApiInsightService{
    
    string serviceName;
    string invoiceId;
    public InvoiceInsightApiService(String apiName,  string recordId) { 
        super(apiName); 
        serviceName = apiName;
        invoiceId = recordId;
    } 
    
    public string invokeAPI()
    {
        string returnStatus;
        setRequestBody();
        HttpResponse response =  performCallout(); 
        if(response != null)
        {
            if(response.getStatusCode()  == 200)
            {
                //parseResponse(response.getBody());
                returnStatus = response.getBody();
            }
            else{
                returnStatus = 'Failed';
            }
        }
        return returnStatus;
    }
    
    private void setRequestBody()
    { 
        string requestBody;
        requestBody= generatePayload();
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
        if(serviceName.toLowerCase() == 'get_invoice')
        {
            payload =  getInvoicePayload();
        }
        return payload;
    }
    
    private string getInvoicePayload()
    {
        Map<String,String> payload = new Map<String,String>();
        payload.put('TranId',invoiceId.split('_')[0]);
        payload.put('Id',invoiceId);
        return JSON.serialize(payload);
    }
}