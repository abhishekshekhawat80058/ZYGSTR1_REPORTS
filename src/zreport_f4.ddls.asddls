@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'F4'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@ObjectModel.resultSet.sizeCategory: #XS
define view entity ZREPORT_F4 as select from yreport_f4_table as A
{
    key A.report2
    
    }
      where  A.report2 <> 'NIL RA'                    
     and  A.report = 'GSTR1'
    
    group by A.report2
 