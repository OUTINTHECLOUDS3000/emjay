public without sharing class PolicyTransactionHandler {
    
    public static void handle(String jsonInput) {
        Map<String,Object> deserializedPayload = (Map<String, Object>) JSON.deserializeUntyped(jsonInput);
        String serviceName = (string)deserializedPayload.get('EventCode');
        if(serviceName == 'CreatePolicyTransaction') {
            upsertPolicyTransaction(jsonInput);
        }
        else if(serviceName == 'UpdatePolicyTransaction'){ 
            upsertPolicyTransaction(jsonInput);
        }	
        else
            DeletePolicyTransaction(jsonInput);
    }
    
    public static void upsertPolicyTransaction(String jsonResponse) {
        // Deserialize JSON
        boolean isUpdate = false;
        UpdatePolicyTransactionWrapper eventData = (UpdatePolicyTransactionWrapper) JSON.deserialize(jsonResponse,UpdatePolicyTransactionWrapper.Class);
        UpdatePolicyTransactionWrapper.cls_Client accountData = eventdata.Client;
        UpdatePolicyTransactionWrapper.cls_PolicyTransaction policyData = eventdata.PolicyTransaction;
        UpdatePolicyTransactionWrapper.cls_Insurer insurerData = eventdata.Insurer;
        string policyId = String.ValueOf(policyData.PolicyId);
        // Create a new Policy record and map fields
        List<InsurancePolicy> policies = [Select Id,Policy_Id__c From InsurancePolicy WHERE Policy_Id__c=:policyId];
        InsurancePolicy policy = new InsurancePolicy();
        if(policies!=NULL && !policies.isEmpty())
        {
            policy = policies[0];
            isUpdate = true;
        }
        // Map PolicyTransaction fields
        policy.Name = PolicyId; // Assuming this is the policy name
        policy.PolicyName = policyId + ' - ' + policyData.PolicyNumber;
        policy.Policy_Id__c = policyId;
        policy.Policy_Number__c = policyData.PolicyNumber; // Unique ID
        policy.PolicyDescription= policyData.Description;
        policy.Invoice_Number__c = String.ValueOf(policyData.InvoiceNumber);
        policy.Class_of_Risk__c = policyData.ClassOfRiskName;
        policy.From_Date__c = Date.valueOf(policyData.FromDate);
        policy.To_Date__c = Date.valueOf(policyData.ToDate);
        policy.EffectiveDate = Date.valueOf(policyData.EffectiveDate); 
        // Map Client fields
        policy.NameInsuredId = getAccountIdByInsightId(accountData); // Assuming Account is matched by Name
        // Map Insurer fields
        policy.Insurer_Name__c = insurerData.Name;
        policy.Insight_Id__c = String.ValueOf(policyData.Id);
        policy.Transaction_Type_Name__c = policyData.TransactionTypeName;
        Invoice__c invoice;
        InsurancePolicyTransaction pTransaction;
        
        if(!String.isEmpty(String.ValueOf(policyData.Id)))
        {
            pTransaction = getPolicyTransaction(String.ValueOf(policyData.Id));
        }
        if(!String.isEmpty(policy.Invoice_Number__c))
        {
            string invoiceId = policy.Invoice_Number__c+'_'+String.ValueOf(accountData.Id)+'_'+1;
            invoice = getInvoice(invoiceId,pTransaction);
        }
        try
        {
            if(isUpdate)
                update policy;
            else
                insert policy;
        }
        catch(exception e)
        {
            system.debug('upsert Error');
        }
        if(pTransaction!=null)
        {
            pTransaction.InsurancePolicyId = policy.Id;
            upsert pTransaction Insight_Id__c;
        }
        if(invoice!=null)
        {
            invoice.InsurancePolicy__c = policy.Id;
            invoice.Payer__c = policy.NameInsuredId;
            upsert invoice Invoice_Id__c;
        }
    }
    
    public static Invoice__c getInvoice(string invoiceId,InsurancePolicyTransaction pTransaction)
    {
        string responseBody = InsightAPIController.ExecuteInsightAPI('Get_Invoice',invoiceId);
        
        Invoice__c invoice;
        if(responseBody!=NULL)
        {
            Map<String,Object> responseMap = (Map<String, Object>) JSON.deserializeUntyped(responseBody);
            Map<String,Object> invoiceMap = (Map<String,Object>) responseMap.get('Invoice');
            
            if(invoiceMap!=NULL && !invoiceMap.isEmpty())
            {
                invoice = new Invoice__c();
                invoice.Invoice_Id__c = String.ValueOf(invoiceMap.get('Id'));
                invoice.Name = String.ValueOf(invoiceMap.get('InvoiceNumber'));
                invoice.TransactionItemAmount__c = Decimal.ValueOf(String.ValueOf(invoiceMap.get('TransactionItemAmount')));
                invoice.BalanceAmount__c = Decimal.ValueOf(String.ValueOf(invoiceMap.get('BalanceAmount')));
                invoice.PremiumFundingStatus__c = String.ValueOf(invoiceMap.get('PremiumFundingStatus'));
                invoice.IsClientPayer__c = Boolean.ValueOf(String.ValueOf(invoiceMap.get('IsClientPayer')));
                invoice.IsInsurerPayer__c = Boolean.ValueOf(String.ValueOf(invoiceMap.get('IsInsurerPayer')));
                invoice.IsAuthorisedRepPayer__c = Boolean.ValueOf(String.ValueOf(invoiceMap.get('IsAuthorisedRepPayer')));
                invoice.IsCoClientPayer__c = Boolean.ValueOf(String.ValueOf(invoiceMap.get('IsCoClientPayer')));
            }
            else{
                
                invoice = new Invoice__c();
                invoice.Invoice_Id__c = invoiceId;
                if(pTransaction!=null){
                    invoice.Name = pTransaction.InvoiceNumber__c;
                    invoice.TransactionItemAmount__c = pTransaction.TotalGrossPremium__c;
                    invoice.BalanceAmount__c = pTransaction.Balance__c;
                }
            }
        }
        return invoice;
    }
    
    public static InsurancePolicyTransaction getPolicyTransaction(string policyTransactionId)
    {
        string responseBody = InsightAPIController.ExecuteInsightAPI('Get_PolicyTransaction',policyTransactionId);
        InsurancePolicyTransaction policyTransaction;
        if(responseBody!=NULL)
        {
            Map<String,Object> responseMap = (Map<String, Object>) JSON.deserializeUntyped(responseBody);
            Map<String,Object> jsonData = (Map<String,Object>) responseMap.get('PolicyTransaction');
            
            if(jsonData!=NULL && !jsonData.isEmpty())
            {
                policyTransaction = new InsurancePolicyTransaction();
                // Mapping fields
                policyTransaction.Name =  String.ValueOf(jsonData.get('Id'))+' - ' + String.ValueOf(jsonData.get('TransactionTypeName')) ;
                policyTransaction.Insight_Id__c = String.ValueOf(jsonData.get('Id'));
                policyTransaction.AccountingMonth__c = (Integer) jsonData.get('AccountingMonth');
                policyTransaction.AccountingMonthName__c = String.ValueOf(jsonData.get('AccountingMonthName'));
                policyTransaction.AnnualBasePremium__c = getValue(jsonData,'AnnualBasePremium');
                policyTransaction.AnnualBrokerFee__c = getValue(jsonData,'AnnualBrokerFee');
                policyTransaction.AnnualBrokerFeeGST__c = getValue(jsonData,'AnnualBrokerFeeGST');
                policyTransaction.AnnualCommission__c = getValue(jsonData,'AnnualCommission');
                policyTransaction.AnnualCommissionGST__c = getValue(jsonData,'AnnualCommissionGST');
                policyTransaction.AnnualFSL__c = getValue(jsonData,'AnnualFSL');
                policyTransaction.AnnualInsurerGST__c = getValue(jsonData,'AnnualInsurerGST');
                policyTransaction.AnnualOtherCommission__c = getValue(jsonData,'AnnualOtherCommission');
                policyTransaction.AnnualOtherCommissionGST__c = getValue(jsonData,'AnnualOtherCommissionGST');
                policyTransaction.AnnualOtherLevy__c = getValue(jsonData,'AnnualOtherLevy');
                policyTransaction.AnnualOtherPremium__c = getValue(jsonData,'AnnualOtherPremium');
                policyTransaction.AnnualStampDuty__c = getValue(jsonData,'AnnualStampDuty');
                policyTransaction.AnnualStaticInvoiceTotal__c = getValue(jsonData,'AnnualStaticInvoiceTotal');
                policyTransaction.AnnualTotalBasePremium__c = getValue(jsonData,'AnnualTotalBasePremium');
                policyTransaction.AnnualTotalBrokerFee__c = getValue(jsonData,'AnnualTotalBrokerFee');
                policyTransaction.AnnualTotalCommission__c = getValue(jsonData,'AnnualTotalCommission');
                policyTransaction.AnnualTotalGrossPremium__c = getValue(jsonData,'AnnualTotalGrossPremium');
                policyTransaction.AnnualTotalGST__c = getValue(jsonData,'AnnualTotalGST');
                policyTransaction.AnnualTotalLevies__c = getValue(jsonData,'AnnualTotalLevies');
                policyTransaction.AnnualTotalNetPremium__c = getValue(jsonData,'AnnualTotalNetPremium');
                policyTransaction.AnnualUnderwriterFee__c = getValue(jsonData,'AnnualUnderwriterFee');
                policyTransaction.AnnualUnderwriterFeeGST__c = getValue(jsonData,'AnnualUnderwriterFeeGST');
                policyTransaction.Balance__c = getValue(jsonData,'Balance');
                policyTransaction.BasePremium__c = getValue(jsonData,'BasePremium');
                //policyTransaction.BillingWhen__c = (DateTime) jsonData.get('BillingWhen');
                policyTransaction.BrokerFee__c = getValue(jsonData,'BrokerFee');
                policyTransaction.BrokerFeeGST__c = getValue(jsonData,'BrokerFeeGST');
                policyTransaction.CommFeeExGST__c = getValue(jsonData,'CommFeeExGST');
                policyTransaction.CommFeeGST__c = getValue(jsonData,'CommFeeGST');
                policyTransaction.Commission__c = getValue(jsonData,'Commission');
                policyTransaction.CommissionGST__c = getValue(jsonData,'CommissionGST');
                policyTransaction.Insured__c = String.ValueOf(jsonData.get('Insured'));
                //policyTransaction.InsurerCreditTermsDueDate__c = (Date) jsonData.get('InsurerCreditTermsDueDate');
                policyTransaction.InsurerGST__c = getValue(jsonData,'InsurerGST');
                policyTransaction.InvoiceNumber__c = String.ValueOf(jsonData.get('InvoiceNumber'));
                policyTransaction.IsBrokerFeeOverridden__c = jsonData.get('IsBrokerFeeOverridden') !=null ? (Boolean) jsonData.get('IsBrokerFeeOverridden') : false ;
                policyTransaction.IsClosed__c = (Boolean) jsonData.get('IsClosed');
                policyTransaction.IsPaid__c = (Boolean) jsonData.get('IsPaid');
                policyTransaction.IsPosted__c = (Boolean) jsonData.get('IsPosted');
                policyTransaction.Location__c = String.ValueOf(jsonData.get('Location'));
                policyTransaction.Locked__c = (Boolean) jsonData.get('Locked');
                policyTransaction.NetIncomeTotal__c = getValue(jsonData,'NetIncomeTotal');
                policyTransaction.PolicyId__c = String.valueOf(jsonData.get('PolicyId'));
                policyTransaction.PolicyPeriodId__c = String.valueOf(jsonData.get('PolicyPeriodId'));
                policyTransaction.TotalGrossPremium__c = getValue(jsonData,'TotalGrossPremium');
                policyTransaction.TotalBrokerFee__c = getValue(jsonData,'TotalBrokerFee');
                policyTransaction.TotalNetPremium__c = getValue(jsonData,'TotalNetPremium');
                policyTransaction.TotalBasePremium__c = getValue(jsonData,'TotalBasePremium');
                policyTransaction.TotalCommission__c = getValue(jsonData,'TotalCommission');
                policyTransaction.TotalGST__c = getValue(jsonData,'TotalGST');
                policyTransaction.TotalGrossPremiumExBrokerFee__c = getValue(jsonData,'TotalGrossPremiumExBrokerFee');
                policyTransaction.IncomeTotal__c = getValue(jsonData,'IncomeTotal');
                policyTransaction.TotalCommFee__c = getValue(jsonData,'TotalCommFee');
                policyTransaction.NetCommExGST__c = getValue(jsonData,'NetCommExGST');
                policyTransaction.NetFeeExGST__c = getValue(jsonData,'NetFeeExGST');
                policyTransaction.TotalNetCommFeeExGST__c = getValue(jsonData,'TotalNetCommFeeExGST');
                policyTransaction.GrossInsurerPremium__c = getValue(jsonData,'GrossInsurerPremium');
                policyTransaction.TransactionNumber__c = String.ValueOf(jsonData.get('TransactionNumber'));
                policyTransaction.OtherCommissionGST__c = getValue(jsonData,'OtherCommissionGST');
                policyTransaction.OtherCommission__c = getValue(jsonData,'OtherCommission');
                policyTransaction.OtherPremium__c = getValue(jsonData,'OtherPremium');
                policyTransaction.UnderwriterFee__c = getValue(jsonData,'UnderwriterFee');
                policyTransaction.UnderwriterFeeGST__c = getValue(jsonData,'UnderwriterFeeGST');
                policyTransaction.ARFee__c =  getValue(jsonData,'ARFee');
                policyTransaction.ARCommission__c =  getValue(jsonData,'ARCommission');
                policyTransaction.ARCommissionGST__c =  getValue(jsonData,'ARFeeGST');
                policyTransaction.ARFeeGST__c =  getValue(jsonData,'ARFeeGST');
                policyTransaction.TotalARCommission__c =   getValue(jsonData,'TotalARCommission');
                policyTransaction.ARTotalPayable__c =      getValue(jsonData,'ARTotalPayable');
            }
        }
        return policyTransaction;
    }
    
    private static decimal getValue(Map<String,Object> jsonData, string key)
    {
        decimal returnValue = 0;
        if(jsonData.containsKey(key))
        {
            object value = jsonData.get(key);
            if(value !=null && (value instanceOf Decimal))
            {
                returnValue = (Decimal) value;
            }
        }
        return returnValue;
    }
    
    private static void DeletePolicyTransaction(String jsonResponse) {
        // Deserialize the JSON into an untyped map
        Map<String, Object> dataMap = (Map<String, Object>) JSON.deserializeUntyped(jsonResponse);
        
        // Extract the nested PolicyTransaction map
        Map<String, Object> policyTransaction = (Map<String, Object>) dataMap.get('PolicyTransaction');
        
        // Get the Id value
        String policyTransactionId = String.ValueOf(policyTransaction.get('Id'));
        // Create a new Policy record and map fields
        List<InsurancePolicyTransaction> policies = [Select Id,Insight_Id__c From InsurancePolicyTransaction WHERE Insight_Id__c=:policyTransactionId];
        if(policies!=NULL && !policies.isEmpty())
        {
            DELETE policies[0];
        }
    }
    
    // Helper method to get Account Id by Name
    private static Id getAccountIdByInsightId(UpdatePolicyTransactionWrapper.cls_Client accountData) {
        string InsightId = String.ValueOf(accountData.Id);
        if (String.isBlank(InsightId)) {
            return null;
        }
        List<Account> accountList = [SELECT Id FROM Account WHERE Insight_Id__c = :InsightId];
        if(accountList != NULL && !accountList.isEmpty())
            return accountList[0].Id;
        else 
            return createNewAccount(accountData);
    }
    private static Id createNewAccount(UpdatePolicyTransactionWrapper.cls_Client clientRequest) {
        Account client = new Account();
        client.Name = clientRequest.Name;
        client.Insight_Id__c = String.ValueOf(clientRequest.Id);
        client.Account_Type__c = 'Client';  
        client.Insight_Created_Who__c = String.ValueOf(clientRequest.CreatedWho);
        client.Insight_Created_When__c = String.ValueOf(clientRequest.CreatedWhen);
        client.Trading_As__c = clientRequest.TradingAs;
        client.Reference_Code__c = clientRequest.Ref;
        client.ABN__c = clientRequest.ABN;
        client.Email__c = clientRequest.Email;
        client.Phone = clientRequest.Telephone;
        client.MobilePhone__c = clientRequest.Mobile;
        /*client.Industry = ReferenceMetadataUtility.mapIdToPicklist('Industry', clientRequest.IndustryId);
client.Classification__c = ReferenceMetadataUtility.mapIdToPicklist('Classification', clientRequest.ClassificationId);
client.Compliance_Type__c = ReferenceMetadataUtility.mapIdToPicklist('Compliance_Type', clientRequest.ComplianceTypeId);
client.AccountSource = ReferenceMetadataUtility.mapIdToPicklist('AccountSource', clientRequest.SourceOfBusinessId);
client.Area__c = ReferenceMetadataUtility.mapIdToPicklist('Area', clientRequest.AreaId);
client.Referrer__c = ReferenceMetadataUtility.mapIdToPicklist('Referrer', clientRequest.ReferrerId);
*/
        client.Branch__c = clientRequest.BranchName;
        client.Compliance_Type__c = clientRequest.ComplianceTypeName;
        client.Classification__c = clientRequest.ClassificationName;
        /*client.Sales_Team__c = ReferenceMetadataUtility.mapIdToPicklist('Sales_Team', clientRequest.SalesTeamId);
client.Service_Team__c = ReferenceMetadataUtility.mapIdToPicklist('Service_Team', clientRequest.ServiceTeamId);
client.Client_Category_1__c = ReferenceMetadataUtility.mapIdToPicklist('Client_Category_1', clientRequest.Category1Id);
client.Client_Category_3__c = ReferenceMetadataUtility.mapIdToPicklist('Client_Category_3', clientRequest.Category3Id);
client.Vulnerable_Client__c = clientRequest.VulnerableClient;
*/
        // Address Mapping (Primary Address)
        client.BillingStreet = clientRequest.AddressLine1;
        client.Billingcity = clientRequest.City;
        //client.Billingstate = clientRequest.Suburb;
        client.BillingpostalCode = clientRequest.Postcode;
        client.Billingcountry = clientRequest.CountryName;
        // client.BillingState = clientRequest.StateName;
        // SIC Code
        // client.Sic = clientRequest.StandardIndustryCode;
        insert client;
        return client.Id;
    }
}