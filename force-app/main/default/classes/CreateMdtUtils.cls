global with sharing class CreateMdtUtils implements Metadata.DeployCallback {
    public static void handleResult(Metadata.DeployResult result, Metadata.DeployCallbackContext context) {
          if (result.status == Metadata.DeployStatus.Succeeded) {
              System.debug('Custom metadata record created successfully.');
          } else {
              System.debug('Failed to create custom metadata record. Errors: ' + result.errorMessage);
          }
        }
    }