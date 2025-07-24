@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Union Cds For gstr1 report'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZGSTR1_UNION_CDS
  as select distinct from ZGSTR1_B2B_SERVICE_CDS as A
    left outer join       zexport_data_tab       as b on(
      b.docno       = A.BillingDocument
      and b.doctype = 'PO'
    )
{

                  @UI.lineItem      : [{ position: 1 }]
                  @UI.identification: [{ position: 1 }]
                  @EndUserText.label: 'SourceIdentifier'
  key             A.SourceIdentifier,
                  @UI.lineItem      : [{ position: 2 }]
                  @UI.identification: [{ position: 2 }]
                  @EndUserText.label: 'SourceFileName'
  key             A.SourceFileName,
                  @UI.lineItem      : [{ position: 3 }]
                  @UI.identification: [{ position: 3 }]
                  @EndUserText.label: 'GLAccountCode'
  key             A.GLAccountCode,
                  @UI.lineItem      : [{ position: 4 }]
                  @UI.identification: [{ position: 4 }]
                  @EndUserText.label: 'Division'
  key             A.Division,
                  @UI.lineItem      : [{ position: 5 }]
                  @UI.identification: [{ position: 5 }]
                  @EndUserText.label: 'SubDivision'
  key             A.SubDivision,
                  @UI.lineItem      : [{ position: 6 }]
                  @UI.identification: [{ position: 6 }]
                  @EndUserText.label: 'ProfitCentre1'
  key             A.ProfitCentre1,
                  @UI.lineItem      : [{ position: 7 }]
                  @UI.identification: [{ position: 7 }]
                  @EndUserText.label: 'ProfitCentre2'
  key             A.ProfitCentre2,
                  @UI.lineItem      : [{ position: 8 }]
                  @UI.identification: [{ position: 8 }]
                  @EndUserText.label: 'PlantCode'
  key             A.PlantCode,
                  @UI.lineItem      : [{ position: 9 }]
                  @UI.identification: [{ position: 9 }]
                  @EndUserText.label: 'ReturnPeriod'
  key             A.ReturnPeriod, // 1
                  @UI.lineItem      : [{ position: 10 }]
                  @UI.identification: [{ position: 10 }]
                  @EndUserText.label: 'SupplierGSTIN'
  key             A.SupplierGSTIN,

                  @UI.lineItem      : [{ position: 11 }]
                  @UI.identification: [{ position: 11 }]
                  @EndUserText.label: 'DocumentType'
  key             case
              when A.REPORT = 'B2B'   then cast('INV'  as abap.char(6) )
//               when A.REPORT = 'B2B'   then cast('INV'  as abap.char(10) )

              when  A.REPORT = 'CDNR'
               then
                 case when A.table_value < 0
                  then cast('CR' as abap.char(6) )
//                  then cast('CR' as abap.char(10) )
                  else cast('DR' as abap.char(6) )
//                  else cast('DR' as abap.char(10) )
                   end

               when  A.REPORT = 'B2CS'
               then
                 case when A.table_value < 0
                  then cast('CR' as abap.char(6) )
                  else cast('DR' as abap.char(6) )
//                   then cast('CR' as abap.char(10) )
//                  else cast('DR' as abap.char(10) )
                   end

             else
                case when A.BillingDocumentType = 'G2'
                  then cast('CR' as abap.char(6) )
                  when A.BillingDocumentType = 'CBRE'
                  then cast('CR' as abap.char(6) )
//                    case when A.BillingDocumentType = 'G2'
//                  then cast('CR' as abap.char(10) )
//                  when A.BillingDocumentType = 'CBRE'
//                  then cast('CR' as abap.char(10) )

                  when A.BillingDocumentType = 'L2'
                  then cast('DR' as abap.char(6) )
//                   when A.BillingDocumentType = 'L2'
//                  then cast('DR' as abap.char(10) )

                  when A.BillingDocumentType = 'F2'
                  then cast('INV' as abap.char(6) )
                  else cast('-' as abap.char(6) )
                   end
//                   when A.BillingDocumentType = 'F2'
//                  then cast('INV' as abap.char(10) )
//                  else cast('-' as abap.char(10) )
//                   end
                   
              end                                          as DOCUMENTTYPE1, // 2

                  @UI.lineItem      : [{ position: 12 }]
                  @UI.identification: [{ position: 12 }]
                  @EndUserText.label: 'SupplyType'
  key             case  when A.REPORT = 'EXPORT'
                  then  cast('EXPT'  as abap.char(10) )
                  else  cast('TAX'  as abap.char(10) )

                  end                                      as SUPPLYTYPE, // 3

                  @UI.lineItem      : [{ position: 12 }]
                  @UI.identification: [{ position: 12 }]
                  @EndUserText.label: 'DocumentNumber'
  key             A.BillingDocument, // 4

                  @UI.lineItem     : [{ position: 13 }]
                  @UI.identification: [{ position: 13 }]
                  @UI.selectionField: [{ position: 13 }]
                  @EndUserText.label: 'DocumentDate'
  key             A.PostingDate,     // 5

                  @UI.lineItem      : [{ position: 14 }]
                  @UI.identification: [{ position: 14 }]
                  @EndUserText.label: 'OriginalDocumentNumber'
  key             ''                                       as DocumentReferenceID, //A.DocumentReferenceID,                    // 6

                  @UI.lineItem      : [{ position: 15 }]
                  @UI.identification: [{ position: 15 }]
                  @EndUserText.label: 'OriginalDocumentDate'
  key             ''                                       as DocumentDate, //A.DocumentDate,                             // 7

                  @UI.lineItem      : [{ position: 16 }]
                  @UI.identification: [{ position: 16 }]
                  @EndUserText.label: 'CRDRPreGST'
  key             A.CRDRPreGST,

                  @UI.lineItem      : [{ position: 17 }]
                  @UI.identification: [{ position: 17 }]
                  @EndUserText.label: 'LineNumber'
  key             case A.REPORT when 'EXPORT'
                  then case when A.doc_item = '000000'
                  then '000001'
                  else A.doc_item end
                  else A.doc_item
                  end                                      as doc_item,

                  //  key             A.doc_item, // 8

                  @UI.lineItem      : [{ position: 18 }]
                  @UI.identification: [{ position: 18 }]
                  @EndUserText.label: 'CustomerGSTIN'
  key             A.customer_gst, // 9

                  @UI.lineItem      : [{ position: 19 }]
                  @UI.identification: [{ position: 19 }]
                  @EndUserText.label: 'UINorComposition'
  key             A.UINorComposition,

                  @UI.lineItem      : [{ position: 20 }]
                  @UI.identification: [{ position: 20 }]
                  @EndUserText.label: 'UINorComposition'
  key             A.OriginalCustomerGSTIN,

                  @UI.lineItem     : [{ position: 21 }]
                  @UI.identification: [{ position: 21 }]
                  @EndUserText.label: 'CustomerName'
  key             A.CustomerName, // 10

                  @UI.lineItem      : [{ position: 22 }]
                  @UI.identification: [{ position: 22 }]
                  @EndUserText.label: 'CustomerCode'
  key             A.Customer, // 11

                  @UI.lineItem      : [{ position: 23 }]
                  @UI.identification: [{ position: 23 }]
                  @EndUserText.label: 'BillToState'
  key             A.BillToState,

                  @UI.lineItem      : [{ position: 24 }]
                  @UI.identification: [{ position: 24 }]
                  @EndUserText.label: 'ShipToState'
  key             A.ShipToState,

                  @UI.lineItem      : [{ position: 25 }]
                  @UI.identification: [{ position: 25 }]
                  @EndUserText.label   : 'POS'
                  //  key             A.Region, // A.Region

  key             case A.REPORT when 'EXPORT'
                  then '97'
                  else A.Region
                  end                                      as Region,

                  @UI.lineItem      : [{ position: 26 }]
                  @UI.identification: [{ position: 26 }]
                  @EndUserText.label   : 'PortCode'
  key             A.PortCode,

                  @UI.lineItem      : [{ position: 27 }]
                  @UI.identification: [{ position: 27 }]
                  @EndUserText.label   : 'ShippingBillNumber'
  key             case A.REPORT when 'EXPORT'
                  then b.shippingbillno
                  else A.ShippingBillNumber
                  end                                      as ShippingBillNumber,

//                    key  A.ShippingBillNumber as ShippingBillNumber,

                  @UI.lineItem      : [{ position: 28 }]
                  @UI.identification: [{ position: 28 }]
                  @EndUserText.label   : 'ShippingBillDate'
  key             cast( case A.REPORT when 'EXPORT'
                  then case when b.sbdate = '00000000'
                  then ''
                  else concat( concat(concat(concat(right(b.sbdate,2),'.'),
                                      right(left(b.sbdate,6),2)  ),'.'),
                               left(b.sbdate,4) )
                  end
                  else ''
                  end  as abap.char(10) )                   as ShippingBillDate,

                  //  key             A.ShippingBillDate                       as ShippingBillDate,

                  @UI.lineItem      : [{ position: 29 }]
                  @UI.identification: [{ position: 29 }]
                  @EndUserText.label   : 'FOB'
  key             A.FOB,

                  @UI.lineItem      : [{ position: 30 }]
                  @UI.identification: [{ position: 30 }]
                  @EndUserText.label   : 'ExportDuty'
  key             A.ExportDuty,

                  @UI.lineItem      : [{ position: 31 }]
                  @UI.identification: [{ position: 31 }]
                  @EndUserText.label   : 'HSNorSAC'
  key             A.hsn_code, // 13

                  @UI.lineItem      : [{ position: 32 }]
                  @UI.identification: [{ position: 32 }]
                  @EndUserText.label   : 'ProductCode'
  key             A.product,  // 14

                  @UI.lineItem      : [{ position: 33 }]
                  @UI.identification: [{ position: 33 }]
                  @EndUserText.label   : 'ProductDescription'
  key             A.ProductDescription, // 15

                  @UI.lineItem      : [{ position: 34 }]
                  @UI.identification: [{ position: 34 }]
                  @EndUserText.label   : 'CategoryOfProduct'
  key             A.CategoryOfProduct,

                  @UI.lineItem      : [{ position: 35 }]
                  @UI.identification: [{ position: 35 }]
                  @EndUserText.label   : 'UnitOfMeasurement'
  key             A.BaseUnit, // 16

                  @UI.lineItem      : [{ position: 36 }]
                  @UI.identification: [{ position: 36 }]
                  @EndUserText.label   : 'Quantity'
  key             cast( A.Quantity as abap.dec(23,2) )     as Quantity, // 17

  
                  @UI.lineItem      : [{ position: 37 }]
                  @UI.identification: [{ position: 37 }]
                  @DefaultAggregation: #SUM
                  @EndUserText.label: 'TaxableValue '
  key            cast(A.INVOICE_AMT as abap.dec( 20, 2 )) as table_value, // 18

                  @UI.lineItem      : [{ position: 38 }]
                  @UI.identification: [{ position: 38 }]
                  @EndUserText.label: 'IntegratedTaxRate'
  key             A.JOIG_RATE, // 19

                  @UI.lineItem      : [{ position: 39 }]
                  @UI.identification: [{ position: 39 }]
                  @DefaultAggregation: #SUM
                  @EndUserText.label: 'IntegratedTaxAmount'
  key             cast(A.JOIG_AMT as abap.dec( 20, 2 ))    as JOIG_AMT, // 20

                  @UI.lineItem      : [{ position: 40 }]
                  @UI.identification: [{ position: 40 }]
                  @EndUserText.label: 'CentralTaxRate'
  key             A.JOCG_RATE, // 21

                  @UI.lineItem      : [{ position: 41 }]
                  @UI.identification: [{ position: 41 }]
                  @DefaultAggregation: #SUM
                  @EndUserText.label: 'CentralTaxAmount'
  key             cast(A.JOCG_AMT as abap.dec( 20, 2 ))    as JOCG_AMT, // 22

                  @UI.lineItem      : [{ position: 42 }]
                  @UI.identification: [{ position: 42 }]
                  @EndUserText.label: 'StateUTTaxRate'
  key             A.JOSG_RATE, // 23

                  @UI.lineItem      : [{ position: 43 }]
                  @UI.identification: [{ position: 43 }]
                  @DefaultAggregation: #SUM
                  @EndUserText.label: 'StateUTTaxAmount'
  key             cast(A.JOSG_AMT as abap.dec( 20, 2 ))    as JOSG_AMT, // 24

                  @UI.lineItem      : [{ position: 44 }]
                  @UI.identification: [{ position: 44 }]
                  @EndUserText.label: 'CessRateAdvalorem'
  key             A.CessRateAdvalorem,

                  @UI.lineItem      : [{ position: 45 }]
                  @UI.identification: [{ position: 45 }]
                  @EndUserText.label: 'CessAmountAdvalorem'
  key             A.CessAmountAdvalorem,

                  @UI.lineItem      : [{ position: 46 }]
                  @UI.identification: [{ position: 46 }]
                  @EndUserText.label: 'CessRateSpecific'
  key             A.CessRateSpecific,

                  @UI.lineItem      : [{ position: 47 }]
                  @UI.identification: [{ position: 47 }]
                  @EndUserText.label: 'CessAmountSpecific'
  key             A.CessAmountSpecific,

                  @UI.lineItem      : [{ position: 48 }]
                  @UI.identification: [{ position: 48 }]
                  @DefaultAggregation: #SUM
                  @EndUserText.label: 'InvoiceValue'
  key             cast(A.INVOICE_AMT as abap.dec( 20, 2 )) as INVOICE_AMT, // 25
  


                  @UI.lineItem      : [{ position: 49 }]
                  @UI.identification: [{ position: 49 }]
                  @EndUserText.label: 'ReverseChargeFlag'
  key             A.ReverseChargeFlag,

                  @UI.lineItem      : [{ position: 50 }]
                  @UI.identification: [{ position: 50 }]
                  @EndUserText.label: 'TCSFlag'
  key             A.TCSFlag,

                  @UI.lineItem      : [{ position: 51 }]
                  @UI.identification: [{ position: 51 }]
                  @EndUserText.label: 'eComGSTIN'
  key             A.eComGSTIN,

                  @UI.lineItem      : [{ position: 52 }]
                  @UI.identification: [{ position: 52 }]
                  @EndUserText.label: 'ITCFlag'
  key             A.ITCFlag,

                  @UI.lineItem      : [{ position: 53 }]
                  @UI.identification: [{ position: 53 }]
                  @EndUserText.label: 'ReasonForCreditDebitNote'
  key             A.ReasonForCreditDebitNote,

                  @UI.lineItem      : [{ position: 54 }]
                  @UI.identification: [{ position: 54 }]
                  @UI.selectionField: [{ position: 54 }]
                  @EndUserText.label: 'AccountingVoucherNumber'
  key             A.AccountingDocument, // 26

                  @UI.lineItem      : [{ position: 55 }]
                  @UI.identification: [{ position: 55 }]
                  @EndUserText.label: 'AccountingVoucherDate'
  key             A.AccountingVoucherDate,

                  @UI.lineItem      : [{ position: 56 }]
                  @UI.identification: [{ position: 56 }]
                  @EndUserText.label: 'Userdefinedfield1'
  key             A.Userdefinedfield1,

                  @UI.lineItem      : [{ position: 57 }]
                  @UI.identification: [{ position: 57 }]
                  @EndUserText.label: 'Userdefinedfield2'
  key             A.Userdefinedfield2,
                                      @UI.lineItem      : [{ position: 58 }]
                  @UI.identification: [{ position: 58 }]
                  @EndUserText.label: 'Userdefinedfield3'
  key             A.Userdefinedfield3,

                  @UI.lineItem      : [{ position: 59 }]
                  @UI.identification: [{ position: 59 }]
                  @UI.selectionField: [{ position: 59 }]
                  @EndUserText.label: 'Company Code'
  key             A.CompanyCode, // 27

                  @UI.lineItem      : [{ position: 60 }]
                  @UI.identification: [{ position: 60 }]
                  @UI.selectionField: [{ position: 60 }]
  key             A.FiscalYear, // 28

                  @UI.lineItem      : [{ position: 61 }]
                  @UI.identification: [{ position: 61 }]
                  @EndUserText.label: 'Journal Entry Type'
  key             A.AccountingDocumentType, //  29

                  @UI.lineItem      : [{ position: 62 }]
                  @UI.identification: [{ position: 62 }]
                  @EndUserText.label: 'Billing Type'
  key             A.BillingDocumentType,

                  @UI.lineItem      : [{ position: 63 }]
                  @UI.identification: [{ position: 63 }]
                  @EndUserText.label: 'G/L Account'
  key             A.GLAccount,

                  @UI.lineItem      : [{ position: 64 }]
                  @UI.identification: [{ position: 64 }]
                  @EndUserText.label: 'ProfitCenter'
  key             A.ProfitCenter,

                  @UI.lineItem      : [{ position: 65 }]
                  @UI.identification: [{ position: 65 }]
                  @EndUserText.label: 'Tax Code'
  key             A.TaxCode,

                  @UI.lineItem      : [{ position: 66 }]
                  @UI.identification: [{ position: 66 }]
                  @EndUserText.label: 'Business Place'
  key             A.BusinessPlace,

                  @UI.lineItem      : [{ position: 67 }]
                  @UI.identification: [{ position: 67 }]
                  @EndUserText.label: 'ewbnumber'
  key             A.ewbnumber,

                  @UI.lineItem      : [{ position: 68 }]
                  @UI.identification: [{ position: 68 }]
                  @EndUserText.label: 'Irn'
  key             A.Irn,

                  @UI.lineItem      : [{ position: 69 }]
                  @UI.identification: [{ position: 69 }]
                  @EndUserText.label: 'Transaction Currency'
  key             A.TransactionCurrency,


                  @UI.lineItem             : [{position: 70 }]
                  @UI.selectionField       : [{position: 70  }]
                  @UI.identification       : [{position: 70  }]

                  @Consumption.filter.multipleSelections: false
                  @Consumption.filter.mandatory: true
                  //      @Consumption.defaultValue: 'CDNR'
                  @EndUserText.label       : 'Report'
                  @Consumption.valueHelpDefinition: [
                  { entity                  :  { name:    'ZREPORT_F4',
                              element      : 'report2' }
                  }]
  key             A.REPORT, 
  
@UI.lineItem      : [{ position: 71 }]
                  @UI.identification: [{ position: 71 }]
                  @EndUserText.label: 'BillingDocumentItem'
                    key cast('000000' as abap.numc(6)) as BillingDocumentItem
                    

                    
                 

}

