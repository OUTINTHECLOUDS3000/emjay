@IsTest
public class PolicyTransactionHandlerTest implements HttpCalloutMock {
    
    // Mock HTTP response
    public HttpResponse respond(HttpRequest request) {
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setStatusCode(200);
        
        // Determine which mock response to return based on the endpoint
        String endpoint = request.getEndpoint();
        system.debug('Endpoint'+endpoint);
        if (endpoint.contains('PolicyTransaction')) {
            response.setBody('{"PolicyTransaction": {"Id": 120423, "AccountingMonth": 4, "AccountingMonthName": "April", "AnnualBasePremium": 1685.4, "AnnualBrokerFee": 0, "AnnualBrokerFeeGST": 0, "AnnualCommission": 446.64, "AnnualCommissionGST": 44.71, "AnnualFSL": 123.84, "AnnualInsurerGST": 180.92, "AnnualOtherCommission": 0, "AnnualOtherCommissionGST": 0, "AnnualOtherLevy": 0, "AnnualOtherPremium": 0, "AnnualStampDuty": 179.12, "AnnualStaticInvoiceTotal": 2500, "AnnualTotalBasePremium": 1685.4, "AnnualTotalBrokerFee": 0, "AnnualTotalCommission": 446.64, "AnnualTotalGrossPremium": 2500, "AnnualTotalGST": 225.63, "AnnualTotalLevies": 302.96, "AnnualTotalNetPremium": 1985.4, "AnnualUnderwriterFee": 0, "AnnualUnderwriterFeeGST": 0, "Balance": 2500, "BasePremium": 529.16, "BrokerFee": 325, "BrokerFeeGST": 32.5, "CommFeeExGST": 465.23, "CommFeeGST": 46.54, "Commission": 140.23, "CommissionGST": 14.04, "Insured": "P2E Services Pty Ltd", "InsurerGST": 57.78, "InvoiceNumber": 123456, "IsBrokerFeeOverridden": false, "IsClosed": false, "IsPaid": false, "IsPosted": false, "Location": "Sydney", "Locked": false, "NetIncomeTotal": 465.23, "PolicyId": 27941, "PolicyPeriodId": 65405, "TotalGrossPremium": 1204.96, "TotalBrokerFee": 357.5, "TotalNetPremium": 1092.69, "TotalBasePremium": 529.16, "TotalCommission": 154.27, "TotalGST": 104.32, "TotalGrossPremiumExBrokerFee": 847.46, "IncomeTotal": 511.77, "TotalCommFee": 511.77, "NetCommExGST": 140.23, "NetFeeExGST": 325, "TotalNetCommFeeExGST": 465.23, "GrossInsurerPremium": 847.46, "TransactionNumber": "TRX123456", "OtherCommissionGST": 0, "OtherCommission": 0, "OtherPremium": 0, "UnderwriterFee": 0, "UnderwriterFeeGST": 0, "ARFee": 50, "ARCommission": 25, "ARCommissionGST": 2.5, "ARFeeGST": 5, "TotalARCommission": 27.5, "ARTotalPayable": 82.5}}');
        } else if (endpoint.contains('Invoice')) {
            response.setBody('{"Invoice": {"Id": "INV123456_6735_1", "InvoiceNumber": 123456, "TransactionItemAmount": 1204.96, "BalanceAmount": 1204.96, "PremiumFundingStatus": "Not Funded", "IsClientPayer": true, "IsInsurerPayer": false, "IsAuthorisedRepPayer": false, "IsCoClientPayer": false}}');
        } else {
            response.setBody('{}');
        }
        
        return response;
    }
    
    @TestSetup
    static void setupTestData() {
        
        Account testAccount = new Account(
            Name = 'Test Account',
            Insight_Id__c = '6735',
            Account_Type__c = 'Client'
        );
        insert testAccount;
        
        
        InsurancePolicy testPolicy = new InsurancePolicy(
            Name = '27941',
            Policy_Id__c = '27941',
            NameInsuredId = testAccount.Id
        );
        insert testPolicy;
        
        
        InsurancePolicyTransaction testTransaction = new InsurancePolicyTransaction(
            Name = '120423 - Renewal',
            Insight_Id__c = '120423',
            PolicyId__c = '27941',
            InsurancePolicyId = testPolicy.Id
        );
        insert testTransaction;
    }
    
