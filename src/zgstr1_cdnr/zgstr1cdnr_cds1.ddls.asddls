@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'cds 1 for gstr1 b2b'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}


define view entity ZGSTR1CDNR_CDS1
  as select from    I_JournalEntry            as b
    left outer join I_OperationalAcctgDocItem as a    on(
         b.AccountingDocument = a.AccountingDocument
         and b.CompanyCode    = a.CompanyCode
         and b.FiscalYear     = a.FiscalYear
       )
//          left outer join ZAMOUNITCOCODE as ac    on(
//         ac.AccountingDocument = a.AccountingDocument
//         and ac.CompanyCode    = a.CompanyCode
//         and ac.FiscalYear     = a.FiscalYear
////         and ac.TaxCode        = a.TaxCode
//         and ac.TaxItemAcctgDocItemRef     = a.TaxItemAcctgDocItemRef
//       )
    left outer join I_OperationalAcctgDocItem as D    on(
         D.AccountingDocument       = b.AccountingDocument
         and D.CompanyCode          = b.CompanyCode
         and D.FiscalYear           = b.FiscalYear
         and D.FinancialAccountType = 'D'
       )
    left outer join I_Customer                as d2   on(
        d2.Customer = D.Customer
      )
    left outer join I_OperationalAcctgDocItem as B1   on(
        B1.AccountingDocument  = b.AccountingDocument
        and B1.CompanyCode     = b.CompanyCode
        and B1.FiscalYear      = b.FiscalYear
        and B1.BillingDocument is not initial
      )
    left outer join I_BillingDocument         as BI   on(
        BI.BillingDocument     = B1.BillingDocument
        and BI.BillingDocument is not initial
      )
    left outer join ZGSTR1_B2B_CDS3           as BI2  on(
       BI2.BillingDocument = BI.BillingDocument
     )

    left outer join ZGSTR1_PLANT              as BI3  on(
       BI3.BillingDocument = BI.BillingDocument
     )
    left outer join yj1ig_ewaybill            as EW   on(
        EW.docno     = B1.BillingDocument
        and EW.gjahr = b.FiscalYear
        and EW.bukrs = b.CompanyCode
      )
    left outer join Y1IG_INVREFNUM_DD         as IR   on(
        IR.Docno       = B1.BillingDocument
        and IR.DocYear = b.FiscalYear
        and IR.Bukrs   = b.CompanyCode
      )
  left outer join yj1ig_ewaybill            as EW2   on(
        EW2.docno     = b.AccountingDocument
        and EW2.gjahr = b.FiscalYear
        and EW2.bukrs = b.CompanyCode
      )
    left outer join Y1IG_INVREFNUM_DD      as IR2   on(
        IR2.Docno       = b.AccountingDocument
        and IR2.DocYear = b.FiscalYear
        and IR2.Bukrs   = b.CompanyCode
      )


    left outer join I_OperationalAcctgDocItem as CGST on(
      CGST.AccountingDocument         = a.AccountingDocument
      and CGST.CompanyCode            = b.CompanyCode // PR.AccountingDocumentItem = a.AccountingDocumentItem  and
      and CGST.FiscalYear             = a.FiscalYear
      and CGST.TaxItemAcctgDocItemRef = a.TaxItemAcctgDocItemRef
      and CGST.TaxCode                = a.TaxCode
      and CGST.GLAccount              = '0001621020'
    )
    left outer join I_OperationalAcctgDocItem as SGST on(
      SGST.AccountingDocument         = a.AccountingDocument
      and SGST.CompanyCode            = b.CompanyCode // PR.AccountingDocumentItem = a.AccountingDocumentItem  and
      and SGST.FiscalYear             = a.FiscalYear
      and SGST.TaxItemAcctgDocItemRef = a.TaxItemAcctgDocItemRef
      and SGST.TaxCode                = a.TaxCode
      and SGST.GLAccount              = '0001621021'
    )
    left outer join I_OperationalAcctgDocItem as IGST on(
      IGST.AccountingDocument         = a.AccountingDocument
      and IGST.CompanyCode            = b.CompanyCode // PR.AccountingDocumentItem = a.AccountingDocumentItem  and
      and IGST.FiscalYear             = a.FiscalYear
      and IGST.TaxCode                = a.TaxCode
      and IGST.TaxItemAcctgDocItemRef = a.TaxItemAcctgDocItemRef
      and IGST.GLAccount              = '0001621022'
    )
    left outer join Zytax_code2               as T    on(
         T.taxcode = a.TaxCode
       )


