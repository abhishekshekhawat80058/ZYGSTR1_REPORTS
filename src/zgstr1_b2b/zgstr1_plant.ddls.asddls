@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZGSTR1_B2B_CDS3'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZGSTR1_PLANT
  as select  from I_BillingDocumentItem as A
{
 A.BillingDocument ,
 max(A.Plant) as PLANT

}
where
  A.Product is not initial
 group by 
 A.BillingDocument 
