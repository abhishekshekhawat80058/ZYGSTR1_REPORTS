@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'I_OPERATIONAL CDS'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_OPERATIONAL_CDS_FOR_UNION
  as select from I_OperationalAcctgDocItem as A
    inner join   I_OperationalAcctgDocItem as B on(
      B.AccountingDocument  = A.AccountingDocument
      and B.CompanyCode     = A.CompanyCode
      and B.FiscalYear      = A.FiscalYear
      and B.BillingDocument is not initial
    )

{
  key  A.AccountingDocument,
       A.CompanyCode,
       A.FiscalYear,
       A.AccountingDocumentType,
       B.BillingDocument





}
where
      A.TaxItemAcctgDocItemRef = '000000'
  and A.AccountingDocumentItemType   = 'T'

group by
  A.AccountingDocument,
  A.CompanyCode,
  A.FiscalYear,
  A.AccountingDocumentType,
  B.BillingDocument
