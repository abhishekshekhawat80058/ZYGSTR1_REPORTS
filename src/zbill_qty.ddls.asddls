@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sum of billing quantity'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZBILL_QTY as select from I_BillingDocumentItem as a
{
    key a.BillingDocument ,
        a.BillingDocumentItem,
        a.Product,
//    '' as BillingQuantityUnit ,
        a.TaxCode ,
        a.BillingQuantityUnit,
//        sum(cast(a.BillingQuantity as abap.dec( 20, 3 ) ) ) as BillingQuantity 
            cast(a.BillingQuantity as abap.dec( 20, 3 ) )  as BillingQuantity 
} group by
 a.BillingDocument,
 a.TaxCode,
    a.BillingQuantity,
    a.BillingQuantityUnit,
    a.BillingDocumentItem,
    a.Product 
// a.BillingQuantityUnit  
 