@IsTest
public class LoggerUtilityTest {
    @IsTest
    private static void logException_test() {
        Test.startTest();
        LoggerUtility logger = LoggerUtility.getLogger();
        logger.addErrorLog(new DmlException());
        logger.saveLogs(); 
        Test.stopTest();
    }   
     @IsTest
    private static void logException_test1() {
        Test.startTest();
        LoggerUtility logger = LoggerUtility.getLogger();
        logger.addErrorLog(new DmlException(),'Get_Customers','{"example":"test"}');
        logger.saveLogs(); 
        Test.stopTest();
    }   
    @IsTest
    private static void addAPILog_test() {
        Test.startTest();
        LoggerUtility logger = LoggerUtility.getLogger();
        HttpRequest request = new HttpRequest();
        request.setBody('{"example":"test"}');
        logger.addAPILog('Test API', request, false, new HttpResponse());
        logger.saveLogs();
        Test.stopTest();
    }
    
    @IsTest
    private static void addAPILogWithPayload_test() {
        Test.startTest();
        LoggerUtility logger = LoggerUtility.getLogger();
        logger.addAPILogWithPayload('Test API', '{"example":"test"}');
        logger.saveLogs();
        Test.stopTest();
    }
}