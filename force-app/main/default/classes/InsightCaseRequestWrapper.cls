public class InsightCaseRequestWrapper {
	public cls_Claim Claim;
	public class cls_Claim {
		public Integer Id;	//0
		public Integer ParentId;	//7394
		public boolean IsOpen;
		public Integer StatusId;	//1
		public String StatusName;	//Open
		public String LossDate;	//2017-08-23
		public String ReportedDate;	//2017-06-13
		public String InsurerClaimsRef;	//MVCLM1234
		public Double Excess;	//1000
		public Double EstimateOfLossAmount;	//200000
		public Double PaidAmount;	//0
		public String SubjectOfLoss;	//
		public String ResultOfLoss;	//
		public String CauseOfLoss;	//
		public String InsurerNotes;	//Head on crash
		public String ReviewDate;	//2017-10-23
		public String ReviewAction;	//Follow up on claim progress
		public Integer PolicyTransactionId;	//19589
		public Integer SubjectId;	//2
		public String Description;	//Motor Accident - Head on crash
		public String SitRegNo;	//
		public String InsurerContact;	//Bill Brown
		public String InsurerPhone;	//02 9999 87654
		public String InsurerEmail;	//emailfortestingpurposes@steadfasttech.com.au
		public String AssessorContact;	//Andy Assessor
		public String AssessorPhone;	//0417 454 565
		public String AssessorEmail;	//andy@assesorsinc.com.au
		public boolean IsInsurerAdvised;
		public String InsurerAdvisedDate;	//2019-06-14
		public boolean IsAssessorApproved;
		public boolean IsAssessorAdvised;
		public boolean IsAssessorRequired;
		public String ClientId;
		public String InsurerId;
		public String CreatedWho;
		public String UpdatedWho;
	}

	public static InsightCaseRequestWrapper parse(String json){
		return (InsightCaseRequestWrapper) System.JSON.deserialize(json, InsightCaseRequestWrapper.class);
	}
}