public class InsightAPIController {
    
    static LoggerUtility logger;

    public static string ExecuteInsightAPI(string service, string recordId)
    {
        logger = LoggerUtility.getLogger();
        try
        {	
           
            IApiInsightService apiService = InsightApiServiceFactory.getApiService(service,recordId);
		    // Perform the API call 
		    return apiService.invokeAPI();
        }
        catch(Exception ex)
        {
            logger.addErrorLog(ex,service,ex.getMessage());
        }
        finally
        {
            logger.relatedRecordId = recordId;
            if (!service.startsWith('Get') && !Test.isRunningTest()) {
                logger.saveLogs();
            }
        }
        return null;
    }
}