@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'zgstr1 b2b cds2'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zgstr1_b2b_cds2 as select distinct from ZGSTR1B2B_CDS1 as A
left outer join ZPRODUST_HSN as pb on ( pb.Product = A.product )
left outer join I_ProductDescription as pd on ( pd.Product = A.product and pd.Language = 'E' )
inner join ZBILL_QTY as bi on ( bi.BillingDocument = A.BillingDocument and bi.TaxCode = A.TaxCode )
left outer join I_Product as p on ( p.Product = A.product )
{
 key A.CompanyCode, //1
  A.AccountingDocument,//2
  A.FiscalYear,//3
  A.FiscalPeriod,//4
  A.DocumentDate,//5
  A.PostingDate,//6
  cast('' as abap.char(10)) as GLAccount,//7
  A.AccountingDocumentType,//8
  A.DocumentReferenceID,//9
  A.TransactionCurrency,//10
  A.TaxItemAcctgDocItemRef,//11
  A.ProfitCenter,//12
  A.BusinessPlace,//13
  case when A.BillingDocument is not initial then A.BillingDocument else A.DocumentReferenceID end as BillingDocument,//14
  A.BillingDocumentType,//15
  A.ewbnumber,   //16
  A.Irn,       //17
  A.Customer,   //18
  A.CustomerName,   //19
  A.TaxNumber3 as customer_gst,// 20
  A.product,//21
  pd.ProductDescription,//22
  pb.ConsumptionTaxCtrlCode as hsn_code,//23
  A.IsReversal,//24
  A.IsReversed,//25
  A.Region,//26
  A.TaxCode,//27
 bi.BillingQuantityUnit  as BillingQuantityUnit ,//28
 //@Semantics.quantity.unitOfMeasure: 'BillingQuantityUnit'
// @Semantics.quantity.unitOfMeasure: 'BaseUnit'
  case when cast( A.Quantity as abap.dec(15,2)) > 0 then cast( A.Quantity as abap.dec(15,2))
   else  cast( bi.BillingQuantity as abap.dec(15,2)) end as Quantity,//29
  case when A.Quantity > 0 then A.BaseUnit else p.BaseUnit end as BaseUnit,//30
  A.JOCG_RATE,//31
  A.JOSG_RATE,//32
  A.JOIG_RATE,//33
  
 // A.TaxAmountInCoCodeCrcy,
@Semantics.amount.currencyCode: 'TransactionCurrency'
cast(A.TaxAmountInCoCodeCrcy as abap.curr(20, 2)) as TaxAmountInCoCodeCrcy,//34
  @Semantics.amount.currencyCode: 'TransactionCurrency'
  A.AmountInCompanyCodeCurrency,//35
   @Semantics.amount.currencyCode: 'TransactionCurrency'
//  sum(A.JOCG_AMT) as JOCG_AMT,
   A.JOCG_AMT as JOCG_AMT,//36
   @Semantics.amount.currencyCode: 'TransactionCurrency'
//  sum(A.JOSG_AMT) as JOSG_AMT,
  A.JOSG_AMT as JOSG_AMT,//37
   @Semantics.amount.currencyCode: 'TransactionCurrency'
//  sum(A.JOIG_AMT) as JOIG_AMT,
   A.JOIG_AMT as JOIG_AMT,//38
   @Semantics.amount.currencyCode: 'TransactionCurrency'
  cast(0 as abap.curr(20,2)) as INVOICE_AMT,//39
  case when A.REPORT = 'EXPORT' then A.REPORT when A.TaxNumber3 = '' then cast('B2CS' as abap.char(6)) else A.REPORT end as REPORT   //  40
}
where A.TaxItemAcctgDocItemRef <> '000000'
and  A.AccountingDocument is not initial
group by 
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
  A.BillingDocument,
  A.BillingDocumentType,
  A.ewbnumber,
  A.Irn,
  A.BaseUnit,
  A.Customer,
  A.CustomerName,
  A.TaxNumber3,
  A.product,
  pd.ProductDescription,
  pb.ConsumptionTaxCtrlCode,
  A.IsReversal,
  A.IsReversed,
  A.Region,
  A.TaxCode,
  A.Quantity,
  p.BaseUnit,
  bi.BillingQuantity,
  A.JOCG_RATE,
  A.JOSG_RATE,
  A.JOIG_RATE,
  A.TaxAmountInCoCodeCrcy,
  A.AmountInCompanyCodeCurrency,
  A.REPORT,
  A.JOCG_AMT,
  A.JOSG_AMT,
  A.JOIG_AMT,
    bi.BillingQuantityUnit

