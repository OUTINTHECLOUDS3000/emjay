public class CaseInsightApiService extends InsightApiServiceBase  implements IApiInsightService{
    
    string serviceName;
    string caseId;
    case clientcase;
    public caseInsightApiService(String apiName,  string recordId) { 
        super(apiName); 
        serviceName = apiName;
        caseId = recordId;
    } 
    
    public string invokeAPI()
    {
        string returnStatus;
        setRequestBody();
        HttpResponse response =  performCallout(); 
        system.debug(response.getBody());
        if(response.getStatusCode()  == 200)
        {
            parseResponse(response.getBody());
            returnStatus = 'Success';
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
         if(serviceName.toLowerCase() == 'create_claim')
        {
            payload =  createcasePayload();
        }
        
        return payload;
    }
  
    private string createcasePayload()
    {
        InsightCaseRequestWrapper payload =  mapcaseToRequestWrapper();
        return JSON.SERIALIZE(payload,FALSE);
    }
    
   
    private void parseResponse(string resonseBody)
    {
        // Parse JSON
        Map<String, Object> parsedData = (Map<String, Object>) JSON.deserializeUntyped(resonseBody);
        Map<String, Object> claimData = (Map<String, Object>) parsedData.get('Claim');
        
        // Create Claim Record
        Claim newClaim = new Claim(
            Name =  String.ValueOf(claimData.get('Id')),
            Claim_ID__c =  String.ValueOf(claimData.get('Id')),
            LossDate = clientCase.CreatedDate.date(),
            Description__c = String.ValueOf(claimData.get('Description')),
            ClaimReason = String.ValueOf(claimData.get('Description')),
            CreatedWho__c = String.ValueOf(claimData.get('CreatedWho')),
            PolicyTransactionId__c = String.ValueOf(claimData.get('PolicyTransactionId')),
            PolicyNumberId = clientCase.InsurancePolicy__c,
            ParentId__c = String.ValueOf(claimData.get('ParentId')),
            ReportDate = clientCase.CreatedDate.date(),
            IsOpen__c = Boolean.ValueOf(claimData.get('IsOpen')),
            StatusId__c= String.ValueOf(claimData.get('StatusId')),
            ClientId__c= String.ValueOf(claimData.get('ClientId')),
            AccountId = clientCase.AccountId,
            InsurerId__c= String.ValueOf(claimData.get('InsurerId'))
        );
        // Insert into Salesforce
        insert newClaim;
        clientCase.ClaimId__c = newClaim.Id;
        update clientCase;
    }
    
    private InsightCaseRequestWrapper mapcaseToRequestWrapper()
    {
        ReferenceMetadataUtility.setCustomMetadataMap();
        List<case> caseList = [SELECT Id,AccountId,ClaimId__c, InsurancePolicy__c, InsurancePolicy__r.Name,
                               InsurancePolicy__r.Insight_Id__c,CreatedDate,Description
                               FROM case
                               WHERE Id = :caseId];
        InsightCaseRequestWrapper payload = new InsightCaseRequestWrapper();
        InsightCaseRequestWrapper.cls_Claim caseRequest = new InsightCaseRequestWrapper.cls_Claim();
        if(!caseList.isEmpty())
        {
            clientCase = caseList[0];
            caseRequest.Id = 0;
            caseRequest.ParentId = Integer.ValueOf(clientCase.InsurancePolicy__r.Name);
            caseRequest.policyTransactionId = Integer.ValueOf(clientCase.InsurancePolicy__r.Insight_Id__c);
            caseRequest.isOpen = true;
            caseRequest.ReportedDate = String.ValueOf(clientCase.CreatedDate.date());
            caseRequest.LossDate = String.ValueOf(clientCase.CreatedDate.date()); 
            caseRequest.Description = clientCase.Description;
            caseRequest.StatusId = 13;
            payload.Claim = caseRequest;
        }
        
        return payload;
    }
}