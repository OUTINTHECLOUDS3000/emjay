public with sharing class InsightClientRequestWrapper {
	public cls_Client Client;
	public class cls_Client {
		public String AuditCategory;	//Client
		public Integer AuditId;	//1630
		public Integer Id;	//1630
		public String CreatedWho;	//tonyt
		public String CreatedWhen;	//2014-07-04T02:36:00Z
		public String UpdatedWho;	//orlando
		public String UpdatedWhen;	//2018-03-28T01:21:00Z
		public String RowVersion;	//000000000009XXX
		public String Name;	//Efrain Jones
		public Integer Roles;	//10
		public Integer CurrentStatusId;	//0
		public boolean IsCurrent;
		public Integer SourceOfBusinessId;
		public Integer IndustryId;
		public Integer ClientTypeId;	//0;
		public boolean IsClient;
		public boolean HasPolicies;
		public String TradingAs;	//Montanar  Corp.
		public String Addressee;	//Tom Toskas
		public String Ref;	//Efrain J
		public String ABN;	//
		public String Contact;	//Moses Douglas
		public String JobTitle;	//
		public Integer AddressTypeId;	//1
		public String AddressLine1;	//Einstein Building
		public String AddressLine2;	//850 Green Clarendon Boulevard
		public String AddressLine3;	//
		public String City;	//
		public String Suburb;	//BANKSTOWN
		public Integer StateId;	//1
		public Integer AreaId;
		public String StateName;	//NSW
		public String Postcode;	//2200
		public Integer CountryId;	//14
		public String CountryName;	//AUSTRALIA
		public String OneLineAddress;	//Einstein Building, 850 Green Clarendon Boulevard, BANKSTOWN, NSW, 2200, AUSTRALIA
		public cls_Addresses[] Addresses;
		public String Telephone;	//(05) 5190 3084
		public String Telephone2;	//(02) 6964 5679
		public String Email;	//emailfortestingpurposes@steadfasttech.com.au
		public String Fax;	//
		public String Mobile;	//0427 372 274
		public String Web;	//
		public Double Balance;	//3868.47
		public String AccountName;	//
		public String BankName;	//
		public String BankBranchName;	//
		public String BSBNumber;	//
		public String ABARefNumber;	//
		public boolean ABAFileGen;
		public Integer ReferrerId;
		public boolean NABEnable;
		public boolean EmailPolicyDocuments;
		public Integer RecordPermissionsGroupId;	//4
		public Integer ProfileId;	//1444
		public String ProfileCreatedWho;	//tonyt
		public String ProfileCreatedWhen;	//2014-07-04T02:36:00Z
		public String ProfileUpdatedWho;	//orlando
		public String ProfileUpdatedWhen;	//2017-03-28T01:21:00Z
		public String ProfileRowVersion;	//000000000003565E
		public Integer BranchId;	//1
		public String BranchName;	//Sydney Branch
		public Integer BranchStateId;	//1
		public Integer SalesTeamId;	//2
		public String SalesTeamName;	//Sophia McCall
		public Integer ServiceTeamId;	//3
		public String ServiceTeamName;	//ZZ - Nina Summers
		public Integer AnnualTurnover;	//0
		public Integer LegalEntityTypeId;	//0
		public Integer AccountTypeId;	//1
		public String NatureOfBusiness;	//
		public String ACN;	//
		public String YearEstablished;	//
		public String SpouseName;	//
		public String Employer;	//
		public Integer ClassificationId;	//2
		public String ClassificationName;	//Bronze Client
		public Integer ComplianceTypeId;	//1
		public String ComplianceTypeName;	//Retail
		public Integer AuthorisedRep1Id;	//649
		public String AuthorisedRep1Name;	//Greg Berger
		public String AuthorisedRep1Ref;	//BERGERG
		public String AuthorisedRep1AutoComplete;	//Greg Berger [Ref: BERGERG]
		public Integer Category1Id;	//3
		public Integer Category3Id;	//3
		public String VulnerableClient;	//3
		public boolean IsNetAR;
		public boolean IsNetARRole;
		public Integer BranchclosingOption;	//0
		public String FSGDate;	//0001-01-01
		public String StandardIndustryCode;	//MUSHROOM AND VEGETABLE GROWING [1234]
	}
	public class cls_Addresses {
		public Integer Id;	//1600
		public String CreatedWho;	//tonyt
		public String CreatedWhen;	//2014-07-04T02:37:00Z
		public String UpdatedWho;	//orlando
		public String UpdatedWhen;	//2017-03-28T01:21:00Z
		public String RowVersion;	//0000000000000E08
		public Integer ParentId;	//1630
		public String ParentEntityName;	//Efrain Jones
		public String ParentEntityRef;	//Efrain J
		public boolean IsPrimary;
		public String OneLineAddress;	//Einstein Building, 850 Green Clarendon Boulevard, BANKSTOWN, NSW, 2200, AUSTRALIA
		public String AddressLine1;	//Einstein Building
		public String AddressLine2;	//850 Green Clarendon Boulevard
		public String AddressLine3;	//
		public String Suburb;	//BANKSTOWN
		public String Postcode;	//2200
		public String Telephone;	//(05) 5190 3084
		public String Telephone2;	//(02) 6964 5679
		public String Fax;	//
		public Integer StateId;	//1
		public String StateName;	//NSW
		public Integer AddressTypeId;	//1
		public String AddressTypeName;	//Street
		public String City;	//
		public String CountryName;	//AUSTRALIA
		public Integer CountryId;	//14
	}

	// Parse method to convert the JSON into object
	public static InsightClientRequestWrapper parse(String json){
		return (InsightClientRequestWrapper) System.JSON.deserialize(json, InsightClientRequestWrapper.class);
	}
}