union select distinct from ZGSTR1_CDNR_SERVICE_CDS as a

{

  key  a.SourceIdentifier,
  key  a.SourceFileName,
  key  a.GLAccountCode,
  key  a.Division,
  key  a.SubDivision,
  key  a.ProfitCentre1,
  key  a.ProfitCentre2,
  key  a.PlantCode,
  key  a.ReturnPeriod, // 1
  key  a.SupplierGSTIN,
 

  key  case
    when REPORT = 'B2B'   then cast('INV'  as abap.char(6) )

    when  REPORT = 'CDNR'
     then
       case when table_value < 0
        then cast('CR' as abap.char(6) )
        else cast('DR' as abap.char(6) )
         end
    when  REPORT = 'B2CS'
     then
       case when table_value < 0
        then cast('CR' as abap.char(6) )
        else cast('DR' as abap.char(6) )
         end

   else
      case when BillingDocumentType = 'G2'
        then cast('CR' as abap.char(6) )
        when BillingDocumentType = 'CBRE'
        then cast('CR' as abap.char(6) )

        when BillingDocumentType = 'L2'
        then cast('DR' as abap.char(6) )

        when BillingDocumentType = 'F2'
        then cast('INV' as abap.char(6) )
        else cast('-' as abap.char(6) )
         end


