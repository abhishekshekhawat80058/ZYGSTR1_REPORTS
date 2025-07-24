@EndUserText.label: 'CDS FOR PROJ'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define root view entity ZGSTR1_DOC_CDS_PROJ
  provider contract transactional_query as projection on ZGST1_DOC_TAB_CDS
{
    key Report,
    key DocumentType,
    BilType,
    CreatedBy,
    CreatedAt,
    LastChangedBy,
    LastChangedAt,
    LocalLastChangedAt
}