{
  a.CompanyCode,
  a.AccountingDocument,
  a.FiscalYear,
  b.FiscalPeriod,
  a.DocumentDate,
  a.PostingDate,
  a.GLAccount,
  a.TaxCode,
  b.DocumentReferenceID,
  a.AccountingDocumentType,

  a.TransactionCurrency,
  a.TaxItemAcctgDocItemRef,
  ''                                                        as ProfitCenter,
  //  a.ProfitCenter,
  a.BusinessPlace,
  BI.BillingDocument,
  BI.BillingDocumentType,
//  EW.ewbnumber,
//  IR.Irn,

  case when  EW.ewbnumber is not initial
       then EW.ewbnumber 
       else EW2.ewbnumber end as ewbnumber ,
  case when  IR.Irn is not initial
       then IR.Irn 
       else IR2.Irn end as Irn ,
       
  D.Customer,
  d2.CustomerName,
  d2.TaxNumber3,
  case when a.Product is not initial
   then  a.Product
   else BI2.Product end                                     as product,
  case when a.Plant is not initial
   then  a.Plant
   else BI3.PLANT end                                       as Plant,
//  a.Plant,
  b.IsReversal,
  b.IsReversed,
  d2.Region ,

  case CGST.GLAccount when '0001621020' then  T.gstrate end as JOCG_RATE,
  case SGST.GLAccount when '0001621021' then  T.gstrate end as JOSG_RATE,
  case IGST.GLAccount when '0001621022' then  T.gstrate end as JOIG_RATE,
  T.gstrate,


  @Semantics.amount.currencyCode: 'TransactionCurrency'
  (CGST.AmountInCompanyCodeCurrency  )                      as JOCG_AMT,
  @Semantics.amount.currencyCode: 'TransactionCurrency'
  (SGST.AmountInCompanyCodeCurrency  )                      as JOSG_AMT,
  @Semantics.amount.currencyCode: 'TransactionCurrency'
  (IGST.AmountInCompanyCodeCurrency  )                      as JOIG_AMT,

  a.BaseUnit,

//  @Semantics.quantity.unitOfMeasure: 'BaseUnit'
  cast( (a.Quantity ) as abap.dec( 20, 2 ) )                as Quantity,


  //b.TransactionCurrency,
  @Semantics.amount.currencyCode: 'TransactionCurrency'
  case when  CGST.TaxBaseAmountInCoCodeCrcy  is not null
  then
   (CGST.TaxBaseAmountInCoCodeCrcy )
  else
  (IGST.TaxBaseAmountInCoCodeCrcy ) end                     as TaxAmountInCoCodeCrcy,
  
  
//  case when  CGST.AmountInCompanyCodeCurrency  is not null
//  then
//   (CGST.AmountInCompanyCodeCurrency )
//  else
//   (IGST.AmountInCompanyCodeCurrency ) end      as AmountInCompanyCodeCurrency,

  @Semantics.amount.currencyCode: 'TransactionCurrency'
   sum(a.AmountInCompanyCodeCurrency )            as AmountInCompanyCodeCurrency,
//    ac.AmountInCompanyCodeCurrency as AmountInCompanyCodeCurrency ,
   
   
   
//  @Semantics.amount.currencyCode: 'TransactionCurrency'
//  (IGST.TaxBaseAmountInCoCodeCrcy)                          as AmountInCompanyCodeCurrency,
  //   (a.AmountInCompanyCodeCurrency)            as AmountInCompanyCodeCurrency,


  ''                                                        as ProductDescription,
  ''                                                        as hsn_code,


  case  a.TransactionCurrency when 'INR'
  then  cast( 'CDNR' as abap.char(10) )
   else   cast( 'EXPWP' as abap.char(10) )
   end                                                      as REPORT


}
where
  (
    (
           b.AccountingDocumentType         =  'DG'
      or   b.AccountingDocumentType         =  'DN'
      or   b.AccountingDocumentType         =  'DV'
    )
    or(
           b.AccountingDocumentType         =  'RV'
      and(
           BI.BillingDocumentType           =  'G2'
        or BI.BillingDocumentType           =  'L2'
        or BI.BillingDocumentType           =  'CBRE'
      )
    )
  )

  and      b.IsReversal                     <> 'X'
  and      b.IsReversed                     <> 'X'
  and      a.ProfitLossAccountType          =  'X'
  and      a.GLAccount                      <> '0003201014'
  and(
    (
           CGST.AmountInCompanyCodeCurrency is not null
      and  SGST.AmountInCompanyCodeCurrency is not null
    )
    or(
           IGST.AmountInCompanyCodeCurrency is not null
    )
  )


group by
  a.CompanyCode,
  a.AccountingDocument,
  a.FiscalYear,
  b.FiscalPeriod,
  a.DocumentDate,
  a.PostingDate,
  b.DocumentReferenceID,
  a.GLAccount,
  a.GLAccount,
  // GST.GLAccount ,
  //  a.ProfitCenter,
  a.TaxItemAcctgDocItemRef,
  //a.TaxItemAcctgDocItemRef ,
  //P.ProfitCenter ,
  BI.BillingDocument,
  BI.BillingDocumentType,
  BI2.Product,
  //  BI2.Plant ,
  a.BusinessPlace,
  EW.ewbnumber,
  IR.Irn,
  EW2.ewbnumber,
  IR2.Irn,
  a.BaseUnit,
  a.TaxCode,
  T.gstrate,
  a.TransactionCurrency,
  D.Customer,
  d2.CustomerName,
  d2.TaxNumber3,
  a.Product,
  a.Plant,
  BI3.PLANT ,
  b.IsReversal,
  b.IsReversed,
  d2.Region ,
  a.AccountingDocumentType,

  CGST.GLAccount,
  SGST.GLAccount,
  IGST.GLAccount,
  BI.DistributionChannel,
  CGST.AmountInCompanyCodeCurrency,
  SGST.AmountInCompanyCodeCurrency,
  IGST.AmountInCompanyCodeCurrency,
  a.Quantity,
  CGST.TaxBaseAmountInCoCodeCrcy,
  IGST.TaxBaseAmountInCoCodeCrcy 
//   ac.AmountInCompanyCodeCurrency

//GST.AmountInCompanyCodeCurrency

//CGST.AmountInCompanyCodeCurrency,
//SGST.AmountInCompanyCodeCurrency,
//IGST.AmountInCompanyCodeCurrency
//CT.gstrate,
//ST.gstrate,
//IT.gstrate