    end                                         as DOCUMENTTYPE1, // 2

  key  case  when REPORT = 'EXPWP'
       then  cast('EXPT'  as abap.char(10) )
       else  cast('TAX'  as abap.char(10) )

       end                                      as SUPPLYTYPE, // 3

  key  a.BillingDocument, // 4

  key  a.PostingDate, // 5
  key  a.DocumentReferenceID, // 6

  key  a.DocumentDate,            // 7

  key  a.CRDRPreGST,
  key  a.doc_item,                // 8
  key  a.customer_gst,            // 9
  key  a.UINorComposition,
  key  a.OriginalCustomerGSTIN,
  key  a.CustomerName,            // 10
  key  a.Customer,            // 11
  key  a.BillToState,
  key  a.ShipToState,
  key  a.Region,              // 12
  key  a.PortCode,
  key  a.ShippingBillNumber,
  key  a.ShippingBillDate,
  key  a.FOB,
  key  a.ExportDuty,
  key  a.hsn_code,            // 13
  key  a.product, // 14
  key  a.ProductDescription, // 15
  key  a.CategoryOfProduct,
  key  a.BaseUnit, // 16
  key  cast( a.Quantity as abap.dec(23,2) )     as Quantity, // 17
  key  cast(a.INVOICE_AMT as abap.dec( 20, 2 )) as table_value, // 18
  key  a.JOIG_RATE, // 19
  key  cast(a.JOIG_AMT as abap.dec( 20, 2 ))    as JOIG_AMT, // 20
  key  a.JOCG_RATE, // 21
  key  cast(a.JOCG_AMT as abap.dec( 20, 2 ))    as JOCG_AMT, // 22
  key  a.JOSG_RATE, // 23
  key  cast(a.JOSG_AMT as abap.dec( 20, 2 ))    as JOSG_AMT, // 24
  key  a.CessRateAdvalorem,
  key  a.CessAmountAdvalorem,
  key  a.CessRateSpecific,
  key  a.CessAmountSpecific,

