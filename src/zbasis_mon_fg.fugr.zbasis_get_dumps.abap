FUNCTION zbasis_get_dumps.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(FROM_DATE) TYPE  DATUM OPTIONAL
*"     VALUE(TO_DATE) TYPE  DATUM OPTIONAL
*"  EXPORTING
*"     REFERENCE(DUMPS) TYPE  ZSNAP_TAB
*"----------------------------------------------------------------------


  DATA: it_dumps          TYPE TABLE OF /sdf/e2e_log_struc,
        wa_dump           TYPE /sdf/e2e_log_struc,
        wa_restucturedump TYPE zsnap_struc.

  IF FROM_DATE IS INITIAL.
    FROM_DATE = SY-DATUM.
  ENDIF.

  IF TO_DATE IS INITIAL.
    TO_DATE = SY-DATUM.
  ENDIF.


  CALL FUNCTION '/SDF/GET_DUMP_LOG'
    EXPORTING
      date_from  = from_date
*     TIME_FROM  = '000000'
      date_to    = to_date
*     TIME_TO    = '235959'
* IMPORTING
*     ES_E2E_LOG_STRUCT_DESC       =
    TABLES
      et_e2e_log = it_dumps
*     TRANSIDS   =
* EXCEPTIONS
*     NOT_AUTHORIZED               = 1
*     NO_VALID_DATE                = 2
*     NO_DATA_FOUND                = 3
*     OTHERS     = 4
    .
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.


  LOOP AT it_dumps INTO wa_dump.
    wa_restucturedump-zdate = wa_dump-e2e_date.
    wa_restucturedump-ztime = wa_dump-e2e_time.
    SPLIT wa_dump-e2e_user AT '_' INTO DATA(iv_user) DATA(iv_client).
    wa_restucturedump-zuser = iv_user.
    wa_restucturedump-zclient = iv_client.
    wa_restucturedump-zhost = wa_dump-e2e_host.
    wa_restucturedump-zdump = wa_dump-field1.
    wa_restucturedump-zprog = wa_dump-field4.
    APPEND wa_restucturedump TO dumps.
    CLEAR: wa_restucturedump.
  ENDLOOP.




ENDFUNCTION.
