public without sharing class LoggerUtility {
   
    private static LoggerUtility logger;
    public string relatedRecordId;
    private LoggerUtility()
    {
    }
    public static LoggerUtility getLogger()
    {
        if(logger == null)
        {
            logger =  new LoggerUtility();
        }
        return logger;
    }

    List<Attachment> lstAttchment = new List<Attachment>();
    static List<loggerWrapper> logs = new List<loggerWrapper>();
    public void addAPILog(string apiName, HttpRequest request, boolean isCalloutExpection, Object responseMessage)
    {
        loggerWrapper log = new loggerWrapper();
        log.ServiceName = apiName;
        log.logType = 'API Log';
        log.serviceRequest = request;
        if(isCalloutExpection)
        {
            log.status = '0 - Callout Exception';
            log.message = (String)responseMessage;
        }
        else {
            HttpResponse response = (HttpResponse)responseMessage;
            log.status = string.valueOf(response.getStatusCode()) + ' - ' + response.getStatus();
            log.message = response.getBody();
            log.serviceResponse = response;
        }
        logs.add(log);
    }
    
    public void addAPILogWithPayload(string apiName, string body)
    {
        loggerWrapper log = new loggerWrapper();
        log.ServiceName = apiName;
        log.logType = 'API Log';
        log.message = body;
        log.requestBody = body;
        logs.add(log);
    }

    public void addErrorLog(Exception ex)
    {
        loggerWrapper log = new loggerWrapper();
        log.logType = 'Transaction Log';
        log.status = ex.getTypeName();
        log.message = ex.getmessage();
        log.lineNumber = String.ValueOf(ex.getLineNumber());
        log.stackTrace = ex.getStackTraceString();
        logs.add(log);
    }
    
    public void addErrorLog(Exception ex, string serviceName, string payload)
    {
        loggerWrapper log = new loggerWrapper();
        log.logType = 'Transaction Log';
        log.status = ex.getTypeName();
        log.message = ex.getmessage();
        log.lineNumber = String.ValueOf(ex.getLineNumber());
        log.stackTrace = ex.getStackTraceString();
        log.ServiceName = serviceName;
        log.requestBody = payload;
        logs.add(log);
    }

    // public void addErrorLog(Exception ex, string serviceName, RestRequest request )
    // {
    //     loggerWrapper log = new loggerWrapper();
    //     log.logType = 'Transaction Log';
    //     log.status = ex.getTypeName();
    //     log.message = ex.getmessage();
    //     log.lineNumber = String.ValueOf(ex.getLineNumber());
    //     log.stackTrace = ex.getStackTraceString();
    //     log.ServiceName = serviceName;
    //     log.serviceRequest = request;
    //     logs.add(log);
    // }


    public void saveLogs()
    {
        for(loggerWrapper log : logs)
        {
            API_Logs__c logObject = new API_Logs__c();
            logObject.Service_Name__c = log.serviceName;
            logObject.log_Type__c = log.logType;
            logObject.Status__c = log.status;
            logObject.Error_Message__c = log.message;
            logObject.related_Record_Id__c = relatedRecordId;
            logObject.Line_Number__c = log.lineNumber;
            logObject.StackTrace__c = log.stackTrace;
            logObject.Request_Body__c = log.requestBody;
            system.debug('log.requestBody');
            system.debug(log.requestBody);
            database.insert(logObject);
            
            if(log.serviceResponse != null)
                AddResponse(log.serviceResponse, logObject.Id);
            if(log.serviceRequest != null)
            AddRequest(log.serviceRequest, logObject.Id);

            if(String.isNotBlank(log.requestBody)){
                addBody(log.requestBody,logObject.Id);
            }else{
                if(log.logType != 'Transaction Log')
                    addBody(log.message,logObject.Id);
            }

              
        }
        if(lstAttchment.size() > 0)
        {
            database.insert(lstAttchment,false);
        }
    }

    private void AddResponse(HttpResponse response, string logId)
    {
        String responseHeader = '';
        for(string headerKey: response.getHeaderKeys())
        {
            responseHeader += headerKey+ '=' + response.getHeader(headerKey) + '\n';
        }

        if(responseHeader!='')
        {
            Attachment a = new Attachment();
            a.Name = 'Response Header.txt';
            a.ContentType = 'text/plain';
            a.parentId = logId;
            a.Body = Blob.ValueOf(responseHeader);
            lstAttchment.add(a);
        }

        if(response.getBody()!='')
        {
            Attachment a = new Attachment();
            a.Name = 'Response Body.txt';
            a.ContentType = 'text/plain';
            a.parentId = logId;
            a.Body = Blob.ValueOf(response.getBody());
            lstAttchment.add(a);
        }
        
    }

    private void AddRequest(HttpRequest request, string logId)
    {
        if(request.getBody()!='')
        {
            Attachment a = new Attachment();
            a.Name = 'Request Body.txt';
            a.ContentType = 'text/plain';
            a.parentId = logId;
            a.Body = Blob.ValueOf(request.getBody());
            lstAttchment.add(a);
        }
    }

    private void AddBody(string body, string logId)
    {
        if(body!='')
        {
            Attachment a = new Attachment();
            a.Name = 'Request Body.txt';
            a.ContentType = 'text/plain';
            a.parentId = logId;
            a.Body = Blob.ValueOf(body);
            lstAttchment.add(a);
        }
    }

    public class loggerWrapper 
    {
        public string recordId {get;set;}
        public string status{get;set;}
        public string message{get;set;}
        public string requestBody{get;set;}
        public HttpResponse serviceResponse{get;set;}
        public HttpRequest serviceRequest{get;set;}
        public string serviceName{get;set;}
        public string logType{get;set;}
        public string lineNumber{get;set;}
        public string stackTrace{get;set;}
    }
}