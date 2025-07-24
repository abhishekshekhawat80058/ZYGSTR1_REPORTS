@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZGSTR1_B2B_CDS3'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZGSTR1_B2B_CDS3
  as select distinct from I_BillingDocumentItem as A
{
//  key A.BillingDocument,
//      A.Product
 A.BillingDocument ,
// A.Plant ,
// A.Product ,
 max(A.Product) as Product

}
where
  A.Product is not initial
 group by 
 A.BillingDocument 
// A.Plant 
// A.Product 
 