@IsTest
public class InsightPushEventListenerTest {
    @IsTest
    static void testInsightPushEventListenerPolicy() {
        // Create a test request
        RestRequest request = new RestRequest();
        request.requestURI = '/services/apexrest/api/webhooks/Insight/listner';
        request.httpMethod = 'POST';
        String json = '{'
        + '"EventCode": "UpdatePolicyTransaction",'
        + '"EventTimeStamp": "2025-01-17T16:25:02.0914767+11:00",'
        + '"LedgerName": "emjay",'
        + '"LedgerDisplayName": "Emjay Insurance Brokers",'
        + '"Client": {'
            + '"Id": 6735,'
            + '"Ref": "P2E",'
            + '"Name": "P2E Services Pty Ltd",'
            + '"TradingAs": "",'
            + '"ABN": "97628581779",'
            + '"AddressLine1": "Level 1 24 Hickson Road",'
            + '"AddressLine2": "",'
            + '"AddressLine3": "",'
            + '"State": 1,'
            + '"City": "",'
            + '"Postcode": "2000",'
            + '"CountryId": 14,'
            + '"CountryName": "AUSTRALIA",'
            + '"AccountTypeId": 2,'
            + '"AccountTypeName": "Credit",'
            + '"ClassificationId": 4,'
            + '"ClassificationName": "Commercial",'
            + '"BranchId": 4,'
            + '"BranchName": "Mario Cuenca",'
            + '"SalesTeamId": 47,'
            + '"SalesTeamName": "Montana Pinto",'
            + '"ServiceTeamId": 53,'
            + '"ServiceTeamName": "Montana Pinto",'
            + '"NatureOfBusiness": "",'
            + '"IndustryId": 14,'
            + '"IndustryName": "Information Technology",'
            + '"RecordPermissionsGroupId": 2,'
            + '"CreatedWho": "asupple",'
            + '"CreatedWhen": "2018-10-26T16:05:00",'
            + '"UpdatedWhen": "2024-10-22T17:43:00",'
            + '"VulnerableClient": false,'
            + '"ComplianceTypeName": "Retail < 20 employees",'
            + '"Suburb": "Millers Point",'
            + '"Email": "john.bedwany@dbdept.com.au",'
            + '"Telephone": "02 9113 5400",'
            + '"Telephone2": "",'
            + '"Mobile": "TBA"'
        + '},'
        + '"Insurer": {'
            + '"Id": 6348,'
            + '"Ref": "CHUB",'
            + '"Name": "Chubb Insurance",'
            + '"TradingAs": "",'
            + '"ABN": "23 001 642 020",'
            + '"AddressLine1": "Level 29",'
            + '"AddressLine2": "2 Park Street",'
            + '"AddressLine3": "",'
            + '"State": 1,'
            + '"City": "",'
            + '"Postcode": "2000",'
            + '"CountryId": 14,'
            + '"CountryName": "AUSTRALIA",'
            + '"CreatedWho": "STFSAZURE\\namph.st76389",'
            + '"CreatedWhen": "2018-10-01T14:18:00",'
            + '"UpdatedWhen": "2020-08-25T10:41:00",'
            + '"Suburb": "SYDNEY",'
            + '"Email": "",'
            + '"Telephone": "9273 0100",'
            + '"Telephone2": "",'
            + '"Mobile": ""'
        + '},'
        + '"PolicyTransaction": {'
            + '"Id": 120423,'
            + '"Description": "Unposted",'
            + '"ClassOfRiskId": 26,'
            + '"ClassOfRiskName": "Business Insurance",'
            + '"FromDate": "2025-01-31",'
            + '"ToDate": "2026-01-31",'
            + '"EffectiveDate": "2025-01-31",'
            + '"InvoiceNumber": 0,'
            + '"PreviousPolicyTransactionId": 114748,'
            + '"PolicyNumber": "QSBP002787533",'
            + '"CoverNoteNumber": "",'
            + '"CreatedWho": "athomas",'
            + '"CreatedWhen": "2024-12-16T11:01:00",'
            + '"UpdatedWho": "athomas",'
            + '"UpdatedWhen": "2025-01-17T16:25:00",'
            + '"ClientId": 6735,'
            + '"InsurerId": 6348,'
            + '"PolicyId": 27941,'
            + '"TransactionTypeName": "Renewal Invitation",'
            + '"PolicyPeriodId": 65405,'
            + '"UIData": {'
                + '"IsPremiumValidationErrors": false,'
                + '"ReloadInterfacePremiums": false,'
                + '"IsSunriseClosingTransaction": false,'
                + '"ImportQuestion": false,'
                + '"SvuRecoveryQuestion": false,'
                + '"OriginalFromDate": "2025-01-31",'
                + '"OriginalToDate": "2026-01-31",'
                + '"OriginalEffectiveDate": "2025-01-31",'
                + '"InstalmentPlanNeedToBeCalculated": false,'
                + '"BrokerFeeAmountAdjustedValue": 0,'
                + '"IsScheduledPaymentsChanged": false,'
                + '"CommissionPercentage": 26.5,'
                + '"CommissionGSTPercentage": 10.012,'
                + '"OriginBasePremium": 529.16,'
                + '"OriginFSL": 48.53,'
                + '"OriginInsurerGST": 57.78,'
                + '"OriginStampDuty": 57.22'
            + '}'
        + '}'
    + '}';
        request.requestBody = Blob.valueOf(json);

        // Set the request and response objects in RestContext
        RestContext.request = request;
        RestContext.response = new RestResponse();

        // Call the method to test
        InsightPushEventListener.Listner();
        UpdatePolicyTransactionWrapper.parse(json);
        // Verify the response
        System.assertEquals(200, RestContext.response.statusCode);
        System.assertEquals('success', RestContext.response.responseBody.toString());
    }