union all

select distinct from ZGSTR1_B2B_SERVICE_CDS_NEW_LOG as A
{
 key A.CompanyCode,//1
  '' as AccountingDocument,//2
 // '' as FiscalYear,
  cast( '' as abap.numc(4) ) as FiscalYear,//3
 cast( '' as abap.numc(3) ) as FiscalPeriod,//4
  A.DocumentDate,//5
  '' as PostingDate,//6
  cast('' as abap.char(10)) as GLAccount,//7
  '' as AccountingDocumentType,//8
  '' as DocumentReferenceID,//9
  A.TransactionCurrency,//10
  cast( '' as abap.numc(6) ) as TaxItemAcctgDocItemRef,//11
  '' as ProfitCenter,//12
  '' as BusinessPlace,//13
  A.BillingDocument,//14
  '' as BillingDocumentType,//15
 cast( '' as abap.numc(12) ) as ewbnumber,//16
  '' as Irn,//17
  A.CUSTOMER_CODE as Customer,//18
  A.CustomerName,//19
  A.CustomerGSTIN as customer_gst,//20
  A.ProductCode as product,//21
  A.ProductDescription,//22
  A.ConsumptionTaxCtrlCode as hsn_code,//23
  '' as IsReversal,//24
  '' as IsReversed,//25
  '' as Region,//26
  '' as TaxCode,//27
  A.BillingQuantityUnit,//28
  case when cast( A.Quantity as abap.dec(15,2))> 0 then cast( A.Quantity as abap.dec(15,2))
   else 0 end as Quantity,
  A.BillingQuantityUnit as BaseUnit,
//  cast( 0 as abap.dec( 10, 2 ) ) as Quantity  ,



//case when A.Quantity > 0 then A.Quantity else 0 end as Qty,
//a.Quantity,
//  A.BillingQuantityUnit as BaseUnit,
  A.JOCG_Rate,
  A.JOSG_RATE,
  A.JOIG_RATE,
//  cast(0 as abap.curr(20,2)) as TaxAmountInCoCodeCrcy,
  A.TaxableValue as TaxAmountInCoCodeCrcy,
  A.TaxableValue as AmountInCompanyCodeCurrency,
  A.JOCG_AMOUNT as JOCG_AMT,
  A.JOSG_AMOUNT as JOSG_AMT,
  A.JOIG_AMOUNT as JOIG_AMT, 
  A.InvoiceValue as INVOICE_AMT,
 
  cast('B2B' as abap.char(6)) as REPORT
}
 
group by 
  A.CompanyCode,
  A.DocumentDate,
  A.TransactionCurrency,
  A.CUSTOMER_CODE,
  A.CustomerName,
  A.CustomerGSTIN,
  A.ProductCode,
  A.ProductDescription,
  A.ConsumptionTaxCtrlCode,
  A.Quantity,
  A.BillingQuantityUnit,
  A.TaxableValue,
  A.BillingDocumentItem,
  A.InvoiceValue,
  A.AddressID,
  A.pos,
  A.JOCG_Rate,
  A.JOCG_AMOUNT,
  A.JOSG_RATE,
  A.JOSG_AMOUNT,
  A.JOIG_RATE,
  A.JOIG_AMOUNT,
  A.CompanyCode,
    A.BillingDocument
