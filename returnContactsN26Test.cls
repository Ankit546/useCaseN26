@isTest
public class returnContactsN26Test {
	@isTest
    public static void getContactRecordTest(){
        String UUIDCon = createTestConRecord(); //getting the UUID from helper method
        System.debug('UUIDCon## '+UUIDCon);
        //create a fake restRequest and set the attributes manually to test the class
        RestRequest request = new RestRequest();
        request.requestUri =
            'https://juno2-dev-ed.my.salesforce.com/services/apexrest/Cases/'
            + UUIDCon;
        request.httpMethod = 'GET';
        RestContext.request = request;
        // Testing the method
        Contact con = returnContactsN26.getContactRecord();
        
        // Asserting to check the results
        System.assertNotEquals(con, null);
        System.assertEquals('QWER1234', con.UUID__c); 
    	System.assertEquals(con.Product__r.Name, 'Test Card');
    }
    //create contact record helper method
    static String createTestConRecord() {
        // Create test record
        Product2 pr = new Product2(
        	Name='Test Card',
            ATM_Fee_in_Other_Currencies__c = 4.2,
            Card_Replacement_Cost__c = 1.2,
            Cost_Per_Calendar_Month__c = 6,
            Country__c = 'FR');
        insert pr;
        Contact conTest = new Contact(
            FirstName='Testing',
            LastName = 'con1',
            product__c=pr.Id,
            UUID__c='QWER1234');
        insert conTest;
        System.debug('conTestId## '+conTest.Id);
        return conTest.UUID__c;
    }          
}