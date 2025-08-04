public class ClientInsightApiService extends InsightApiServiceBase  implements IApiInsightService{
    
    string serviceName;
    string accountId;
    Account client;
    public ClientInsightApiService(String apiName,  string recordId) { 
        super(apiName); 
        serviceName = apiName;
        accountId = recordId;
        ReferenceMetadataUtility.setCustomMetadataMap();
    } 
    
    @InvocableMethod(label='Sync Account From Insight' description='Performs a callout to an external system' callout=true)
    public static void syncAccountFromInsight(List<Id> recordIds) {
        string accountId = recordIds[0];
        InsightAPIController.ExecuteInsightAPI('Get_Client', accountId);
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
        if(serviceName.toLowerCase() == 'get_client')
        {
            payload =  getClientPayload();
        }
        else if(serviceName.toLowerCase() == 'create_client')
        {
            payload =  createClientPayload();
        }
        else if(serviceName.toLowerCase() == 'update_client')
        {
            payload =  updateClientPayload();
        }
        return payload;
    }
    
    private string GetClientPayload()
    {
        Map<String,Integer> payload = new Map<String,Integer>();
        List<Account> accountList = [SELECT Id, Insight_Id__c
                                     FROM Account
                                     WHERE Id = :accountId];
        if(!accountList.isEmpty())
        {
            payload.put('Id', Integer.ValueOf(accountList[0].Insight_Id__c));
        }
        return JSON.serialize(payload);
    }
    
    private string createClientPayload()
    {
        InsightClientRequestWrapper payload =  mapAccountToRequestWrapper();
        payload.Client.Id = 0;
        payload.Client.BranchId = 5;
        payload.Client.RecordPermissionsGroupId = 2;
        payload.Client.ProfileId = 0;
        return JSON.SERIALIZE(payload,FALSE);
    }
    
    private string updateClientPayload()
    {
        InsightClientRequestWrapper payload =  mapAccountToRequestWrapper();
        return JSON.SERIALIZE(payload,TRUE);
    }
    
    private void parseResponse(string resonseBody)
    {
        updateRowVersion(resonseBody,accountId); 
    }
    
    private void updateRowVersion(String resonseBody, string accountId)
    {
        
        Map<String, Object> responseMap = (Map<String, Object>) JSON.deserializeUntyped(resonseBody);
        Map<String, Object> clientMap = (Map<String, Object>) responseMap.get('Client');
        string insightId = String.ValueOf(clientMap.get('Id'));
        Account acc = new Account();
        acc.Id = accountId;
        acc.Insight_Id__c = insightId;
        acc.Insight_Row_Version__c = String.ValueOf(clientMap.get('RowVersion'));
        acc.Insight_Created_Who__c = String.ValueOf(clientMap.get('CreatedWho'));
        acc.Insight_Created_When__c = String.ValueOf(clientMap.get('CreatedWhen'));
        acc.Insight_Updated_Who__c = String.ValueOf(clientMap.get('UpdateddWho'));
        acc.Insight_Updated_When__c = String.ValueOf(clientMap.get('UpdateddWhen'));
        acc.Get_JSON_Response__c = resonseBody;
        if(serviceName.toLowerCase() == 'get_client')
        {
            
            acc.Trading_As__c = String.ValueOf(clientMap.get('TradingAs'));
            acc.Reference_Code__c = String.ValueOf(clientMap.get('Ref'));
            acc.ABN__c = String.ValueOf(clientMap.get('ABN'));
            acc.Email__c = String.ValueOf(clientMap.get('Email'));
            acc.Phone = String.ValueOf(clientMap.get('Telephone'));
            acc.MobilePhone__c = String.ValueOf(clientMap.get('Telephone2'));
            acc.MobilePhone__c = String.ValueOf(clientMap.get('Mobile'));
            acc.Fax =     String.ValueOf(clientMap.get('Fax'));
            acc.Website = String.ValueOf(clientMap.get('Web'));
            // Address Mapping (Primary Address)
            acc.BillingStreet = String.ValueOf(clientMap.get('AddressLine1'));
            acc.Billingcity = String.ValueOf(clientMap.get('City'));
            acc.Billingstate = String.ValueOf(clientMap.get('Suburb'));
            acc.BillingpostalCode = String.ValueOf(clientMap.get('Postcode'));
            acc.Billingcountry = String.ValueOf(clientMap.get('CountryName'));
            acc.BillingState = String.ValueOf(clientMap.get('StateName'));
            acc.Sic = String.ValueOf(clientMap.get('StandardIndustryCode'));
            acc.Compliance_Type__c = String.ValueOf(clientMap.get('ComplianceTypeName'));
            acc.Classification__c = String.ValueOf(clientMap.get('ClassificationName'));
            acc.Vulnerable_Client__c = String.ValueOf(clientMap.get('VulnerableClient'));
            acc.Sales_Team__c =     String.ValueOf(clientMap.get('SalesTeamName'));
            acc.Service_Team__c =         String.ValueOf(clientMap.get('ServiceTeamName'));
            acc.Classification__c     =  String.ValueOf(clientMap.get('ClassificationName'));
            acc.Compliance_Type__c   =  String.ValueOf(clientMap.get('ComplianceTypeName'));
            system.debug('IndustryId'+clientMap.get('IndustryId'));
            if(clientMap.get('IndustryId') != null)
                acc.Industry           = ReferenceMetadataUtility.getIdtoPicklistText('Industry', Integer.ValueOf(clientMap.get('IndustryId')));
            if(clientMap.get('SourceOfBusinessId') != null)
                acc.AccountSource = ReferenceMetadataUtility.getIdtoPicklistText('AccountSource', Integer.ValueOf(clientMap.get('SourceOfBusinessId'))); 
            if(clientMap.get('AreaId') != null)
                acc.Area__c = ReferenceMetadataUtility.getIdtoPicklistText('Area', Integer.ValueOf(clientMap.get('AreaId'))); 
            if(clientMap.get('ReferrerId') != null)
                acc.Referrer__c = ReferenceMetadataUtility.getIdtoPicklistText('Referrer', Integer.ValueOf(clientMap.get('ReferrerId')));  
            if(clientMap.get('Category1Id') != null)   
                acc.Client_Category_1__c  = ReferenceMetadataUtility.getIdtoPicklistText('Client_Category_1', Integer.ValueOf(clientMap.get('Category1Id')));
            if(clientMap.get('Category3Id') != null)
                acc.Client_Category_3__c  = ReferenceMetadataUtility.getIdtoPicklistText('Client_Category_3', Integer.ValueOf(clientMap.get('Category3Id')));
        }
        
        
        update acc;
    }
    
    private InsightClientRequestWrapper mapAccountToRequestWrapper()
    {
        
        List<Account> accountList = [SELECT Name, Trading_As__c, Reference_Code__c, 
                                     ABN__c, Email__c, Phone, Insight_Row_Version__c,Insight_Created_Who__c,Insight_Created_When__c,
                                     MobilePhone__c, Fax, Website, Branch__c, Owner.Name, 
                                     Turnover_Estimated_next_12_months__c, Vulnerable_Client__c,AccountSource,
                                     Compliance_Type__c, Classification__c,Industry,Referrer__c,
                                     Legal_Entity_Type__c, Sic,Insight_Id__c,Area__c,Sales_Team__c,Service_Team__c,
                                     Insight_Updated_Who__c, Insight_Updated_When__c,Get_JSON_Response__c,
                                     Client_Category_1__c,Client_Category_3__c,Account_Type__c,
                                     BillingStreet, Billingcity, Billingstate, Billingcountry,BillingpostalCode
                                     FROM Account
                                     WHERE Id = :accountId];
        
        InsightClientRequestWrapper payload = new InsightClientRequestWrapper();
        InsightClientRequestWrapper.cls_Client clientRequest = new InsightClientRequestWrapper.cls_Client();
        
        
        if(!accountList.isEmpty())
        {
            client = accountList[0];
            if(serviceName.toLowerCase() == 'update_client'){
                payload = (InsightClientRequestWrapper) JSON.deserialize(client.Get_JSON_Response__c, InsightClientRequestWrapper.class);
                clientRequest = payload.client;
            }
            // Map fields from Account to wrapper.Client
            clientRequest.Name = client.Name;
            // 0 = Client, // 1 = Prospect
            clientRequest.ClientTypeId = client.Account_Type__c == 'Client' ? 0 : 1; 
            //0 = Current (Active) client , 1 = Non Current (Inactive) client.
            clientRequest.CurrentStatusId = 0;
            clientRequest.TradingAs = client.Trading_As__c;
            clientRequest.Ref = client.Reference_Code__c;
            clientRequest.ABN = client.ABN__c;
            clientRequest.Email = client.Email__c;
            clientRequest.Telephone = client.Phone;
            clientRequest.Telephone2 = client.MobilePhone__c;
            clientRequest.Mobile = client.MobilePhone__c;
            clientRequest.IndustryId  = ReferenceMetadataUtility.mapPicklistToId('Industry', client.Industry);
            clientRequest.ClassificationId = ReferenceMetadataUtility.mapPicklistToId('Classification', client.Classification__c); 
            clientRequest.ComplianceTypeId = ReferenceMetadataUtility.mapPicklistToId('Compliance_Type', client.Compliance_Type__c); 
            clientRequest.SourceOfBusinessId = ReferenceMetadataUtility.mapPicklistToId('AccountSource', client.AccountSource); 
            clientRequest.AreaId = ReferenceMetadataUtility.mapPicklistToId('Area', client.Area__c); 
            clientRequest.ReferrerId = ReferenceMetadataUtility.mapPicklistToId('Referrer', client.Referrer__c); 
            clientRequest.Fax = client.Fax;
            clientRequest.Web = client.Website;
            clientRequest.BranchName = client.Branch__c;
            clientRequest.SalesTeamName = client.Owner.Name;
            clientRequest.AnnualTurnover = client.Turnover_Estimated_next_12_months__c != null 
                ? client.Turnover_Estimated_next_12_months__c.intValue() : null;
            clientRequest.ComplianceTypeName = client.Compliance_Type__c;
            clientRequest.ClassificationName = client.Classification__c;
            clientRequest.SalesTeamId = ReferenceMetadataUtility.mapPicklistToId('Sales_Team', client.Sales_Team__c);
            clientRequest.ServiceTeamId = ReferenceMetadataUtility.mapPicklistToId('Service_Team', client.Service_Team__c);
            clientRequest.Category1Id = ReferenceMetadataUtility.mapPicklistToId('Client_Category_1', client.Client_Category_1__c);
            clientRequest.Category3Id = ReferenceMetadataUtility.mapPicklistToId('Client_Category_3', client.Client_Category_3__c);
            clientRequest.VulnerableClient = client.Vulnerable_Client__c;
            // Address Mapping (Primary Address)
            clientRequest.AddressLine1 = client.BillingStreet;
            clientRequest.City = client.Billingcity;
            clientRequest.Suburb = client.Billingstate;
            clientRequest.Postcode = client.BillingpostalCode;
            clientRequest.CountryName = client.Billingcountry;
            clientRequest.StateName = client.BillingState;
            // Handle primary address mapping
            clientRequest.OneLineAddress = client.Billingstreet != null
                ? client.Billingstreet + ', ' + 
                client.Billingcity + ', ' + 
                client.Billingstate + ', ' + 
                client.BillingpostalCode + ', ' + 
                client.Billingcountry
                : null;
            // Additional fields and relationships can be mapped similarly...
            clientRequest.StandardIndustryCode = client.Sic;
            payload.client = clientRequest;
        }
        return payload;
    }
}