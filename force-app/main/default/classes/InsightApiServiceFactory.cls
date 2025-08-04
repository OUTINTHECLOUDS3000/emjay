public class InsightApiServiceFactory { 
    public static IApiInsightService getApiService(String apiName,string recordId) {
        if (apiName.contains('Client')) {
            return new ClientInsightApiService(apiName,recordId);  
        }  
        if (apiName.contains('Contact')) {
            return new ContactInsightApiService(apiName,recordId);  
        }
        if (apiName.contains('Claim')) {// Cases
            return new CaseInsightApiService(apiName,recordId);  
        }
        if (apiName.contains('Invoice')) {// Cases
            return new InvoiceInsightApiService(apiName,recordId);  
        }
        if (apiName.contains('Transaction')) {// Cases
            return new PolicyTransactionInsightApiService(apiName,recordId);  
        }
        else {
            throw new IllegalArgumentException('Unknown API: ' + apiName);
        }
    }
}