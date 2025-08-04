public class InsightReferenceDataCustomMetadataHelper {
        /**
         * Inserts a new record into the custom metadata type API_Configurations__mdt.
         */
        public static void insertCustomMetadataRecord(Map<String, String> apiResponse) {
            // Create a new instance of Metadata.CustomMetadata
            Metadata.DeployContainer deployContainer = new Metadata.DeployContainer();
            for(string key : apiResponse.keySet()){
                
            
                Map<String, Object> responseMap = (Map<String, Object>) JSON.deserializeUntyped(apiResponse.get(key));

        // Extract the 'Results' node
        List<Object> resultsList = (List<Object>) responseMap.get('Results');

        // Iterate through the results and process each record
        for (Object result : resultsList) {
            Map<String, Object> resultMap = (Map<String, Object>) result;

            // Example: Access fields in the result map
            Integer id = (Integer) resultMap.get('Id');
            String name = (String) resultMap.get('Name');
            Metadata.CustomMetadata customMetadataRecord = new Metadata.CustomMetadata();
            
            // Set the full name (CustomMetadataType.DeveloperName)
            string fullNAme =  key+ '_'+name.replaceAll('[^a-zA-Z0-9]', '');
            fullName = fullName.length() > 38 ? fullName.substring(0,38):fullName;
            customMetadataRecord.fullName = 'Insight_Reference_Master_Data.' + fullName;
            string masterLabel = key+ ' '+name;
            masterLabel = masterLabel.length() > 38 ? masterLabel.substring(0,38):masterLabel;
            customMetadataRecord.label = masterLabel;

             // Set the Endpoint_URL__c field value
             Metadata.CustomMetadataValue FieldAPIName = new Metadata.CustomMetadataValue();
             FieldAPIName.field = 'Field_API_Name__c'; // API name of the field
             FieldAPIName.value = key;

            // Set the Endpoint_URL__c field value
            Metadata.CustomMetadataValue FieldValueId = new Metadata.CustomMetadataValue();
            FieldValueId.field = 'Field_Value_Id__c'; // API name of the field
            FieldValueId.value = id;
    
            // Set the Description__c field value
            Metadata.CustomMetadataValue FieldValueText = new Metadata.CustomMetadataValue();
            FieldValueText.field = 'Field_Value_Text__c'; // API name of the field
            FieldValueText.value = name;
    
            // Add the field values to the custom metadata record
            customMetadataRecord.values.add(FieldValueId);
            customMetadataRecord.values.add(FieldValueText);
            customMetadataRecord.values.add(FieldAPIName); 

            system.debug('Metadata record Name'+ customMetadataRecord.fullName);
            system.debug('Metadata record ID'+ id);
            system.debug('Metadata record Value'+ Name);
          
          
            deployContainer.addMetadata(customMetadataRecord);
        }
    }
          
            try {
                // Enqueue the deployment
                CreateMdtUtils callback = new CreateMdtUtils();
                Id asyncRequestId = Metadata.Operations.enqueueDeployment(deployContainer, Null);
                System.debug('Custom Metadata Deployment Queued. Async Request ID: ' + asyncRequestId);
            } catch (Exception e) {
                System.debug('Error occurred while creating custom metadata record: ' + e.getMessage());
            }
        }
    }