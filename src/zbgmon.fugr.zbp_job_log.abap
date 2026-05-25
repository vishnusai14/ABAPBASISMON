FUNCTION zbp_job_log.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(JOBCOUNT) TYPE  TBTCJOB-JOBCOUNT
*"     REFERENCE(JOBNAME) TYPE  TBTCJOB-JOBNAME
*"  EXPORTING
*"     REFERENCE(JOBLOGTBL) TYPE  ZTBTC5TAB
*"----------------------------------------------------------------------
  DATA: wa_joblog TYPE ztbtc5,
        jobtbl    TYPE TABLE OF tbtc5.


  CALL FUNCTION 'BP_JOBLOG_READ'
    EXPORTING
      jobcount  = jobcount
      jobname   = jobname
    TABLES
      joblogtbl = jobtbl
    EXCEPTIONS
      OTHERS    = 8.



  IF sy-subrc <> 0.

    MESSAGE 'Error Reading the Job Logs' TYPE 'E'.

  ELSE.

    LOOP AT jobtbl INTO DATA(wa_jobtbl).
      CLEAR:wa_joblog.
      wa_joblog-entertime = wa_jobtbl-entertime.
      wa_joblog-enterdate = wa_jobtbl-enterdate.
      wa_joblog-msgid = wa_jobtbl-msgid.
      wa_joblog-text = wa_jobtbl-text.
      APPEND wa_joblog TO joblogtbl.
    ENDLOOP.





  ENDIF.




ENDFUNCTION.
