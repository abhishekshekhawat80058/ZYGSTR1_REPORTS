@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'I_OperationalAcctgDocItem'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZAMOUNITCOCODE as select from I_OperationalAcctgDocItem as a
{
    key a.AccountingDocument ,
    key a.CompanyCode ,
    key a.FiscalYear ,
    key a.TaxItemAcctgDocItemRef ,
        a.TransactionCurrency ,
//        a.TaxCode ,
        
@Semantics.amount.currencyCode: 'TransactionCurrency'
      sum(a.AmountInCompanyCodeCurrency ) as AmountInCompanyCodeCurrency
} where

        a.ProfitLossAccountType          =  'X'
  and   a.GLAccount                      <> '0003201014'
  
group by
a.AccountingDocument ,     
a.CompanyCode ,            
a.FiscalYear ,             
a.TaxItemAcctgDocItemRef,
a.TransactionCurrency
//a.TaxCode  
//a.AmountInCompanyCodeCurrency
