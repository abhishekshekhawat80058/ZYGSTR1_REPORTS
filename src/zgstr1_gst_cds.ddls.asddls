@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GSTR1 GST CDS'
define root view entity ZGSTR1_GST_CDS as select from zgstr1_gst_table

{
    key zcondition as Zcondition,
    key gl_code as GlCode,
    @Semantics.user.createdBy: true
     created_by as CreatedBy,
   @Semantics.systemDateTime.createdAt: true
     created_at as CreatedAt,
   @Semantics.user.localInstanceLastChangedBy: true
     last_changed_by as LastChangedBy,
   @Semantics.systemDateTime.localInstanceLastChangedAt: true
     last_changed_at as LastChangedAt,
   @Semantics.systemDateTime.lastChangedAt: true
     local_last_changed_at as LocalLastChangedAt
    
}
