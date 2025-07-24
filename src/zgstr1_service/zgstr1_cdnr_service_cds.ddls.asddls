@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZGSTR1_B2B_SERVICE_CDS'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZGSTR1_CDNR_SERVICE_CDS as select from ZGSTR1_CDNR_CDS2
{ 
    key CompanyCode,
    key AccountingDocument,
    key FiscalYear,
    key REPORT as REPORT ,
    DocumentDate,
    PostingDate,
    AccountingDocumentType,
    TaxItemAcctgDocItemRef as doc_item,
    BillingDocument,
    BillingDocumentType,
    Customer,
    CustomerName,
    customer_gst,
    product,
    ProductDescription,
    hsn_code,
    GLAccount,
    ProfitCenter,
    Region,
    DocumentReferenceID ,
    TaxCode,
    BusinessPlace,
    ewbnumber,
    Irn,
    BaseUnit,
    Quantity,
    TransactionCurrency,
    @Semantics.amount.currencyCode: 'TransactionCurrency'
    ( TaxAmountInCoCodeCrcy * (-1 ) )  as table_value,
    @Semantics.amount.currencyCode: 'TransactionCurrency'
    (JOCG_AMT * (-1 ) ) as JOCG_AMT ,
    JOCG_RATE,
    @Semantics.amount.currencyCode: 'TransactionCurrency'
    (JOSG_AMT * (-1 ) ) as JOSG_AMT ,
    JOSG_RATE,
    @Semantics.amount.currencyCode: 'TransactionCurrency'
    (JOIG_AMT * (-1 ) ) as JOIG_AMT,
    JOIG_RATE ,
    @Semantics.amount.currencyCode: 'TransactionCurrency'
//    (INVOICE_AMT  * (-1 ) ) as INVOICE_AMT,

       case when  JOIG_AMT  is not null
       then
            (JOIG_AMT + AmountInCompanyCodeCurrency )  * (-1 )
       else
           (JOCG_AMT + JOSG_AMT + AmountInCompanyCodeCurrency )  * (-1 )  end as INVOICE_AMT, 
//              ( AmountInCompanyCodeCurrency )   as INVOICE_AMT,
        
    FiscalPeriod as ReturnPeriod ,
//      concat(substring( PostingDate, 5, 2), substring( PostingDate, 1, 4)) as ReturnPeriod  , 
      case  REPORT when 'EXPORT'
      then cast( '97' as abap.char(10) )
       else cast( '' as abap.char(10) ) end as PortCode ,
    
    
    cast('' as abap.char(10) ) as SourceIdentifier,
    cast('' as abap.char(10) ) as SourceFileName,
    cast('' as abap.char(10) ) as GLAccountCode,
    cast('' as abap.char(10) ) as Division,
    cast('' as abap.char(10) ) as SubDivision,
    cast('' as abap.char(10) ) as ProfitCentre1,
    cast('' as abap.char(10) ) as ProfitCentre2,
    cast('' as abap.char(10) ) as PlantCode,
//    cast('' as abap.char(10) ) as SupplierGSTIN,
      case when CompanyCode = '1000'
         then '08AAKCS5788C1ZX'
         when CompanyCode = '2000'
          then '08ABJCS8323B1ZD' 
          end as                                                        SupplierGSTIN,
    cast('' as abap.char(10) ) as CRDRPreGST,
    cast('' as abap.char(10) ) as UINorComposition,
    cast('' as abap.char(10) ) as OriginalCustomerGSTIN,
    cast('' as abap.char(10) ) as BillToState,
    cast('' as abap.char(10) ) as ShipToState,
//    cast('' as abap.char(10) ) as PortCode,
    cast('' as abap.char(10) ) as ShippingBillNumber,
    cast('' as abap.char(10) ) as ShippingBillDate,
    cast('' as abap.char(10) ) as FOB,
    cast('' as abap.char(10) ) as ExportDuty,
    cast('' as abap.char(10) ) as CategoryOfProduct,
    cast('' as abap.char(10) ) as CessRateAdvalorem,
    cast('' as abap.char(10) ) as CessAmountAdvalorem,
    cast('' as abap.char(10) ) as CessRateSpecific,
    cast('' as abap.char(10) ) as CessAmountSpecific,
    cast('' as abap.char(10) ) as ReverseChargeFlag,
    cast('' as abap.char(10) ) as TCSFlag,
    cast('' as abap.char(10) ) as eComGSTIN,
    cast('' as abap.char(10) ) as ITCFlag,
    cast('' as abap.char(10) ) as ReasonForCreditDebitNote,
    cast('' as abap.char(10) ) as AccountingVoucherDate,
    cast('' as abap.char(10) ) as Userdefinedfield1,
    cast('' as abap.char(10) ) as Userdefinedfield2,
    cast('' as abap.char(10) ) as Userdefinedfield3
    
    
//    IsReversal,
//    IsReversed,
//    AmountInCompanyCodeCurrency
}
