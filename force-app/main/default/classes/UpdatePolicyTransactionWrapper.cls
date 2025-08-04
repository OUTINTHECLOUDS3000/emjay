public class UpdatePolicyTransactionWrapper {

	public String EventCode;	//UpdatePolicyTransaction
	public String EventTimeStamp;	//2025-01-17T16:25:02.0914767+11:00
	public String LedgerName;	//emjay
	public String LedgerDisplayName;	//Emjay Insurance Brokers
	public cls_Client Client;
	public cls_Insurer Insurer;
	public cls_PolicyTransaction PolicyTransaction; 
	public class cls_Client {
		public Integer Id;	//6735
		public String Ref;	//P2E
		public String Name;	//P2E Services Pty Ltd
		public String TradingAs;	//
		public String ABN;	//97628581779
		public String AddressLine1;	//Level 1 24 Hickson Road
		public String AddressLine2;	//
		public String AddressLine3;	//
		public Integer State;	//1
		public String City;	//
		public String Postcode;	//2000
		public Integer CountryId;	//14
		public String CountryName;	//AUSTRALIA
		public Integer AccountTypeId;	//2
		public String AccountTypeName;	//Credit
		public Integer ClassificationId;	//4
		public String ClassificationName;	//Commercial
		public Integer BranchId;	//4
		public String BranchName;	//Mario Cuenca
		public Integer SalesTeamId;	//47
		public String SalesTeamName;	//Montana Pinto
		public Integer ServiceTeamId;	//53
		public String ServiceTeamName;	//Montana Pinto
		public String NatureOfBusiness;	//
		public Integer IndustryId;	//14
		public String IndustryName;	//Information Technology
		public Integer RecordPermissionsGroupId;	//2
		public String CreatedWho;	//asupple
		public String CreatedWhen;	//2018-10-26T16:05:00
		public String UpdatedWhen;	//2024-10-22T17:43:00
		public boolean VulnerableClient;
        public Integer AuthorisedRep1Id;
		public String ComplianceTypeName;	//Retail < 20 employees
		public String Suburb;	//Millers Point
		public String Email;	//john.bedwany@dbdept.com.au
		public String Telephone;	//02 9113 5400
		public String Telephone2;	//
		public String Mobile;	//TBA
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
		public Integer Id;	//120423
		public String Description;	//Unposted
		public Integer ClassOfRiskId;	//26
		public String ClassOfRiskName;	//Business Insurance
		public String FromDate;	//2025-01-31
		public String ToDate;	//2026-01-31
		public String EffectiveDate;	//2025-01-31
		public Integer InvoiceNumber;	//0
		public Integer PreviousPolicyTransactionId;	//114748
		public String PolicyNumber;	//QSBP002787533
		public String CoverNoteNumber;	//
		public String CreatedWho;	//athomas
		public String CreatedWhen;	//2024-12-16T11:01:00
		public String UpdatedWho;	//athomas
		public String UpdatedWhen;	//2025-01-17T16:25:00
		public Integer ClientId;	//6735
		public Integer InsurerId;	//6348
		public Integer PolicyId;	//27941
		public String TransactionTypeName;	//Renewal Invitation
		public Integer PolicyPeriodId;	//65405
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
		public String OriginalFromDate;	//2025-01-31
		public String OriginalToDate;	//2026-01-31
		public String OriginalEffectiveDate;	//2025-01-31
		public boolean InstalmentPlanNeedToBeCalculated;
		public String BrokerFeeAmountAdjustedValue;	//0
		public boolean AccessPolicySummary;
		public boolean AreAllScheduledPaymentsPaid;
		public boolean IsScheduledPaymentsChanged;
		public boolean IsInsurerOrClassOfRiskChanged;
		public boolean SendSOAToClient;
		public boolean CreatedByUserWithScheduledPaymentPermission;
		public String SelectedOpportunityId;	//
		public boolean UserSelectedAnotherSCTPMessage;
		public boolean AutoSelectedAnotherSCTPMessage;
		public boolean SVURequiresPayByInstalmentQuotes;
		public boolean UserSelectedAnotherMessage;
		public boolean ScheduleEdited;
		public boolean isTransactionPremiumsCalculated;
		public boolean BrokerFeeAmountIsCalculated;
		public boolean BrokerFeeGSTAmountIsCalculated;
		public String FSLPercentage;	//9.17
		public String InsurerGSTPercentage;	//10
		public String StampDutyPercentage;	//9
		public String AnnualFSLPercentage;	//7.35
		public String AnnualInsurerGSTPercentage;	//10
		public String AnnualStampDutyPercentage;	//9
		public String IsBrokerFeeAllocation1Overridden;
		public String IsBrokerFeeAllocation2Overridden;
		public String IsBrokerFeeAllocation3Overridden;
		public String CommissionPercentage;	//26.5
		public String CommissionGSTPercentage;	//10.012
		public String OtherCommissionAmountIsCalculated;
		public String OtherCommissionPercentage;	//0
		public String FBCPercentage;	//0
		public boolean IsInvoicePremiumDirty;
		public boolean IsStateAllocationsOpened;
		public boolean IsOneOffPremiumCharge;
		public String OriginBasePremium;	//529.16
		public String OriginFSL;	//48.53
		public String OriginInsurerGST;	//57.78
		public String OriginStampDuty;	//57.22
		public String OriginUnderwriterFee;	//0
		public String OriginUnderwriterFeeGST;	//0
		public String OriginBrokerFee;	//325
		public String OriginBrokerFeeGST;	//32.5
		public String OriginCommission;	//140.23
		public String OriginCommissionGST;	//14.04
		public String OriginOtherCommission;	//0
		public String OriginOtherCommissionGST;	//0
		public String OriginOtherLevy;	//0
		public String OriginOtherPremium;	//0
		public String OriginAnnualBasePremium;	//1685.4
		public String OriginAnnualFSL;	//123.84
		public String OriginAnnualInsurerGST;	//180.92
		public String OriginAnnualStampDuty;	//179.12
		public String OriginAnnualUnderwriterFee;	//0
		public String OriginAnnualUnderwriterFeeGST;	//0
		public String OriginAnnualBrokerFee;	//0
		public String OriginAnnualBrokerFeeGST;	//0
		public String OriginAnnualCommission;	//446.64
		public String OriginAnnualCommissionGST;	//44.71
		public String OriginAnnualOtherCommission;	//0
		public String OriginAnnualOtherCommissionGST;	//0
		public String OriginAnnualOtherLevy;	//0
		public String OriginAnnualOtherPremium;	//0
		public boolean OriginAddedOrUpdated;
		public cls_ArFeeManualValues ArFeeManualValues;
		public cls_ArFeeGstManualValues ArFeeGstManualValues;
		public cls_ArFeeManualValues1 ArFeeManualValues1;
		public cls_ArFeeManualValues2 ArFeeManualValues2;
		public cls_ArFeeManualValues3 ArFeeManualValues3;
		public cls_ArCommManualValues ArCommManualValues;
		public boolean IsArPremiumRecalculationRequired;
        public string BrokerFeeDefaultsSetting;
        public string BrokerFeeDefaultsSetting2;
        public string BrokerFeeDefaultsSetting3;
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
	public class cls_ArFeeManualValues {
	}
	public class cls_ArFeeGstManualValues {
	}
	public class cls_ArFeeManualValues1 {
	}
	public class cls_ArFeeManualValues2 {
	}
	public class cls_ArFeeManualValues3 {
	}
	public class cls_ArCommManualValues {
	}

	//Add method to parse original policy data
	public static UpdatePolicyTransactionWrapper parse(String json){
		return (UpdatePolicyTransactionWrapper) System.JSON.deserialize(json, UpdatePolicyTransactionWrapper.class);
	}
}