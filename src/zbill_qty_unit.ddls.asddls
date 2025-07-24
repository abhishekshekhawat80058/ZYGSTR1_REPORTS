@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sum of billing quantity'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZBILL_QTY_unit as select from I_BillingDocumentItem as a
{
    key a.BillingDocument ,
     (a.BillingQuantityUnit) as BillingQuantityUnit 
        
} group by
 a.BillingDocument,
 a.BillingQuantityUnit   
