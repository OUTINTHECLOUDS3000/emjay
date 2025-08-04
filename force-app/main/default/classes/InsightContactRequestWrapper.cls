public  class InsightContactRequestWrapper {
    public cls_Contact Contact;
	public class cls_Contact {
		public Integer Id;	//9
		public String CreatedWho;	//BOASysAdmin
		public String CreatedWhen;	//2021-03-01T03:20:19.8843148Z
		public String RowVersion;	//0000000000002424
		public Integer ParentId;	//133
		public boolean IsPrimary;
		public String Addressee;	//CreateContactDOCAPI
		public String Salutation;	//Salutation
		public String JobTitle;	//Job Title
		public String Telephone;	//0909090909
		public String Telephone2;	//0909090909
		public String Mobile;	//0909090909
		public String Fax;	//0909090909
		public String Email;	//EditContactDOCAPI@gmail.com
		public String BirthDate;	//1990-02-28
		public Integer ContactTypeId;	//5
		public boolean IsClient;
		public boolean IsInsurer;
		public boolean IsAuthorisedRep;
	}

	// Parse method to convert the JSON into object
	public static InsightContactRequestWrapper parse(String json){
		return (InsightContactRequestWrapper) System.JSON.deserialize(json, InsightContactRequestWrapper.class);
	}
}