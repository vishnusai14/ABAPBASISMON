FUNCTION zbasis_bg_get_jobdetails.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(JOBNAME) TYPE  BTCJOB OPTIONAL
*"     VALUE(STARTDATE) TYPE  BTCXDATE OPTIONAL
*"  EXPORTING
*"     VALUE(JOBDETAILS) TYPE  ZBGJOB
*"     VALUE(SUCCESSJOB) TYPE  ZSTATUSJOBCOUNT
*"     VALUE(FAILEDJOB) TYPE  ZSTATUSJOBCOUNT
*"     VALUE(JOBSUMMARY) TYPE  ZBGJOBSUMMARYTAB
*"----------------------------------------------------------------------


  successjob = 0.
  failedjob = 0.

  DATA: tmp_jobdetails      TYPE TABLE OF tbtco,
        wa_jobdetail        TYPE zbgmonstruc,
        lv_failedjob        TYPE i VALUE 0,
        lv_successjob       TYPE i VALUE 0,
        wa_jobdetailsummary TYPE zbgjobsummarystruc.

  IF startdate IS INITIAL.
    startdate = sy-datum.
  ENDIF.

  IF jobname IS INITIAL OR jobname EQ '*'.
    SELECT jobname, jobcount, strtdate, status, joblog FROM tbtco INTO CORRESPONDING FIELDS OF TABLE @tmp_jobdetails WHERE strtdate >= @startdate.
  ELSE.
    SELECT jobname, jobcount, strtdate, status, joblog FROM tbtco INTO CORRESPONDING FIELDS OF TABLE @tmp_jobdetails WHERE strtdate >= @startdate AND jobname = @jobname.
  ENDIF.

  LOOP AT tmp_jobdetails INTO DATA(tmpwa_jobdetail).
    CLEAR: wa_jobdetail.
    IF tmpwa_jobdetail-status EQ 'E' OR tmpwa_jobdetail-status EQ 'A' .
      lv_failedjob = lv_failedjob + 1.
    ELSEIF tmpwa_jobdetail-status EQ 'F'.
      lv_successjob = lv_successjob + 1.
    ENDIF.
    wa_jobdetail-jobname = tmpwa_jobdetail-jobname.
    wa_jobdetail-jobstatus = tmpwa_jobdetail-status.
    wa_jobdetail-startdate = tmpwa_jobdetail-strtdate.
    wa_jobdetail-jobname = tmpwa_jobdetail-jobname.
    wa_jobdetail-jobcount = tmpwa_jobdetail-jobcount.

    TRY.
        CALL FUNCTION 'ZBP_JOB_LOG_STR'
          EXPORTING
            jobcount = wa_jobdetail-jobcount
            jobname  = wa_jobdetail-jobname
          IMPORTING
            logs     = wa_jobdetail-joblog.

      CATCH cx_root.
        wa_jobdetail = ''.

    ENDTRY.

    APPEND wa_jobdetail TO jobdetails.

  ENDLOOP.



  wa_jobdetailsummary-failedcount = lv_failedjob.
  wa_jobdetailsummary-successcount = lv_successjob.

  APPEND wa_jobdetailsummary TO jobsummary.



ENDFUNCTION.
