public with sharing class fetchProductsFromContactsToCase {
   
    @AuraEnabled(cacheable=true)
    public static List<Product2> fetchProductsFromContacts(String recordId) {
        List<Case> caseList = [SELECT Id, Contact.Product__r.Name, Contact.MailingCountry, Contact.Product__c, Contact.Id from Case WHERE Id = : recordId];
        Set<Id> conId = new Set<Id>();
        Set<Id> productIds = new Set<Id>();
        Set<String> countrySet = new Set<String>();
        for(Case cs : caseList){
            conId.add(cs.Contact.Id);
            productIds.add(cs.Contact.Product__c);
            countrySet.add(cs.Contact.MailingCountry);
        }
        List<Product2> prodList = [SELECT Id, Name, ATM_Fee_in_Other_Currencies__c, Card_Replacement_Cost__c, Cost_Per_Calendar_Month__c, Country__c FROM Product2 WHERE Country__c IN : countrySet];
        
        return prodList;
        //get the contact id from case or the country from the case's contact
    }

    @AuraEnabled(cacheable=true)
    public static List<Product2> fetchCustomerProducts(String recordId){
        try {
            List<Case> caseList = [SELECT Id, Contact.Product__c, Contact.MailingCountry FROM Case WHERE Id = : recordId];
            Set<Id> conId = new Set<Id>();
            Set<Id> productIds = new Set<Id>();

            for(Case ca : caseList){
                conId.add(ca.Contact.Id);
                productIds.add(ca.Contact.Product__c);

            }
            List<Product2> productList = [SELECT Id, Name, ATM_Fee_in_Other_Currencies__c, Card_Replacement_Cost__c, Cost_Per_Calendar_Month__c, Country__c FROM Product2 WHERE Id IN : productIds];

            return productList;

        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}