  key  cast(a.INVOICE_AMT as abap.dec( 20, 2 )) as INVOICE_AMT, // 25
//      key  cast(a.INVOICE_AMT as abap.dec( 20, 2 )) as table_value,
  key  a.ReverseChargeFlag,
  key  a.TCSFlag,
  key  a.eComGSTIN,
  key  a.ITCFlag,
  key  a.ReasonForCreditDebitNote,
  key  a.AccountingDocument, // 26
  key  a.AccountingVoucherDate,
  key  a.Userdefinedfield1,
  key  a.Userdefinedfield2,
  key  a.Userdefinedfield3,
  key  a.CompanyCode, // 27
  key  a.FiscalYear, // 28
  key  a.AccountingDocumentType, //  29
  key  a.BillingDocumentType,
  key  a.GLAccount,
  key  a.ProfitCenter,
  key  a.TaxCode,
  key  a.BusinessPlace,
  key  a.ewbnumber,
  key  a.Irn,
  key  a.TransactionCurrency,
  key  a.REPORT,
 key cast('000000' as abap.numc(6)) as BillingDocumentItem

}
 union select distinct from ZGSTR1_NIL_RATES_SERVICE_CDS as A 
     left outer join zexport_data_tab as b on( b.docno = A.BillingDocument
      and b.doctype = 'PO' )     
 
 {
  key  A.SourceIdentifier,
  key  A.SourceFileName,
  key  A.GLAccountCode,
  key  A.Division,
  key  A.SubDivision,
  key  A.ProfitCentre1,
  key  A.ProfitCentre2,
  key  A.PlantCode,
  key  A.ReturnPeriod, // 1
  key  A.SupplierGSTIN,
//  key  A.BillingDocumentItem,

  key  case

      when  A.BillingDocument like 'RN%'
       then cast('CR' as abap.char(6) )
       else cast('INV'  as abap.char(6) )


    end                                         as DOCUMENTTYPE1, // 2


       
 key case when A.TransactionCurrency <> 'INR'
       then  cast('EXPWT'  as abap.char(10) )  
      else   cast('NIL'  as abap.char(10) )


       end                                      as SUPPLYTYPE, // 3    

  key  A.BillingDocument, // 4

  key  A.PostingDate, // 5
  key  A.DocumentReferenceID, // 6

  key  A.DocumentDate,            // 7

  key  A.CRDRPreGST,
  key  A.doc_item,                // 8
  key  A.customer_gst,            // 9
  key  A.UINorComposition,
  key  A.OriginalCustomerGSTIN,
  key  A.CustomerName,            // 10
  key  A.Customer,            // 11
  key  A.BillToState,
  key  A.ShipToState,
  key  A.Region,              // 12
  key  A.PortCode,
   key case A.REPORT when 'NILRAT'
                  then b.shippingbillno
                  else A.ShippingBillNumber
                  end                                      as ShippingBillNumber,
//  key  A.ShippingBillNumber,
//  key  A.ShippingBillDate,
  key             cast( case A.REPORT when 'NILRAT'
                  then case when b.sbdate = '00000000'
                  then ''
                  else concat( concat(concat(concat(right(b.sbdate,2),'.'),
                                      right(left(b.sbdate,6),2)  ),'.'),
                               left(b.sbdate,4) )
                  end
                  else ''
                  end  as abap.char(10) )                   as ShippingBillDate,
  key  A.FOB,
  key  A.ExportDuty,
  key  A.hsn_code,            // 13
  key  A.Product, // 14
  key  A.ProductDescription, // 15
  key  A.CategoryOfProduct,
  key  A.BaseUnit, // 16
  key  cast( A.Quantity as abap.dec(23,2) )     as Quantity, // 17
  key  cast(A.INVOICE_AMT as abap.dec( 20, 2 )) as table_value, // 18
  key  A.JOIG_RATE, // 19
  key  cast(A.JOIG_AMT as abap.dec( 20, 2 ))    as JOIG_AMT, // 20
  key  A.JOCG_RATE, // 21
  key  cast(A.JOCG_AMT as abap.dec( 20, 2 ))    as JOCG_AMT, // 22
  key  A.JOSG_RATE, // 23
  key  cast(A.JOSG_AMT as abap.dec( 20, 2 ))    as JOSG_AMT, // 24
  key  A.CessRateAdvalorem,
  key  A.CessAmountAdvalorem,
  key  A.CessRateSpecific,
  key  A.CessAmountSpecific,
  key  cast(A.INVOICE_AMT as abap.dec( 20, 2 )) as INVOICE_AMT, // 25
//  key cast(A.INVOICE_AMT as abap.dec( 20, 2 )) as table_value,
  key  A.ReverseChargeFlag,
  key  A.TCSFlag,
  key  A.eComGSTIN,
  key  A.ITCFlag,
  key  A.ReasonForCreditDebitNote,
  key  A.AccountingDocument, // 26
  key  A.AccountingVoucherDate,
  key  A.Userdefinedfield1,
  key  A.Userdefinedfield2,
  key  A.Userdefinedfield3,
  key  A.CompanyCode, // 27
  key  A.FiscalYear, // 28
  key  A.AccountingDocumentType, //  29
  key  A.BillingDocumentType,
  key  A.GLAccount,
  key  A.ProfitCenter,
  key  A.TaxCode,
  key  A.BusinessPlace,
  key  A.ewbnumber,
  key  A.Irn,
  key  A.TransactionCurrency,
  key  A.REPORT,
   key A.BillingDocumentItem
  
 
 
 }



