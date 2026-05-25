FUNCTION ZBP_JOB_LOG_STR.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(JOBCOUNT) TYPE  TBTCJOB-JOBCOUNT
*"     REFERENCE(JOBNAME) TYPE  TBTCJOB-JOBNAME
*"  EXPORTING
*"     REFERENCE(LOGS) TYPE  ZLOGSTRTYPE
*"----------------------------------------------------------------------

DATA: JOBLOG TYPE TABLE OF TBTC5,
      LV_LINE TYPE I,
      LV_COUNTER TYPE I.

CALL FUNCTION 'BP_JOBLOG_READ'
 EXPORTING
   CLIENT                      = SY-MANDT
   JOBCOUNT                    = JOBCOUNT
   JOBNAME                     = JOBNAME
  TABLES
    joblogtbl                   = JOBLOG
 EXCEPTIONS
   CANT_READ_JOBLOG            = 1
   JOBLOG_DOES_NOT_EXIST       = 3.
          .
IF sy-subrc <> 0.

  MESSAGE 'Error Reading the Job Logs' TYPE 'E'.

ELSE.
  DESCRIBE TABLE JOBLOG LINES LV_LINE.

  IF LV_LINE > 1.
    TRY.
      DATA(WA_JOBLOG) = JOBLOG[ LV_LINE - 1 ].
      LOGS = WA_JOBLOG-TEXT.
    CATCH CX_ROOT.
      MESSAGE 'Error Reading the Job Logs' TYPE 'E'.
    ENDTRY.
  ELSE.
    MESSAGE 'Error Reading the Job Logs' TYPE 'E'.
  ENDIF.

ENDIF.



ENDFUNCTION.
