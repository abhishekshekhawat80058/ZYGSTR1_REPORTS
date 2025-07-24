@EndUserText.label: 'PROJ'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define  root view entity ZGSTR1_CDS_PROJ
  provider contract transactional_query as projection on ZGSTR1_GST_CDS
{
    key Zcondition,
    key GlCode,
    CreatedBy,
    CreatedAt,
    LastChangedBy,
    LastChangedAt,
    LocalLastChangedAt
}
