@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'IGST CDS'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZIGST_CDS as select from I_OperationalAcctgDocItem as a
{
    key a.CompanyCode ,
    key a.FiscalYear ,
    key a.AccountingDocument ,
    key a.TaxItemAcctgDocItemRef ,
        a.TaxCode ,
        a.TransactionCurrency ,
        @Semantics.amount.currencyCode: 'TransactionCurrency'
        sum(a.AmountInCompanyCodeCurrency) as igst
        
}
 where a.GLAccount = '0001621020'
 
  group by 
  a.CompanyCode ,          
  a.FiscalYear ,           
  a.AccountingDocument ,
  a.TaxItemAcctgDocItemRef ,
  a.TaxCode ,   
  a.TransactionCurrency 