    @IsTest
    static void testDeletePolicyTransaction() {
        
        Test.setMock(HttpCalloutMock.class, new PolicyTransactionHandlerTest());
        
        
        String jsonPayload = '{' +
            '"EventCode": "DeletePolicyTransaction",' +
            '"EventTimeStamp": "2025-01-17T16:25:02.0914767+11:00",' +
            '"PolicyTransaction": {' +
            '"Id": 120423' +
            '}' +
            '}';
        
        
        Test.startTest();
        
        
        PolicyTransactionHandler.handle(jsonPayload);
        
        
        Test.stopTest();
        
        
        List<InsurancePolicyTransaction> transactions = [SELECT Id FROM InsurancePolicyTransaction WHERE Insight_Id__c = '120423'];
        System.assertEquals(0, transactions.size(), 'Policy transaction should have been deleted');
    }
    
    @IsTest
    static void testCreatePolicyTransaction() {
        
        Test.setMock(HttpCalloutMock.class, new PolicyTransactionHandlerTest());
        
        
        String jsonPayload = '{' +
            '"EventCode": "CreatePolicyTransaction",' +
            '"EventTimeStamp": "2025-01-17T16:25:02.0914767+11:00",' +
            '"LedgerName": "emjay",' +
            '"LedgerDisplayName": "Emjay Insurance Brokers",' +
            '"Client": {' +
            '"Id": 6735,' +
            '"Ref": "P2E",' +
            '"Name": "Test Account",' +
            '"TradingAs": "",' +
            '"ABN": "71 151 805 408",' +
            '"AddressLine1": "Level 1 24 Hickson Road",' +
            '"AddressLine2": "",' +
            '"AddressLine3": "",' +
            '"State": 1,' +
            '"City": "",' +
            '"Postcode": "2000",' +
            '"CountryId": 14,' +
            '"CountryName": "AUSTRALIA",' +
            '"AccountTypeId": 2,' +
            '"AccountTypeName": "Credit",' +
            '"ClassificationId": 4,' +
            '"ClassificationName": "Commercial",' +
            '"BranchId": 4,' +
            '"BranchName": "Mario Cuenca",' +
            '"SalesTeamId": 47,' +
            '"SalesTeamName": "Montana Pinto",' +
            '"ServiceTeamId": 53,' +
            '"ServiceTeamName": "Montana Pinto",' +
            '"NatureOfBusiness": "",' +
            '"IndustryId": 14,' +
            '"IndustryName": "Information Technology",' +
            '"RecordPermissionsGroupId": 2,' +
            '"CreatedWho": "asupple",' +
            '"CreatedWhen": "2018-10-26T16:05:00",' +
            '"UpdatedWhen": "2024-10-22T17:43:00",' +
            '"VulnerableClient": false,' +
            '"ComplianceTypeName": "Retail",' +
            '"Suburb": "Millers Point",' +
            '"Email": "john@example.com",' +
            '"Telephone": "02 9113 5400",' +
            '"Telephone2": "",' +
            '"Mobile": "TBA"' +
            '},' +
            '"Insurer": {' +
            '"Id": 6348,' +
            '"Ref": "CHUB",' +
            '"Name": "Chubb Insurance",' +
            '"TradingAs": "",' +
            '"ABN": "71 151 805 408",' +
            '"AddressLine1": "Level 29",' +
            '"AddressLine2": "2 Park Street",' +
            '"AddressLine3": "",' +
            '"State": 1,' +
            '"City": "",' +
            '"Postcode": "2000",' +
            '"CountryId": 14,' +
            '"CountryName": "AUSTRALIA",' +
            '"CreatedWho": "STFSAZURE\\\\namph.st76389",' +
            '"CreatedWhen": "2018-10-01T14:18:00",' +
            '"UpdatedWhen": "2020-08-25T10:41:00",' +
            '"Suburb": "SYDNEY",' +
            '"Email": "",' +
            '"Telephone": "9273 0100",' +
            '"Telephone2": "",' +
            '"Mobile": ""' +
            '},' +
            '"PolicyTransaction": {' +
            
            '"Description": "Unposted",' +
            '"ClassOfRiskId": 26,' +
            '"ClassOfRiskName": "Business Insurance",' +
            '"FromDate": "2025-01-31",' +
            '"ToDate": "2026-01-31",' +
            '"EffectiveDate": "2025-01-31",' +
            
            '"PreviousPolicyTransactionId": 114748,' +
            '"PolicyNumber": "QSBP002787533",' +
            '"CoverNoteNumber": "",' +
            '"CreatedWho": "athomas",' +
            '"CreatedWhen": "2024-12-16T11:01:00",' +
            '"UpdatedWho": "athomas",' +
            '"UpdatedWhen": "2025-01-17T16:25:00",' +
            '"ClientId": 6735,' +
            '"InsurerId": 6348,' +
            '"PolicyId": 27941,' +
            '"TransactionTypeName": "Renewal Invitation",' +
            '"PolicyPeriodId": 65405' +
            '}' +
            '}';
        
        
        Test.startTest();
        
        
        PolicyTransactionHandler.handle(jsonPayload);
        
        Test.stopTest();
        
        
        List<InsurancePolicy> policies = [SELECT Id, Policy_Number__c FROM InsurancePolicy WHERE Policy_Id__c = '27941'];
        System.assertEquals(1, policies.size(), 'Policy should exist');
        System.assertEquals('QSBP002787533', policies[0].Policy_Number__c, 'Policy number should be updated');
    }
    
