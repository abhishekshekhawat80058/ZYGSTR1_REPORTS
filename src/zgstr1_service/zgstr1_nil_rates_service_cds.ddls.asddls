@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZGSTR1_NIL_RATED_SERVICE'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZGSTR1_NIL_RATES_SERVICE_CDS 
as select from ZGSTR1_NIL_RATED_CDS2 as A
left outer join I_BillingDocumentBasic as b on(
      b.BillingDocument = A.BillingDocument
    )
{
  key  A.CompanyCode,
  key  A.AccountingDocument,
  key  A.FiscalYear,
  key  A.REPORT                                                         as REPORT,
  key  A.DocumentDate,
  key  A.PostingDate,
  key  A.AccountingDocumentType,
  key  A.TaxItemAcctgDocItemRef ,                                      // as doc_item,
  key  A.BillingDocument,
  key  A.BillingDocumentType,
  key  A.Customer,
  key  A.CustomerName,
  key  A.customer_gst,
  key  A.Product,
  key  A.ProductDescription,
  key  A.hsn_code,
  key  A.GLAccount,
  key  A.ProfitCenter,
  key  A.Region,
  key  A.DocumentReferenceID,
  key  A.TaxCode,
  key  A.BusinessPlace,
  key  A.ewbnumber,
  key  A.Irn,
  key  A.BaseUnit,

  key  (A.Quantity)                                                     as Quantity,
  key  A.TransactionCurrency,

       @Semantics.amount.currencyCode: 'TransactionCurrency'
       //    key  (TaxAmountInCoCodeCrcy * (-1 ) ) as table_value,

//       case when A.REPORT  = 'NILRAT'
//       case when  A.BillingDocumentType = 'INV'
//       then ( A.AmountInCompanyCodeCurrency  )
//       else ( A.AmountInCompanyCodeCurrency * (-1 )  ) end as table_value,
        ( A.AmountInCompanyCodeCurrency ) as  table_value ,
//       else ( A.TaxAmountInCoCodeCrcy * (-1 )  ) end                    as table_value,

       @Semantics.amount.currencyCode: 'TransactionCurrency'
       (A.JOCG_AMT * (-1 ) )                                            as JOCG_AMT,

       ( A.JOCG_RATE)                                                   as JOCG_RATE,


       @Semantics.amount.currencyCode: 'TransactionCurrency'
       (A.JOSG_AMT * (-1 ) )                                            as JOSG_AMT,

       (A.JOSG_RATE)                                                    as JOSG_RATE,

       @Semantics.amount.currencyCode: 'TransactionCurrency'
       (A.JOIG_AMT * (-1 ) )                                            as JOIG_AMT,

       (A.JOIG_RATE)                                                    as JOIG_RATE,

       @Semantics.amount.currencyCode: 'TransactionCurrency'
       //       ( INVOICE_AMT * (-1 ) ) as INVOICE_AMT
//       case when  A.JOIG_AMT  is not null
//       then
//            (A.JOIG_AMT + A.AmountInCompanyCodeCurrency )  * (-1 )
//       else
//           (A.JOCG_AMT + A.JOSG_AMT + A.AmountInCompanyCodeCurrency )  * (-1 )  end as INVOICE_AMT,

//         ( A.AmountInCompanyCodeCurrency )   as INVOICE_AMT,
          A.INVOICE_AMT,
       //    IsReversal,
       //    IsReversed,
       //    AmountInCompanyCodeCurrency
       
       
       case when A.TaxItemAcctgDocItemRef = '000000' 
       then  '000001'  
//       else A.TaxItemAcctgDocItemRef end 
       else A.TaxItemAcctgDocItemRef 
       end as doc_item ,

       A.FiscalPeriod                                                   as ReturnPeriod,
//         concat(substring(A.PostingDate, 5, 2), substring(A.PostingDate, 1, 4)) as ReturnPeriod  , 
//       case  A.REPORT when 'NRTEXP'
         case A.REPORT when 'NILRAT' 
       //       then cast( '97' as abap.char(10) )
       //        else cast( '' as abap.char(10) ) end                            as PortCode,
       then
         case when b.YY1_PortofLoading_BDH = '01'
              then 'INPAV1'
              when b.YY1_PortofLoading_BDH = '02'
              then 'INNSA1' 
              when b.YY1_PortofLoading_BDH = '03'
              then 'INMUN1' 
              when b.YY1_PortofLoading_BDH = '04'
              then 'INBOM4' 
              when b.YY1_PortofLoading_BDH = '05'
              then 'INDEL4' 
              when b.YY1_PortofLoading_BDH = '06'
              then 'INJAI6' 
              when b.YY1_PortofLoading_BDH = '07'
              then 'INSNLB' 
               when b.YY1_PortofLoading_BDH = '08'
              then 'INPTPB' 
              else ''
              end 
        else ' '
        end                                                             as PortCode,
     
       cast('' as abap.char(10) )                                       as SourceIdentifier,
       cast('' as abap.char(10) )                                       as SourceFileName,
       cast('' as abap.char(10) )                                       as GLAccountCode,
       cast('' as abap.char(10) )                                       as Division,
       cast('' as abap.char(10) )                                       as SubDivision,
       cast('' as abap.char(10) )                                       as ProfitCentre1,
       cast('' as abap.char(10) )                                       as ProfitCentre2,
       cast('' as abap.char(10) )                                       as PlantCode,
       case when A.CompanyCode = '1000'
         then '08AAKCS5788C1ZX'
         when A.CompanyCode = '2000'
          then '08ABJCS8323B1ZD' 
          end as                                                        SupplierGSTIN,
//       cast('' as abap.char(10) )                                       as SupplierGSTIN,
       cast('' as abap.char(10) )                                       as CRDRPreGST,
       cast('' as abap.char(10) )                                       as UINorComposition,
       cast('' as abap.char(10) )                                       as OriginalCustomerGSTIN,
       cast('' as abap.char(10) )                                       as BillToState,
       cast('' as abap.char(10) )                                       as ShipToState,
       //    cast('' as abap.char(10) ) as PortCode,
       cast('' as abap.char(10) )                                       as ShippingBillNumber,
       cast('' as abap.char(10) )                                       as ShippingBillDate,
       cast('' as abap.char(10) )                                       as FOB,
       cast('' as abap.char(10) )                                       as ExportDuty,
       cast('' as abap.char(10) )                                       as CategoryOfProduct,
       cast('' as abap.char(10) )                                       as CessRateAdvalorem,
       cast('' as abap.char(10) )                                       as CessAmountAdvalorem,
       cast('' as abap.char(10) )                                       as CessRateSpecific,
       cast('' as abap.char(10) )                                       as CessAmountSpecific,
       cast('' as abap.char(10) )                                       as ReverseChargeFlag,
       cast('' as abap.char(10) )                                       as TCSFlag,
       cast('' as abap.char(10) )                                       as eComGSTIN,
       cast('' as abap.char(10) )                                       as ITCFlag,
       cast('' as abap.char(10) )                                       as ReasonForCreditDebitNote,
       cast('' as abap.char(10) )                                       as AccountingVoucherDate,
       cast('' as abap.char(10) )                                       as Userdefinedfield1,
       cast('' as abap.char(10) )                                       as Userdefinedfield2,
       cast('' as abap.char(10) )                                       as Userdefinedfield3,
       A.BillingDocumentItem                                            as BillingDocumentItem








}