    @IsTest
    static void testInsightPushEventListenerPolicyDelete() {
        // Create a test request
        RestRequest request = new RestRequest();
        request.requestURI = '/services/apexrest/api/webhooks/Insight/listner';
        request.httpMethod = 'POST';
        String json = '{'
        + '"EventCode": "DeletePolicyTransaction",'
        + '"EventTimeStamp": "2025-01-17T16:25:02.0914767+11:00",'
        + '"LedgerName": "emjay",'
        + '"LedgerDisplayName": "Emjay Insurance Brokers",'
        + '"Client": {'
            + '"Id": 6735,'
            + '"Ref": "P2E",'
            + '"Name": "P2E Services Pty Ltd",'
            + '"TradingAs": "",'
            + '"ABN": "97628581779",'
            + '"AddressLine1": "Level 1 24 Hickson Road",'
            + '"AddressLine2": "",'
            + '"AddressLine3": "",'
            + '"State": 1,'
            + '"City": "",'
            + '"Postcode": "2000",'
            + '"CountryId": 14,'
            + '"CountryName": "AUSTRALIA",'
            + '"AccountTypeId": 2,'
            + '"AccountTypeName": "Credit",'
            + '"ClassificationId": 4,'
            + '"ClassificationName": "Commercial",'
            + '"BranchId": 4,'
            + '"BranchName": "Mario Cuenca",'
            + '"SalesTeamId": 47,'
            + '"SalesTeamName": "Montana Pinto",'
            + '"ServiceTeamId": 53,'
            + '"ServiceTeamName": "Montana Pinto",'
            + '"NatureOfBusiness": "",'
            + '"IndustryId": 14,'
            + '"IndustryName": "Information Technology",'
            + '"RecordPermissionsGroupId": 2,'
            + '"CreatedWho": "asupple",'
            + '"CreatedWhen": "2018-10-26T16:05:00",'
            + '"UpdatedWhen": "2024-10-22T17:43:00",'
            + '"VulnerableClient": false,'
            + '"ComplianceTypeName": "Retail < 20 employees",'
            + '"Suburb": "Millers Point",'
            + '"Email": "john.bedwany@dbdept.com.au",'
            + '"Telephone": "02 9113 5400",'
            + '"Telephone2": "",'
            + '"Mobile": "TBA"'
        + '},'
        + '"Insurer": {'
            + '"Id": 6348,'
            + '"Ref": "CHUB",'
            + '"Name": "Chubb Insurance",'
            + '"TradingAs": "",'
            + '"ABN": "23 001 642 020",'
            + '"AddressLine1": "Level 29",'
            + '"AddressLine2": "2 Park Street",'
            + '"AddressLine3": "",'
            + '"State": 1,'
            + '"City": "",'
            + '"Postcode": "2000",'
            + '"CountryId": 14,'
            + '"CountryName": "AUSTRALIA",'
            + '"CreatedWho": "STFSAZURE\\namph.st76389",'
            + '"CreatedWhen": "2018-10-01T14:18:00",'
            + '"UpdatedWhen": "2020-08-25T10:41:00",'
            + '"Suburb": "SYDNEY",'
            + '"Email": "",'
            + '"Telephone": "9273 0100",'
            + '"Telephone2": "",'
            + '"Mobile": ""'
        + '},'
        + '"PolicyTransaction": {'
            + '"Id": 120423,'
            + '"Description": "Unposted",'
            + '"ClassOfRiskId": 26,'
            + '"ClassOfRiskName": "Business Insurance",'
            + '"FromDate": "2025-01-31",'
            + '"ToDate": "2026-01-31",'
            + '"EffectiveDate": "2025-01-31",'
            + '"InvoiceNumber": 0,'
            + '"PreviousPolicyTransactionId": 114748,'
            + '"PolicyNumber": "QSBP002787533",'
            + '"CoverNoteNumber": "",'
            + '"CreatedWho": "athomas",'
            + '"CreatedWhen": "2024-12-16T11:01:00",'
            + '"UpdatedWho": "athomas",'
            + '"UpdatedWhen": "2025-01-17T16:25:00",'
            + '"ClientId": 6735,'
            + '"InsurerId": 6348,'
            + '"PolicyId": 27941,'
            + '"TransactionTypeName": "Renewal Invitation",'
            + '"PolicyPeriodId": 65405,'
            + '"UIData": {'
                + '"IsPremiumValidationErrors": false,'
                + '"ReloadInterfacePremiums": false,'
                + '"IsSunriseClosingTransaction": false,'
                + '"ImportQuestion": false,'
                + '"SvuRecoveryQuestion": false,'
                + '"OriginalFromDate": "2025-01-31",'
                + '"OriginalToDate": "2026-01-31",'
                + '"OriginalEffectiveDate": "2025-01-31",'
                + '"InstalmentPlanNeedToBeCalculated": false,'
                + '"BrokerFeeAmountAdjustedValue": 0,'
                + '"IsScheduledPaymentsChanged": false,'
                + '"CommissionPercentage": 26.5,'
                + '"CommissionGSTPercentage": 10.012,'
                + '"OriginBasePremium": 529.16,'
                + '"OriginFSL": 48.53,'
                + '"OriginInsurerGST": 57.78,'
                + '"OriginStampDuty": 57.22'
            + '}'
        + '}'
    + '}';
        request.requestBody = Blob.valueOf(json);

        // Set the request and response objects in RestContext
        RestContext.request = request;
        RestContext.response = new RestResponse();

        // Call the method to test
        InsightPushEventListener.Listner();
        UpdatePolicyTransactionWrapper.parse(json);
        // Verify the response
        System.assertEquals(200, RestContext.response.statusCode);
        System.assertEquals('success', RestContext.response.responseBody.toString());
    }

