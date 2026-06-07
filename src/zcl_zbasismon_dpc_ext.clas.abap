class ZCL_ZBASISMON_DPC_EXT definition
  public
  inheriting from ZCL_ZBASISMON_DPC
  create public .

public section.
protected section.

  methods BGJOBDETAILSSET_GET_ENTITYSET
    redefinition .
private section.
ENDCLASS.



CLASS ZCL_ZBASISMON_DPC_EXT IMPLEMENTATION.


  method BGJOBDETAILSSET_GET_ENTITYSET.
**TRY.
*CALL METHOD SUPER->BGJOBDETAILSSET_GET_ENTITYSET
*  EXPORTING
*    IV_ENTITY_NAME           =
*    IV_ENTITY_SET_NAME       =
*    IV_SOURCE_NAME           =
*    IT_FILTER_SELECT_OPTIONS =
*    IS_PAGING                =
*    IT_KEY_TAB               =
*    IT_NAVIGATION_PATH       =
*    IT_ORDER                 =
*    IV_FILTER_STRING         =
*    IV_SEARCH_STRING         =
**    io_tech_request_context  =
**  IMPORTING
**    et_entityset             =
**    es_response_context      =
*    .
**  CATCH /iwbep/cx_mgw_busi_exception.
**  CATCH /iwbep/cx_mgw_tech_exception.
**ENDTRY.

DATA: lv_jobname TYPE BTCJOB,
      lv_startdate TYPE BTCXDATE.

DATA(lo_request) = io_tech_request_context->get_request_headers( ).

DATA(lv_uri) = lo_request[ NAME = '~request_uri' ]-VALUE.

SPLIT lv_uri AT '?' INTO  DATA(lv_path) DATA(lv_queries). "Path can be ignored here".

SPLIT lv_queries AT '&' INTO TABLE DATA(lt_pairs).


LOOP AT lt_pairs INTO DATA(lv_pair).
  SPLIT lv_pair AT '=' INTO DATA(lv_key) DATA(lv_value).

  CASE lv_key.
    WHEN 'jobname'.
      lv_jobname = lv_value.
    WHEN 'startdate'.
      lv_startdate = lv_value.
  ENDCASE.

ENDLOOP.


  endmethod.
ENDCLASS.
