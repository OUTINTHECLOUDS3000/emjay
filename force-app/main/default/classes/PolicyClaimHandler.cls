public without sharing class PolicyClaimHandler {
    public static void handle(String jsonInput) {
		Map<String,Object> deserializedPayload = (Map<String, Object>) JSON.deserializeUntyped(jsonInput);
		String serviceName = (string)deserializedPayload.get('EventCode');
		if(serviceName == 'CreateClaim') {
			UpdatePolicyClaim(jsonInput);
		}
		else if(serviceName == 'UpdateClaim'){
			UpdatePolicyClaim(jsonInput);
		}	
		else
			DeletePolicyClaim(jsonInput);
    }

public static void UpdatePolicyClaim(String jsonResponse) {
    boolean isUpdate = false;
	// Deserialize JSON
	Map<String,Object> deserializedPayload = (Map<String, Object>) JSON.deserializeUntyped(jsonResponse);
	String claimResponse = JSON.serialize(deserializedPayload.get('Claim'));
    InsightCaseRequestWrapper.cls_Claim claimData = (InsightCaseRequestWrapper.cls_Claim) JSON.deserialize(claimResponse,InsightCaseRequestWrapper.cls_Claim.Class);
    // Create Claim Record
    Map<String,Object> policyData =  (Map<String, Object>) deserializedPayload.get('PolicyTransaction');
    string policyId = String.ValueOf(policyData.get('PolicyId'));
    Claim existingClaim = new Claim();
    List<Claim> existingClaimList = [SELECT ID,Claim_ID__c FROM Claim WHERE Claim_ID__c =:String.ValueOf(claimData.Id)];
        if(!existingClaimList.isEmpty())
        {           
            existingClaim = existingClaimList[0]; 
            isUpdate = true;    
        }
        existingClaim.Name = String.ValueOf(claimData.Id);
        existingClaim.Claim_ID__c = String.ValueOf(claimData.Id);
        existingClaim.InsurerClaimsRef__c = claimData.InsurerClaimsRef;
        if(claimData.LossDate!=null)
            existingClaim.LossDate = Date.ValueOf(claimData.LossDate);
        existingClaim.IsOpen__c = !claimData.IsOpen;
        existingClaim.StatusId__c= String.ValueOf(claimData.StatusId);
        existingClaim.StatusName__c = claimData.StatusName;
        existingClaim.Description__c= claimData.Description;
       // existingClaim = claimData.ClaimsTeamId
       // existingClaim = claimData.ClaimsTeamName
        existingClaim.PaidAmount__c = claimData.PaidAmount;
        //existingClaim.ClientId__c= claimData.ClientId;
        existingClaim.AccountId = getAccountIdByInsightId(String.ValueOf(claimData.ClientId));
        existingClaim.PolicyNumberId =  getPolicyByPolicyId(policyId);
        existingClaim.InsurerId__c= claimData.InsurerId;
        existingClaim.Excess__c = String.ValueOf(claimData.Excess);
        existingClaim.CreatedWho__c = claimData.CreatedWho;
        existingClaim.UpdatedWho__c = claimData.UpdatedWho;
        existingClaim.PolicyTransactionId__c = String.ValueOf(claimData.PolicyTransactionId);
        //existingClaim.Policy__c = clientCase.Policy__c;
        if(isUpdate)
            update existingClaim;
        else
            insert existingClaim;
}

private static void DeletePolicyClaim(String jsonResponse) {
	// Deserialize the JSON into an untyped map
Map<String, Object> dataMap = (Map<String, Object>) JSON.deserializeUntyped(jsonResponse);

// Extract the nested PolicyTransaction map
Map<String, Object> policyClaim = (Map<String, Object>) dataMap.get('Claim');

// Get the Id value
String policyClaimId = String.ValueOf(policyClaim.get('Id'));
   // Create a new Policy record and map fields
   List<Claim> Claims = [Select Id,Claim_ID__c From Claim WHERE Claim_ID__c=:policyClaimId];
   if(Claims!=NULL && !Claims.isEmpty())
   {
		DELETE Claims[0];
   }
}

// Helper method to get Account Id by Name
private static Id getAccountIdByInsightId(String InsightId) {
    if (String.isBlank(InsightId)) {
        return null;
    }
    List<Account> accountList = [SELECT Id FROM Account WHERE Insight_Id__c = :InsightId];
    if(accountList != NULL && !accountList.isEmpty())
            return accountList[0].Id;
     else 
            return NULL;
 }

 // Helper method to get Account Id by Name
private static Id getPolicyByPolicyId(String policyId) {
    if (String.isBlank(policyId)) {
        return null;
    }
    List<InsurancePolicy> policyList = [SELECT Id FROM InsurancePolicy WHERE Name = :policyId];
    if(policyList != NULL && !policyList.isEmpty())
            return policyList[0].Id;
     else 
            return NULL;
 }
}