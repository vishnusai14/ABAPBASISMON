*&---------------------------------------------------------------------*
*& Include          ZBGMONSUBROUTINE
*&---------------------------------------------------------------------*

*This will get the Job details .
FORM get_job_detail_and_update_icon.

  CLEAR: tmp_jobdetails, it_jobdetails, wa_jobdetail, tmpwa_jobdetail, lv_failedjob, lv_successjob.

  CALL FUNCTION 'ZBASIS_BG_MON'
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




    CALL FUNCTION 'ZBP_JOB_LOG'
      EXPORTING
        jobcount  = wa_singlejobdetail-jobcount
        jobname   = wa_singlejobdetail-jobname
      IMPORTING
        joblogtbl = it_joblog.

    DESCRIBE TABLE it_joblog LINES tblog-lines.

    CALL SCREEN 0133.

  ENDIF.


ENDFORM.
