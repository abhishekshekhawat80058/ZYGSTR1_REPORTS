@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GSTR1 NEW LOGIC B2B'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZGSTR1_B2B_SERVICE_CDS_NEW_LOG as select from I_BillingDocument as A 
     inner join   ZI_OPERATIONAL_CDS_FOR_UNION as AB on (  AB.BillingDocument = A.BillingDocument )
     left outer join   I_BillingDocumentItem as B on (  A.BillingDocument = B.BillingDocument )
                                                   
                                                   
    left outer join I_BillingDocumentPartner as C on  (  A.BillingDocument = C.BillingDocument and C.PartnerFunction = 'RE' )
    left outer join I_Customer as E on                 ( C.Customer = E.Customer )
    left outer join I_Address_2 as D on                ( C.AddressID = D.AddressID ) 
    left outer join I_ProductPlantBasic  as PL on ( PL.Plant  = B.Plant and PL.Product = B.Product )  
    left outer join I_BillingDocumentItemPrcgElmnt as K on ( K.BillingDocument = B.BillingDocument 
                                                           and K.BillingDocumentItem = B.BillingDocumentItem ) 
                                                           and K.ConditionType = 'JOCG'
    left outer join I_BillingDocumentItemPrcgElmnt as KK on ( KK.BillingDocument = B.BillingDocument 
                                                           and KK.BillingDocumentItem = B.BillingDocumentItem ) 
                                                           and KK.ConditionType = 'JOSG'   
                                                           
    left outer join I_BillingDocumentItemPrcgElmnt as KKK on ( KKK.BillingDocument = B.BillingDocument 
                                                           and KKK.BillingDocumentItem = B.BillingDocumentItem ) 
                                                           and KKK.ConditionType = 'JOIG'                                                                                                              
    
    
                                               
{
    
     key A.BillingDocument                as BillingDocument,
         A.CompanyCode                    as CompanyCode,
         A.FiscalYear                     as FiscalYear,
         A.BillingDocumentDate            as DocumentDate,
         B.BillingDocumentItem            ,
         B.Product                        as ProductCode,
         B.BillingQuantityUnit,
         @Semantics.quantity.unitOfMeasure: 'BillingQuantityUnit'
         B.BillingQuantity                as Quantity,
//          cast(B.BillingQuantity as abap.dec( 20, 3 ) ) as BillingQuantity ,
         B.BillingDocumentItemText        as ProductDescription,
         B.TransactionCurrency,
         @Semantics.amount.currencyCode: 'TransactionCurrency'
         B.NetAmount                     as TaxableValue,
         @Semantics.amount.currencyCode: 'TransactionCurrency'
         ( B.TaxAmount + B.NetAmount ) as InvoiceValue ,
         
         C.Customer                       as CUSTOMER_CODE,
         E.TaxNumber3                     as CustomerGSTIN,
         E.AddressID ,
         E.Region                         as  pos ,
         PL.ConsumptionTaxCtrlCode        ,
         K.ConditionRateValue             as JOCG_Rate,
         @Semantics.amount.currencyCode: 'TransactionCurrency'
         K.ConditionAmount                as JOCG_AMOUNT,
         KK.ConditionRateValue            as JOSG_RATE,
         @Semantics.amount.currencyCode: 'TransactionCurrency'
         KK.ConditionAmount               as JOSG_AMOUNT ,
         KKK.ConditionRateValue           as JOIG_RATE,
         @Semantics.amount.currencyCode: 'TransactionCurrency'
         KKK.ConditionAmount               as JOIG_AMOUNT ,
         
         
         
        concat(
        concat(coalesce(D.OrganizationName1, ''), coalesce(D.OrganizationName2, '')),
        concat(coalesce(D.OrganizationName3, ''), coalesce(D.OrganizationName4, ''))
    ) as CustomerName
   
                      
   
}

where A.BillingDocumentIsCancelled = ''
and   (A.BillingDocumentType <> 'S1' and 
       A.BillingDocumentType <> 'S2' and 
       A.BillingDocumentType <> 'S3')

