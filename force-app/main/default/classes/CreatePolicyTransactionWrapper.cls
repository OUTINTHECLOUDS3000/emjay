public class CreatePolicyTransactionWrapper {
	public String EventCode;	//CreatePolicyTransaction
	public String EventTimeStamp;	//2025-01-17T16:16:47.895028+11:00
	public String LedgerName;	//emjay
	public String LedgerDisplayName;	//Emjay Insurance Brokers
	public cls_Client Client;
	public cls_Insurer Insurer;
	public cls_PolicyTransaction PolicyTransaction;
	public class cls_Client {
		public Integer Id;	//3107
		public String Ref;	//FLAVOURTEC
		public String Name;	//Flavourtech Pty Ltd
		public String TradingAs;	//
		public String ABN;	//
		public String AddressLine1;	//Po Box 413
		public String AddressLine2;	//
		public String AddressLine3;	//
		public Integer State;	//1
		public String City;	//
		public String Postcode;	//2680
		public Integer CountryId;	//14
		public String CountryName;	//AUSTRALIA
		public Integer AccountTypeId;	//2
		public String AccountTypeName;	//Credit
		public Integer ClassificationId;	//4
		public String ClassificationName;	//Commercial
		public Integer BranchId;	//2
		public String BranchName;	//Emjay Insurance Brokers Pty Ltd
		public Integer SalesTeamId;	//47
		public String SalesTeamName;	//Montana Pinto
		public Integer ServiceTeamId;	//53
		public String ServiceTeamName;	//Montana Pinto
		public String NatureOfBusiness;	//
		public Integer IndustryId;	//4
		public String IndustryName;	//Manufacturing
		public Integer RecordPermissionsGroupId;	//2
		public String CreatedWho;	//dbo
		public String CreatedWhen;	//2018-10-01T14:18:00
		public String UpdatedWhen;	//2024-10-22T17:38:00
		public boolean VulnerableClient;
		public Integer AuthorisedRep1Id;	//1023
		public String ComplianceTypeName;	//Wholesale
		public String Suburb;	//GRIFFITH
		public String Email;	//LSkaliotis@flavourtech.com
		public String Telephone;	//02 6969 1111
		public String Telephone2;	//
		public String Mobile;	//0438237821
	}
	public class cls_Insurer {
		public Integer Id;	//6348
		public String Ref;	//CHUB
		public String Name;	//Chubb Insurance
		public String TradingAs;	//
		public String ABN;	//23 001 642 020
		public String AddressLine1;	//Level 29
		public String AddressLine2;	//2 Park Street
		public String AddressLine3;	//
		public Integer State;	//1
		public String City;	//
		public String Postcode;	//2000
		public Integer CountryId;	//14
		public String CountryName;	//AUSTRALIA
		public String CreatedWho;	//STFSAZURE\namph.st76389
		public String CreatedWhen;	//2018-10-01T14:18:00
		public String UpdatedWhen;	//2020-08-25T10:41:00
		public String Suburb;	//SYDNEY
		public String Email;	//
		public String Telephone;	//9273 0100
		public String Telephone2;	//
		public String Mobile;	//
	}
	public class cls_PolicyTransaction {
		public Integer Id;	//120653
		public String Description;	//Unposted
		public Integer ClassOfRiskId;	//138
		public String ClassOfRiskName;	//Management Liability
		public String FromDate;	//2025-02-28
		public String ToDate;	//2026-02-28
		public String EffectiveDate;	//2025-02-28
		public Integer InvoiceNumber;	//0
		public Integer PreviousPolicyTransactionId;	//115624
		public String PolicyNumber;	//93299812
		public String CoverNoteNumber;	//
		public String CreatedWho;	//athomas
		public String CreatedWhen;	//2025-01-17T16:17:00
		public String UpdatedWho;	//athomas
		public String UpdatedWhen;	//2025-01-17T16:17:00
		public Integer ClientId;	//3107
		public Integer InsurerId;	//6348
		public Integer PolicyId;	//13359
		public String TransactionTypeName;	//Renewal
		public Integer PolicyPeriodId;	//65646
		public cls_UIData UIData;
	}
	public class cls_UIData {
		public cls_Coinsurers[] Coinsurers;
		public cls_ScheduledPayments[] ScheduledPayments;
		public boolean IsPremiumValidationErrors;
		public boolean ReloadInterfacePremiums;
		public cls_ArCommGstManualValues ArCommGstManualValues;
		public cls_ArFeeGstManualValues1 ArFeeGstManualValues1;
		public cls_ArFeeGstManualValues2 ArFeeGstManualValues2;
		public cls_ArFeeGstManualValues3 ArFeeGstManualValues3;
		public boolean IsSunriseClosingTransaction;
		public boolean ImportQuestion;
		public boolean SvuRecoveryQuestion;
		public String OriginalFromDate;	//2025-02-28
		public String OriginalToDate;	//2026-02-28
		public String OriginalEffectiveDate;	//2025-02-28
		public boolean InstalmentPlanNeedToBeCalculated;
		public Integer BrokerFeeAmountAdjustedValue;	//0
		public boolean AccessPolicySummary;
		public boolean AreAllScheduledPaymentsPaid;
		public boolean IsScheduledPaymentsChanged;
		public boolean IsInsurerOrClassOfRiskChanged;
		public boolean SendSOAToClient;
		public boolean UserSelectedAnotherMessage;
		public boolean CreatedByUserWithScheduledPaymentPermission;
	}
	public class cls_Coinsurers {
	}
	public class cls_ScheduledPayments {
	}
	public class cls_ArCommGstManualValues {
	}
	public class cls_ArFeeGstManualValues1 {
	}
	public class cls_ArFeeGstManualValues2 {
	}
	public class cls_ArFeeGstManualValues3 {
	}
    // Parse method to convert the JSON into object
	public static CreatePolicyTransactionWrapper parse(String json){
		return (CreatePolicyTransactionWrapper) System.JSON.deserialize(json, CreatePolicyTransactionWrapper.class);
	}
}