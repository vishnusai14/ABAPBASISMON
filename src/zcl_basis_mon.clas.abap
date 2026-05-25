class ZCL_BASIS_MON definition
  public
  final
  create public .

public section.

  class-methods ZGET_BGJOB_DETAILS
    importing
      value(JOBNAME) type TBTCO-JOBNAME
      value(STARTDATE) type TBTCO-STRTDATE
    exporting
      !JOBDETAILS type ZBGJOB
      !SUCCESSJOB type ZSTATUSJOBCOUNT
      !FAILEDJOB type ZSTATUSJOBCOUNT .
protected section.
private section.
ENDCLASS.



CLASS ZCL_BASIS_MON IMPLEMENTATION.


  method ZGET_BGJOB_DETAILS.

      successjob = 0.
  failedjob = 0.

  DATA: tmp_jobdetails TYPE TABLE OF tbtco,
        wa_jobdetail   TYPE zbgmonstruc,
        lv_failedjob   TYPE i VALUE 0,
        lv_successjob  TYPE i VALUE 0.

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
    successjob = lv_successjob.
    failedjob = lv_failedjob.




  ENDLOOP.

  endmethod.
ENDCLASS.
