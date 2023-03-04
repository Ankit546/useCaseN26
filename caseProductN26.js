import { LightningElement, api, wire } from 'lwc';
import fetchProductsFromContacts from '@salesforce/apex/fetchProductsFromContactsToCase.fetchProductsFromContacts';

import fetchCustomerProducts from '@salesforce/apex/fetchProductsFromContactsToCase.fetchCustomerProducts';

const columns = [
    { label: 'Product Name', fieldName: 'Name' },
    { label: 'Product ATM Fee', fieldName: 'ATM_Fee_in_Other_Currencies__c' },
    { label: 'Country', fieldName: 'Country__c'},

    { label: 'Card Replacement Cost', fieldName: 'Card_Replacement_Cost__c' },
    { label: 'Cost Per Month', fieldName: 'Cost_Per_Calendar_Month__c' }
];

export default class CaseProductN26 extends LightningElement {

    @api recordId;
    columns = columns;

    @wire(fetchProductsFromContacts, {recordId : '$recordId'})
    contactsproducts;

    @wire(fetchCustomerProducts, {recordId : '$recordId'})
    customerproducts;

    connectedCallback(){
        console.log('##connectedCallback is called');
        console.log('recordId '+this.recordId);
        console.log('contactsproducts '+this.contactsproducts);
        console.log('customerproducts '+this.customerproducts);
        console.log('in ##connectedCallback');
    }

}