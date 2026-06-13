*&---------------------------------------------------------------------*
*& Include          ZBGMONSUBROUTINE
*&---------------------------------------------------------------------*

*This will get the Job details .
FORM get_job_detail_and_update_icon.

  CLEAR: tmp_jobdetails, it_jobdetails, wa_jobdetail, tmpwa_jobdetail, lv_failedjob, lv_successjob.

  CALL FUNCTION 'ZBASIS_BG_GET_JOBDETAILS'
    EXPORTING
      jobname    = jobnameio
      startdate  = startdateio
    IMPORTING
      jobdetails = it_jobdetails
      successjob = lv_successjob
      failedjob  = lv_failedjob.




  IF lv_failedjob = 0.
    lv_iconname = icon_green_light.
  ELSEIF lv_failedjob > lv_successjob.
    lv_iconname = icon_red_light.
  ELSE.
    lv_iconname = icon_yellow_light.

  ENDIF.

  CALL FUNCTION 'ICON_CREATE'
    EXPORTING
      name   = lv_iconname
    IMPORTING
      result = bgicon.





ENDFORM.
*&---------------------------------------------------------------------*
*& Form GET_JOB_LOGS
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM get_job_logs .

  IF ws_field = 'JOBNAMEROW' AND ws_idx > 0 AND ws_idx <= lv_failedjob + lv_successjob.

    DATA(wa_singlejobdetail) = it_jobdetails[ ws_idx ].




    CALL FUNCTION 'ZBASIS_BG_GET_JOB_LOG_DETAILS'
      EXPORTING
        jobcount = wa_singlejobdetail-jobcount
        jobname  = wa_singlejobdetail-jobname
      IMPORTING
        joblog   = it_joblog.

    DESCRIBE TABLE it_joblog LINES tblog-lines.

    CALL SCREEN 0133.

  ENDIF.


ENDFORM.




*&---------------------------------------------------------------------*
*& Form get_single_server_detail
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM get_single_server_detail .

  IF ws_field = 'SM51NAME' AND ws_idx > 0 AND ws_idx <= lv_serverscount.

    DATA(wa_singleserver) = it_serverdetails[ ws_idx ].

    CALL FUNCTION 'ZBASIS_GET_WP_INFO'
      EXPORTING
        servername = wa_singleserver-name
      IMPORTING
        wplist     = it_singleserverdetail.

    CALL SCREEN 0135.

  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form get_st22_and_update_table
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM get_st22_and_update_table .

  CLEAR: it_dumps, wa_dump.

  CALL FUNCTION 'ZBASIS_GET_DUMPS'
    EXPORTING
      from_date = st22io_zdate
      to_date   = st22io_zdateto
    IMPORTING
      dumps     = it_dumps.
  DESCRIBE TABLE it_dumps LINES  zst22tabview-lines.

ENDFORM.