    @IsTest
    static void testUpdatePolicyTransaction() {
        
        Test.setMock(HttpCalloutMock.class, new PolicyTransactionHandlerTest());
        
        
        String jsonPayload = '{' +
            '"EventCode": "UpdatePolicyTransaction",' +
            '"EventTimeStamp": "2025-01-17T16:25:02.0914767+11:00",' +
            '"LedgerName": "emjay",' +
            '"LedgerDisplayName": "Emjay Insurance Brokers",' +
            '"Client": {' +
            '"Id": 6735,' +
            '"Ref": "P2E",' +
            '"Name": "Test Account",' +
            '"TradingAs": "",' +
            '"ABN": "71 151 805 408",' +
            '"AddressLine1": "Level 1 24 Hickson Road",' +
            '"AddressLine2": "",' +
            '"AddressLine3": "",' +
            '"State": 1,' +
            '"City": "",' +
            '"Postcode": "2000",' +
            '"CountryId": 14,' +
            '"CountryName": "AUSTRALIA",' +
            '"AccountTypeId": 2,' +
            '"AccountTypeName": "Credit",' +
            '"ClassificationId": 4,' +
            '"ClassificationName": "Commercial",' +
            '"BranchId": 4,' +
            '"BranchName": "Mario Cuenca",' +
            '"SalesTeamId": 47,' +
            '"SalesTeamName": "Montana Pinto",' +
            '"ServiceTeamId": 53,' +
            '"ServiceTeamName": "Montana Pinto",' +
            '"NatureOfBusiness": "",' +
            '"IndustryId": 14,' +
            '"IndustryName": "Information Technology",' +
            '"RecordPermissionsGroupId": 2,' +
            '"CreatedWho": "asupple",' +
            '"CreatedWhen": "2018-10-26T16:05:00",' +
            '"UpdatedWhen": "2024-10-22T17:43:00",' +
            '"VulnerableClient": false,' +
            '"ComplianceTypeName": "Retail",' +
            '"Suburb": "Millers Point",' +
            '"Email": "john@example.com",' +
            '"Telephone": "02 9113 5400",' +
            '"Telephone2": "",' +
            '"Mobile": "TBA"' +
            '},' +
            '"Insurer": {' +
            '"Id": 6348,' +
            '"Ref": "CHUB",' +
            '"Name": "Chubb Insurance Updated",' +
            '"TradingAs": "",' +
            '"ABN": "71 151 805 408",' +
            '"AddressLine1": "Level 29",' +
            '"AddressLine2": "2 Park Street",' +
            '"AddressLine3": "",' +
            '"State": 1,' +
            '"City": "",' +
            '"Postcode": "2000",' +
            '"CountryId": 14,' +
            '"CountryName": "AUSTRALIA",' +
            '"CreatedWho": "STFSAZURE\\\\namph.st76389",' +
            '"CreatedWhen": "2018-10-01T14:18:00",' +
            '"UpdatedWhen": "2020-08-25T10:41:00",' +
            '"Suburb": "SYDNEY",' +
            '"Email": "",' +
            '"Telephone": "9273 0100",' +
            '"Telephone2": "",' +
            '"Mobile": ""' +
            '},' +
            '"PolicyTransaction": {' +
            '"Id": 120423,' +
            '"Description": "Updated",' +
            '"ClassOfRiskId": 26,' +
            '"ClassOfRiskName": "Business Insurance",' +
            '"FromDate": "2025-01-31",' +
            '"ToDate": "2026-01-31",' +
            '"EffectiveDate": "2025-01-31",' +
            '"InvoiceNumber": 123456,' +
            '"PreviousPolicyTransactionId": 114748,' +
            '"PolicyNumber": "QSBP002787533-Updated",' +
            '"CoverNoteNumber": "",' +
            '"CreatedWho": "athomas",' +
            '"CreatedWhen": "2024-12-16T11:01:00",' +
            '"UpdatedWho": "athomas",' +
            '"UpdatedWhen": "2025-01-17T16:25:00",' +
            '"ClientId": 6735,' +
            '"InsurerId": 6348,' +
            '"PolicyId": 27941,' +
            '"TransactionTypeName": "Renewal Invitation Updated",' +
            '"PolicyPeriodId": 65405' +
            '}' +
            '}';
        
        
        Test.startTest();
        
        
        PolicyTransactionHandler.handle(jsonPayload);
        
        Test.stopTest();
        
        
        List<InsurancePolicy> policies = [SELECT Id, Policy_Number__c, Insurer_Name__c, Transaction_Type_Name__c, Class_of_Risk__c 
                                          FROM InsurancePolicy WHERE Policy_Id__c = '27941'];
        System.assertEquals(1, policies.size(), 'Policy should exist');
        System.assertEquals('QSBP002787533-Updated', policies[0].Policy_Number__c, 'Policy number should be updated');
        System.assertEquals('Chubb Insurance Updated', policies[0].Insurer_Name__c, 'Insurer name should be updated');
        System.assertEquals('Renewal Invitation Updated', policies[0].Transaction_Type_Name__c, 'Transaction type should be updated');
        System.assertEquals('Business Insurance', policies[0].Class_of_Risk__c, 'Class of risk should be updated');
    }
    
