@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'TAX CODE RATE'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity Zytax_code2 as select from ytax_code2_tab as A
{
    key A.taxcode ,
        A.taxcodedescription ,
        A.gstrate,
        sum(gstrate) as totalgstrate
}
    group by 
        A.taxcode ,
        A.taxcodedescription ,
        A.gstrate
