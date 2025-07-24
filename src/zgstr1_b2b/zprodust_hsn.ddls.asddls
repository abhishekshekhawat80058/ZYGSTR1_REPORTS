@AbapCatalog.sqlViewName: 'ZPRODUCT_HSNCODE'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'PRODUCT HSN CODE'
define view ZPRODUST_HSN as select distinct from I_ProductPlantBasic as a 
left outer join I_BillingDocumentItem as b on ( b.Plant = a.Plant )

{
    key a.Product ,
    key b.Plant,
     max (a.ConsumptionTaxCtrlCode) as ConsumptionTaxCtrlCode
     
}

 group by
  a.Product ,
a.ConsumptionTaxCtrlCode,
b.Plant