    @IsTest
    static void testCreatePolicyWithNewAccount() {
        
        Test.setMock(HttpCalloutMock.class, new PolicyTransactionHandlerTest());
        
        
        String jsonPayload = '{' +
            '"EventCode": "CreatePolicyTransaction",' +
            '"EventTimeStamp": "2025-01-17T16:25:02.0914767+11:00",' +
            '"LedgerName": "emjay",' +
            '"LedgerDisplayName": "Emjay Insurance Brokers",' +
            '"Client": {' +
            '"Id": 9999,' +
            '"Ref": "NEW",' +
            '"Name": "New Test Client",' +
            '"TradingAs": "Trading Name",' +
            '"ABN": "71 151 805 408",' +
            '"AddressLine1": "123 Test Street",' +
            '"AddressLine2": "",' +
            '"AddressLine3": "",' +
            '"State": 1,' +
            '"City": "Test City",' +
            '"Postcode": "2000",' +
            '"CountryId": 14,' +
            '"CountryName": "AUSTRALIA",' +
            '"AccountTypeId": 2,' +
            '"AccountTypeName": "Credit",' +
            '"ClassificationId": 4,' +
            '"ClassificationName": "Commercial",' +
            '"BranchId": 4,' +
            '"BranchName": "Test Branch",' +
            '"CreatedWho": "testuser",' +
            '"CreatedWhen": "2025-01-01T00:00:00",' +
            '"UpdatedWhen": "2025-01-02T00:00:00",' +
            '"VulnerableClient": false,' +
            '"ComplianceTypeName": "Retail",' +
            '"Suburb": "Test Suburb",' +
            '"Email": "test@example.com",' +
            '"Telephone": "02 1234 5678",' +
            '"Mobile": "0412 345 678"' +
            '},' +
            '"Insurer": {' +
            '"Id": 6348,' +
            '"Name": "Test Insurer",' +
            '"CountryName": "AUSTRALIA"' +
            '},' +
            '"PolicyTransaction": {' +
            '"Id": 99999,' +
            '"Description": "New Policy",' +
            '"ClassOfRiskName": "Business Insurance",' +
            '"FromDate": "2025-01-31",' +
            '"ToDate": "2026-01-31",' +
            '"EffectiveDate": "2025-01-31",' +
            '"InvoiceNumber": 999999,' +
            '"PolicyNumber": "NEW123456",' +
            '"PolicyId": 99999,' +
            '"TransactionTypeName": "New Business"' +
            '}' +
            '}';
        
        
        Test.startTest();
        
        
        PolicyTransactionHandler.handle(jsonPayload);
        
        Test.stopTest();
        
        
        List<Account> accounts = [SELECT Id, Name, Insight_Id__c FROM Account WHERE Insight_Id__c = '9999'];
        System.assertEquals(1, accounts.size(), 'New account should have been created');
        System.assertEquals('New Test Client', accounts[0].Name, 'Account name should match');
        
        
        List<InsurancePolicy> policies = [SELECT Id, Policy_Id__c, Policy_Number__c, NameInsuredId 
                                          FROM InsurancePolicy WHERE Policy_Id__c = '99999'];
        System.assertEquals(1, policies.size(), 'Should have created a new policy');
        System.assertEquals('NEW123456', policies[0].Policy_Number__c, 'Policy number should match');
        System.assertEquals(accounts[0].Id, policies[0].NameInsuredId, 'Policy should be linked to the new account');
    }
    
