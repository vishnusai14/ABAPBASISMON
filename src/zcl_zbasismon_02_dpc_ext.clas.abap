class ZCL_ZBASISMON_02_DPC_EXT definition
  public
  inheriting from ZCL_ZBASISMON_02_DPC
  create public .

public section.
protected section.

  methods BGJOBDETAILSSET_GET_ENTITYSET
    redefinition .
  methods BGJOBDETAILSSUMM_GET_ENTITYSET
    redefinition .
  methods BGJOBLOGDETAILSS_GET_ENTITYSET
    redefinition .
  methods LOCKDETAILSSET_GET_ENTITYSET
    redefinition .
  methods SERVERDETAILSSET_GET_ENTITYSET
    redefinition .
  methods WORKPROCESSDETAI_GET_ENTITYSET
    redefinition .
private section.
ENDCLASS.



CLASS ZCL_ZBASISMON_02_DPC_EXT IMPLEMENTATION.


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

    DATA: lt_queryparams TYPE zquery_paramstab.

    DATA: lt_jobname   TYPE btcjob,
          lt_startdate TYPE btcxdate.

    DATA(lt_header) = io_tech_request_context->get_request_headers( ).
    DATA(request_uri) = lt_header[ name = '~request_uri' ]-value.



    IF request_uri IS NOT INITIAL.

      CALL FUNCTION 'ZBASIS_GET_QUERY_PARAMETERS'
        EXPORTING
          request_uri  = request_uri
        IMPORTING
          query_params = lt_queryparams.


      LOOP AT lt_queryparams INTO DATA(wa_queryparams).
        TRANSLATE wa_queryparams-query TO LOWER CASE.
        CASE wa_queryparams-query.
          WHEN 'jobname'.
            lt_jobname = wa_queryparams-value.
          WHEN 'startdate'.
            lt_startdate = wa_queryparams-value.
        ENDCASE.
      ENDLOOP.

    ENDIF.
    CALL FUNCTION 'ZBASIS_BG_GET_JOBDETAILS'
      EXPORTING
        jobname    = lt_jobname
        startdate  = lt_startdate
      IMPORTING
        jobdetails = et_entityset.

  ENDMETHOD.


  method BGJOBDETAILSSUMM_GET_ENTITYSET.
**TRY.
*CALL METHOD SUPER->BGJOBDETAILSSUMM_GET_ENTITYSET
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


     DATA: lt_queryparams TYPE zquery_paramstab.

    DATA: lt_jobname   TYPE btcjob,
          lt_startdate TYPE btcxdate.

    DATA(lt_header) = io_tech_request_context->get_request_headers( ).
    DATA(request_uri) = lt_header[ name = '~request_uri' ]-value.



    IF request_uri IS NOT INITIAL.

      CALL FUNCTION 'ZBASIS_GET_QUERY_PARAMETERS'
        EXPORTING
          request_uri  = request_uri
        IMPORTING
          query_params = lt_queryparams.


      LOOP AT lt_queryparams INTO DATA(wa_queryparams).
        TRANSLATE wa_queryparams-query TO LOWER CASE.
        CASE wa_queryparams-query.
          WHEN 'jobname'.
            lt_jobname = wa_queryparams-value.
          WHEN 'startdate'.
            lt_startdate = wa_queryparams-value.
        ENDCASE.
      ENDLOOP.

    ENDIF.
    CALL FUNCTION 'ZBASIS_BG_GET_JOBDETAILS'
      EXPORTING
        jobname    = lt_jobname
        startdate  = lt_startdate
      IMPORTING
        jobsummary = et_entityset.




  endmethod.


  METHOD bgjoblogdetailss_get_entityset.
**TRY.
*CALL METHOD SUPER->BGJOBLOGDETAILSS_GET_ENTITYSET
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

    DATA: lt_queryparams TYPE zquery_paramstab.

    DATA: lt_jobname  TYPE btcjob,
          lt_jobcount TYPE btcjobcnt.

    DATA(lt_header) = io_tech_request_context->get_request_headers( ).
    DATA(request_uri) = lt_header[ name = '~request_uri' ]-value.



    IF request_uri IS NOT INITIAL.

      CALL FUNCTION 'ZBASIS_GET_QUERY_PARAMETERS'
        EXPORTING
          request_uri  = request_uri
        IMPORTING
          query_params = lt_queryparams.


      LOOP AT lt_queryparams INTO DATA(wa_queryparams).
        TRANSLATE wa_queryparams-query TO LOWER CASE.
        CASE wa_queryparams-query.
          WHEN 'jobname'.
            lt_jobname = wa_queryparams-value.
          WHEN 'jobcount'.
            lt_jobcount = wa_queryparams-value.
        ENDCASE.
      ENDLOOP.

    ENDIF.

    CALL FUNCTION 'ZBASIS_BG_GET_JOB_LOG_DETAILS'
      EXPORTING
        jobcount       = lt_jobcount
        jobname        = lt_jobname
     IMPORTING
       JOBLOG         = et_entityset.



  ENDMETHOD.


  METHOD lockdetailsset_get_entityset.
**TRY.
*CALL METHOD SUPER->LOCKDETAILSSET_GET_ENTITYSET
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

    CALL FUNCTION 'ZBASIS_GET_LOCKS_DETAILS'
      IMPORTING
        lockdetails = et_entityset.



  ENDMETHOD.


  method SERVERDETAILSSET_GET_ENTITYSET.
**TRY.
*CALL METHOD SUPER->SERVERDETAILSSET_GET_ENTITYSET
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

    CALL FUNCTION 'ZBASIS_GET_SERVER_LIST'
     IMPORTING
       LIST          = et_entityset
              .


  endmethod.


  METHOD workprocessdetai_get_entityset.
**TRY.
*CALL METHOD SUPER->WORKPROCESSDETAI_GET_ENTITYSET
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

    DATA: lt_queryparams TYPE zquery_paramstab.

    DATA: lt_servername   TYPE msname2.

    DATA(lt_header) = io_tech_request_context->get_request_headers( ).
    DATA(request_uri) = lt_header[ name = '~request_uri' ]-value.



    IF request_uri IS NOT INITIAL.

      CALL FUNCTION 'ZBASIS_GET_QUERY_PARAMETERS'
        EXPORTING
          request_uri  = request_uri
        IMPORTING
          query_params = lt_queryparams.


      LOOP AT lt_queryparams INTO DATA(wa_queryparams).
        TRANSLATE wa_queryparams-query TO LOWER CASE.
        CASE wa_queryparams-query.
          WHEN 'servername'.
            lt_servername = wa_queryparams-value.
        ENDCASE.
      ENDLOOP.

    ENDIF.
    CALL FUNCTION 'ZBASIS_GET_WP_INFO'
      EXPORTING
        servername = lt_servername
      IMPORTING
        wplist     = et_entityset.



  ENDMETHOD.
ENDCLASS.
