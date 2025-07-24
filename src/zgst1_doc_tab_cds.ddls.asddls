@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GSTR1 DOC TABLE'
define root view entity ZGST1_DOC_TAB_CDS as select from zgstr1_doc_table

{
    key report as Report,
    key document_type as DocumentType,
    bil_type as BilType,
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
