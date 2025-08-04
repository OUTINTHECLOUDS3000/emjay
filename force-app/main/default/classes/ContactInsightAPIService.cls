public class ContactInsightAPIService extends InsightApiServiceBase  implements IApiInsightService{
    
    string serviceName;
    string contactId;
    Contact clientContact;
    public ContactInsightApiService(String apiName,  string recordId) { 
        super(apiName); 
        serviceName = apiName;
        contactId = recordId;
    }  
    
    @InvocableMethod(label='Sync Contact From Insight' description='Performs a callout to an external system' callout=true)
	public static void syncContactFromInsight(List<Id> recordIds) {
       string contactId = recordIds[0];
       InsightAPIController.ExecuteInsightAPI('Get_Contact', contactId);
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
        if(serviceName.toLowerCase() == 'get_contact')
        {
            payload =  getContactPayload();
        }
        else if(serviceName.toLowerCase() == 'create_contact')
        {
            payload =  createContactPayload();
        }
        else if(serviceName.toLowerCase() == 'update_contact')
        {
            payload =  updateContactPayload();
        }
        return payload;
    }
    
    private string getContactPayload()
    {
        Map<String,Integer> payload = new Map<String,Integer>();
        List<Contact> contactList = [SELECT Id, Insight_Id__c
                                     FROM Contact
                                     WHERE Id = :contactId];
        if(!contactList.isEmpty())
        {
            payload.put('Id', Integer.ValueOf(contactList[0].Insight_Id__c));
        }
        return JSON.serialize(payload);
    }
    
    private string createContactPayload()
    {
        InsightContactRequestWrapper payload =  mapContactToRequestWrapper();
        payload.Contact.Id = 0;
        return JSON.SERIALIZE(payload,FALSE);
    }
    
    private string updateContactPayload()
    {
        InsightContactRequestWrapper payload =  mapContactToRequestWrapper();
        /* payload.Contact.Id =   Integer.ValueOf(clientContact.Insight_Id__c);
payload.Contact.RowVersion = clientContact.Insight_Row_Version__c;
payload.Contact.CreatedWho = clientContact.Insight_Created_Who__c;
payload.Contact.CreatedWhen = String.ValueOf(clientContact.Insight_Created_When__c);
*/
        return JSON.SERIALIZE(payload,FALSE);
    }
    
    private void parseResponse(string resonseBody)
    {
        Map<String, Object> responseMap = (Map<String, Object>) JSON.deserializeUntyped(resonseBody);
        Map<String, Object> contactMap = (Map<String, Object>) responseMap.get('Contact');
        string insightId = String.ValueOf(contactMap.get('Id'));
        Contact con = new Contact();
        con.Id = contactId;
        con.Insight_Id__c = insightId;
        con.Insight_Row_Version__c = String.ValueOf(contactMap.get('RowVersion'));
        con.Insight_Created_Who__c = String.ValueOf(contactMap.get('CreatedWho'));
        con.Insight_Created_When__c = String.ValueOf(contactMap.get('CreatedWhen'));
        con.Insight_Updated_Who__c = String.ValueOf(contactMap.get('UpdateddWho'));
        con.Insight_Updated_When__c = String.ValueOf(contactMap.get('UpdateddWhen'));
        con.Get_JSON_Response__c = resonseBody;
        if(serviceName.toLowerCase() == 'get_contact')
        {
            con.MobilePhone  = String.ValueOf(contactMap.get('Mobile'));
            con.Fax = String.ValueOf(contactMap.get('Fax'));
            con.Email = String.ValueOf(contactMap.get('Email'));
            con.BirthDate = Date.ValueOf(contactMap.get('Birthdate'));
            con.Salutation = String.ValueOf(contactMap.get('Salutation'));
            con.Title  = String.ValueOf(contactMap.get('JobTitle'));
            con.Phone  = String.ValueOf(contactMap.get('Telephone'));
        }
        update con;
    }
    
    private InsightContactRequestWrapper mapContactToRequestWrapper()
    {
        ReferenceMetadataUtility.setCustomMetadataMap();
        List<Contact> ContactList = [SELECT Id,Name,AccountId, Account.Insight_Id__c, Phone, Fax,MobilePhone,
                                     Insight_Row_Version__c,Insight_Created_Who__c,Insight_Created_When__c,
                                     Email, Birthdate, Title, Owner.Name,Salutation,Primary_Contact__c,Insight_Id__c,
                                     Insight_Updated_Who__c,Insight_Updated_When__c,Get_JSON_Response__c
                                     FROM Contact
                                     WHERE Id = :contactId];
        InsightContactRequestWrapper payload = new InsightContactRequestWrapper();
        InsightContactRequestWrapper.cls_Contact contactRequest = new InsightContactRequestWrapper.cls_Contact();
        if(!ContactList.isEmpty())
        {
            clientContact = ContactList[0];
            
            if(serviceName.toLowerCase() == 'update_contact'){
                payload = (InsightContactRequestWrapper) JSON.deserialize(clientContact.Get_JSON_Response__c, InsightContactRequestWrapper.class);
                contactRequest = payload.contact;
            }
            
            // Map fields from Contact to wrapper.Client
            contactRequest.Mobile = clientContact.MobilePhone;
            contactRequest.Fax = clientContact.Fax;
            contactRequest.Email = clientContact.Email;
            contactRequest.BirthDate = string.valueOf(clientContact.Birthdate);
            if(!String.IsEmpty(clientContact.Account.Insight_Id__c))
                contactRequest.ParentId  = Integer.ValueOf(clientContact.Account.Insight_Id__c);
            contactRequest.IsPrimary = true;
            contactRequest.Salutation = clientContact.Salutation;
            contactRequest.JobTitle = clientContact.Title;
            contactRequest.Telephone = clientContact.Phone;
            contactRequest.Addressee = clientContact.Name;
            payload.contact = contactRequest;	
        }
        
        return payload;
    }
}