    @IsTest
    static void testInsightPushEventListenerClaim() {
        // Create a test request
        RestRequest request = new RestRequest();
        request.requestURI = '/services/apexrest/api/webhooks/Insight/listner';
        request.httpMethod = 'POST';
        String json = '{'
        + '"EventCode": "CreateClaim",'+
        ' \"Claim\": {'+
        '     \"Id\": 0,'+
        '     \"PolicyId\": 7394,'+
        '     \"IsOpen\": true,'+
        '     \"StatusId\": 1,'+
        '     \"StatusName\": \"Open\",'+
        '     \"LossDate\": \"2017-08-23\",'+
        '     \"ReportedDate\": \"2017-06-13\",'+
        '     \"InsurerClaimsRef\": \"MVCLM1234\",'+
        '     \"Excess\": 1000,'+
        '     \"EstimateOfLossAmount\": 200000,'+
        '     \"PaidAmount\": 0,'+
        '     \"SubjectOfLoss\": \"\",'+
        '     \"ResultOfLoss\": \"\"'+
        ' },'+
        ' \"PolicyTransaction\": {'+
        '  \"Id\": 0,'+
        '     \"PolicyId\": 7394'+
        ' }'+
        '}';
        request.requestBody = Blob.valueOf(json);

        // Set the request and response objects in RestContext
        RestContext.request = request;
        RestContext.response = new RestResponse();

        // Call the method to test
        InsightPushEventListener.Listner();
       
        // Verify the response
        System.assertEquals(200, RestContext.response.statusCode);
        System.assertEquals('success', RestContext.response.responseBody.toString());
    }

    @IsTest
    static void testInsightPushEventListenerClaimDelete() {
        // Create a test request
        RestRequest request = new RestRequest();
        request.requestURI = '/services/apexrest/api/webhooks/Insight/listner';
        request.httpMethod = 'POST';
        String json = '{'
        + '"EventCode": "DeleteClaim",'+
        ' \"Claim\": {'+
        '     \"Id\": 0,'+
        '     \"PolicyId\": 7394,'+
        '     \"IsOpen\": true,'+
        '     \"StatusId\": 1,'+
        '     \"StatusName\": \"Open\",'+
        '     \"LossDate\": \"2017-08-23\",'+
        '     \"ReportedDate\": \"2017-06-13\",'+
        '     \"InsurerClaimsRef\": \"MVCLM1234\",'+
        '     \"Excess\": 1000,'+
        '     \"EstimateOfLossAmount\": 200000,'+
        '     \"PaidAmount\": 0,'+
        '     \"SubjectOfLoss\": \"\",'+
        '     \"ResultOfLoss\": \"\"'+
        ' },'+
        ' \"PolicyTransaction\": {'+
        '  \"Id\": 0,'+
        '     \"PolicyId\": 7394'+
        ' }'+
        '}';
        request.requestBody = Blob.valueOf(json);

        // Set the request and response objects in RestContext
        RestContext.request = request;
        RestContext.response = new RestResponse();

        // Call the method to test
        InsightPushEventListener.Listner();
       
        // Verify the response
        System.assertEquals(200, RestContext.response.statusCode);
        System.assertEquals('success', RestContext.response.responseBody.toString());
    }
}