    @IsTest
    static void testPolicyTransactionAPICall() {
        
        Test.startTest();
          Test.setMock(HttpCalloutMock.class, new PolicyTransactionHandlerTest());
        
        String response = InsightAPIController.ExecuteInsightAPI('Get_PolicyTransaction', '120423');
        
        Test.stopTest();
        
        
        System.assertNotEquals(null, response, 'API response should not be null');
        
        
        Map<String, Object> responseMap = (Map<String, Object>)JSON.deserializeUntyped(response);
        Map<String, Object> policyTransaction = (Map<String, Object>)responseMap.get('PolicyTransaction');
        
        System.assertNotEquals(null, policyTransaction, 'PolicyTransaction object should exist in response');
        System.assertEquals('120423', String.valueOf(policyTransaction.get('Id')), 'PolicyTransaction ID should match');
    }
    
    @IsTest
    static void testInvoiceAPICall() {
        
        Test.startTest();
          Test.setMock(HttpCalloutMock.class, new PolicyTransactionHandlerTest());
        
        String response = InsightAPIController.ExecuteInsightAPI('Get_Invoice', 'INV123456_6735_1');
        
        Test.stopTest();
        
        System.assertNotEquals(null, response, 'API response should not be null');
        
        
        Map<String, Object> responseMap = (Map<String, Object>)JSON.deserializeUntyped(response);
        Map<String, Object> invoice = (Map<String, Object>)responseMap.get('Invoice');
        
        System.assertNotEquals(null, invoice, 'Invoice object should exist in response');
        System.assertEquals('INV123456_6735_1', String.valueOf(invoice.get('Id')), 'Invoice ID should match');
    }
    
       @IsTest
    static void testInvoiceAPICallMethod() {
        Test.startTest();
        Account testAccount = new Account(
            Name = 'Test Accounttt',
            Insight_Id__c = '67354',
            Account_Type__c = 'Client'
        );
        insert testAccount;
        InsurancePolicy testPolicy = new InsurancePolicy(
            Name = '279413',
            Policy_Id__c = '279412',
            NameInsuredId = testAccount.Id
        );
        insert testPolicy;
       
        InsurancePolicyTransaction testTransaction = new InsurancePolicyTransaction(
            Name = '120443 - Renewal',
            Insight_Id__c = '120424',
            PolicyId__c = '279412',
            InsurancePolicyId = testPolicy.Id
        );
        insert testTransaction;
          Test.setMock(HttpCalloutMock.class, new PolicyTransactionHandlerTest());
        
        PolicyTransactionHandler.getInvoice('INV123456_6735_1',testTransaction);
        Test.stopTest();
    }
      @IsTest
    static void testPtransactionAPICallMethod() {
         Test.setMock(HttpCalloutMock.class, new PolicyTransactionHandlerTest());
        
        Account testAccount = new Account(
            Name = 'Test Accounttt',
            Insight_Id__c = '67354',
            Account_Type__c = 'Client'
        );
        insert testAccount;
        InsurancePolicy testPolicy = new InsurancePolicy(
            Name = '279413',
            Policy_Id__c = '279412',
            NameInsuredId = testAccount.Id
        );
        insert testPolicy;
       
        InsurancePolicyTransaction testTransaction = new InsurancePolicyTransaction(
            Name = '120443 - Renewal',
            Insight_Id__c = '120424',
            PolicyId__c = '279412',
            InsurancePolicyId = testPolicy.Id
        );
        insert testTransaction;
         Test.startTest();
        
        PolicyTransactionHandler.getPolicyTransaction('120423');
        Test.stopTest();
    }
    
    
}