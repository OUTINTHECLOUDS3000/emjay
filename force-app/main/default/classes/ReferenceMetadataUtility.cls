public class ReferenceMetadataUtility {
    // Helper method to map picklist values to IDs (if IDs are predefined in the system)

    static Map<String, Map<String, Integer>> picklistToIdMap = new Map<String, Map<String, Integer>>();
    
    // back mapping from API to SF field
    static Map<String, Map<Integer, String>> APIToSFMap = new Map<String, Map<Integer, String>>();
    
    public static Integer mapPicklistToId(String field, String picklistValue) {
        
        if (picklistToIdMap.containsKey(field) && picklistToIdMap.get(field).containsKey(picklistValue)) {
            return picklistToIdMap.get(field).get(picklistValue);
        }
        return null;
    }
    
    // get values based on api value to insert into salesforce
    public static String getIdtoPicklistText(String field, Integer picklistValue) {
        
        if (APIToSFMap.containsKey(field) && APIToSFMap.get(field).containsKey(picklistValue)) {
            system.debug('APIToSFMap.get(field).get(picklistValue)'+APIToSFMap.get(field).get(picklistValue));
            return APIToSFMap.get(field).get(picklistValue);
        }
        return null;
    }

    public static void setCustomMetadataMap()
    {
        for(Insight_Reference_Master_Data__mdt field : [SELECT Field_Value_Id__c, Field_Value_Text__c,
        Field_API_Name__c,DeveloperName FROM 
                                                    Insight_Reference_Master_Data__mdt ]
                                                     )
       
        {
            if(!picklistToIdMap.containsKey(field.Field_API_Name__c))
            {
                picklistToIdMap.put(field.Field_API_Name__c, new Map<String, Integer>());
              
            }
            if(!APIToSFMap.containsKey(field.Field_API_Name__c))
            {
                APIToSFMap.put(field.Field_API_Name__c, new Map<Integer, String>()); 
              
            }
             
            picklistToIdMap.get(field.Field_API_Name__c).put(field.Field_Value_Text__c, Integer.ValueOf(field.Field_Value_Id__c));
            APIToSFMap.get(field.Field_API_Name__c).put(Integer.ValueOf(field.Field_Value_Id__c),field.Field_Value_Text__c);
        }
        }
    }