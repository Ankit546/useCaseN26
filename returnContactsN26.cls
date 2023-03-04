@RestResource(urlMapping='/Contact/*')
global with sharing class returnContactsN26 {
    @HttpGet
    global static Contact getContactRecord() {
		 RestRequest request = RestContext.request;
        // grab the caseId from the end of the URL
        String caseUUID = request.requestURI.substring(
          request.requestURI.lastIndexOf('/')+1);
        Contact result =  [SELECT Name, Id, UUID__c, Product__r.Name, 
                           Product__r.ATM_Fee_in_Other_Currencies__c, 
                           product__r.Card_Replacement_Cost__c, 
                           product__r.Cost_Per_Calendar_Month__c, 
                           Product__r.Country__c
                        	FROM Contact
                        	WHERE UUID__c = :caseUUID];
        return result;  //THB6677TY
        //working
    }
}