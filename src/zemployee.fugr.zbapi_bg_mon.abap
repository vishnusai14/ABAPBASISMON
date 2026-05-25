FUNCTION zbapi_bg_mon.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(JOBNAME) TYPE  ZBAPI_JOBINPUT-JOBNAME
*"     VALUE(STARTDATE) TYPE  ZBAPI_JOBINPUT-STARTDATE
*"  EXPORTING
*"     VALUE(RETURN) TYPE  BAPIRETURN
*"     VALUE(JOBDETAILS) TYPE  ZBAPI_BTCJOBTABLE
*"----------------------------------------------------------------------

  DATA: tmp_jobdetails TYPE TABLE OF tbtco,
        wa_jobdetail   TYPE zbgmonstruc.


  IF jobname EQ '*'.
    SELECT jobname, jobcount, strtdate, status, joblog FROM tbtco INTO CORRESPONDING FIELDS OF TABLE @tmp_jobdetails WHERE strtdate >= @startdate.
  ELSE.
    SELECT jobname, jobcount, strtdate, status, joblog FROM tbtco INTO CORRESPONDING FIELDS OF TABLE @tmp_jobdetails WHERE strtdate >= @startdate AND jobname = @jobname.
  ENDIF.

  LOOP AT tmp_jobdetails INTO DATA(tmpwa_jobdetail).
    CLEAR: wa_jobdetail.
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


ENDFUNCTION.
