class ZCL_ZBASIS_BG_JOB_MON_DPC_EXT definition
  public
  inheriting from ZCL_ZBASIS_BG_JOB_MON_DPC
  create public .

public section.
protected section.

  methods BGJOBDETAILSSET_GET_ENTITYSET
    redefinition .
private section.
ENDCLASS.



CLASS ZCL_ZBASIS_BG_JOB_MON_DPC_EXT IMPLEMENTATION.


  METHOD bgjobdetailsset_get_entityset.
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


    CALL FUNCTION 'ZBASIS_BG_GET_JOBDETAILS'
*   EXPORTING
*     JOBNAME          =
*     STARTDATE        =
      IMPORTING
        jobdetails = et_entityset
*       SUCCESSJOB =
*       FAILEDJOB  =
      .

  ENDMETHOD.
ENDCLASS.
