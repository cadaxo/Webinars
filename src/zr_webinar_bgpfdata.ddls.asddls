@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Data'

define root view entity zr_Webinar_bgPFData as select from zwb_bgpf_data
{
    key uuid as UUID,
    stamp as TimeStamp,
    data as Data
}
