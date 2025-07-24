@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'zgstr1 b2b cds1'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZGSTR1_CDNR_CDS2 as select from ZGSTR1CDNR_CDS1 as A
//left outer join I_ProductPlantBasic as pb on ( pb.Product = A.product and pb.Plant = A.Plant )
 left outer join ZPRODUST_HSN as PB on ( PB.Product = A.product  )
left outer join I_ProductDescription as pd on ( pd.Product = A.product and pd.Language = 'E' )
left outer join ZBILL_QTY as bi on ( bi.BillingDocument = A.BillingDocument  and bi.TaxCode = A.TaxCode  )
left outer join I_Product  as p on ( p.Product = A.product  )

{
A.CompanyCode,
A.AccountingDocument,
A.FiscalYear,
A.FiscalPeriod,
A.DocumentDate,
A.PostingDate,
A.GLAccount,
A.AccountingDocumentType,
A.DocumentReferenceID,
A.TransactionCurrency,
A.TaxItemAcctgDocItemRef,
A.ProfitCenter,
A.BusinessPlace,

case when A.BillingDocument is not initial  
 then A.BillingDocument
 else A.DocumentReferenceID end as BillingDocument ,

//A.BillingDocument,
A.BillingDocumentType,
A.ewbnumber,
A.Irn,
A.Customer,
A.CustomerName,
A.TaxNumber3 as customer_gst ,
A.product,
//A.ProductDescription,
//A.hsn_code,
pd.ProductDescription,
PB.ConsumptionTaxCtrlCode as hsn_code ,
A.IsReversal,
A.IsReversed,
A.Region ,
A.TaxCode,
//A.Quantity,
case when A.Quantity > 0
 then A.Quantity 
 else 
 bi.BillingQuantity 
 end as Quantity ,
 
 case when  A.Quantity > 0
 then A.BaseUnit 
 else 
 p.BaseUnit 
 end as BaseUnit ,

//A.BaseUnit ,
 
A.JOCG_RATE,
A.JOSG_RATE,
A.JOIG_RATE,
@Semantics.amount.currencyCode: 'TransactionCurrency'
//A.TaxAmountInCoCodeCrcy,
case when A.REPORT  = 'EXPWP'
then A.AmountInCompanyCodeCurrency
else  A.TaxAmountInCoCodeCrcy   end as TaxAmountInCoCodeCrcy ,

@Semantics.amount.currencyCode: 'TransactionCurrency'
A.AmountInCompanyCodeCurrency,
@Semantics.amount.currencyCode: 'TransactionCurrency'
A.JOCG_AMT,
@Semantics.amount.currencyCode: 'TransactionCurrency'
A.JOSG_AMT,
@Semantics.amount.currencyCode: 'TransactionCurrency'
A.JOIG_AMT ,

  @Semantics.amount.currencyCode: 'TransactionCurrency'
  case when  A.JOIG_AMT  is not null
  then
   (A.JOIG_AMT + A.AmountInCompanyCodeCurrency )
  else
   (A.JOCG_AMT  + A.AmountInCompanyCodeCurrency ) end      as INVOICE_AMT,

//A.REPORT

case
  when  A.REPORT = 'EXPWP' then A.REPORT
   when A.TaxNumber3 = ''   then cast('B2CS'     as abap.char(10) )
   else A.REPORT   end as REPORT

//case
//  when  A.REPORT = 'NIL RATED' then A.REPORT
//   when A.TaxNumber3 = ''   then cast('NIL RATED'     as abap.char(10) )
//   else A.REPORT   end as REPORT
   

//'' as conditiontype ,
//'' as PLANT 


}

