*&---------------------------------------------------------------------*
*& Include ZBGMONPROGTOP                            - Module Pool      ZBGMONPROG
*&---------------------------------------------------------------------*
PROGRAM zbgmonprog.
*&---------------------------------------------------------------------*
*& Module STATUS_0130 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

DATA: it_jobdetails   TYPE TABLE OF zbgmonstruc,
      wa_jobdetail    TYPE zbgmonstruc,
      jobnameio       TYPE tbtco-jobname,
      startdateio     TYPE tbtco-strtdate,
      tmp_jobdetails  TYPE TABLE OF tbtco,
      tmpwa_jobdetail TYPE tbtco,
      lv_failedjob    TYPE zstatusjobcount VALUE 0,
      lv_successjob   TYPE zstatusjobcount VALUE 0,
      lv_screen       TYPE sy-dynnr VALUE '0130',
      lv_tab          TYPE i VALUE 1,
      it_lockdetails  TYPE TABLE OF zsm12,
      wa_lockdetail   TYPE zsm12,
      ws_field        TYPE c LENGTH 30,
      ws_idx          TYPE i,
      it_joblog       TYPE TABLE OF ztbtc5,
      wa_joblog       TYPE ztbtc5.

DATA: jobnamerow   TYPE btcjob,
      statusrow    TYPE btcstatus,
      startdaterow TYPE btcxdate,
      joblogrow    TYPE zlogstrtype,
      jobcountrow  TYPE btcjobcnt,
      bgicon       TYPE icons-text,
      lv_iconname  TYPE char30,
      clientrow    TYPE eqeclient,
      zuserrow     TYPE eqeuname,
      tcoderow     TYPE eqetcode,
      ztablerow    TYPE eqeobj,
      lockmoderow  TYPE eqegramode,
      zdaterow     TYPE eqedate,
      logtimerow   TYPE btcetime,
      logdaterow   TYPE btcedate,
      logidrow     TYPE symsgid,
      logrow       TYPE btctxuncod.



CONTROLS: table1   TYPE TABLEVIEW USING SCREEN 0131,
          tsc1     TYPE TABSTRIP,
          zsm12tab TYPE TABLEVIEW USING SCREEN 0132,
          tblog    TYPE TABLEVIEW USING SCREEN 0133.



*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0130  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0130 INPUT.

  CASE sy-ucomm.
    WHEN 'EXEC'.

      IF startdateio IS INITIAL.
        startdateio = sy-datum.
      ENDIF.

      PERFORM get_job_detail_and_update_icon.

  ENDCASE.

ENDMODULE.


MODULE zexit INPUT.

  CASE sy-ucomm.
    WHEN 'EXIT' OR 'CANCEL'.
      LEAVE PROGRAM.
  ENDCASE.

ENDMODULE.
*&---------------------------------------------------------------------*
*& Module TABLEMAPPING OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE tablemapping OUTPUT.
  jobnamerow = wa_jobdetail-jobname.
  statusrow = wa_jobdetail-jobstatus.
  startdaterow = wa_jobdetail-startdate.
  joblogrow = wa_jobdetail-joblog.
  jobcountrow = wa_jobdetail-jobcount.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module POPULATE_INITIAL_0130 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE populate_initial_0130 OUTPUT.

  startdateio = sy-datum.
  PERFORM get_job_detail_and_update_icon.

ENDMODULE.
*&---------------------------------------------------------------------*
*& Module STATUS_0120 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0120 OUTPUT.
  SET PF-STATUS 'ZBGMONGUI1'.
  SET TITLEBAR 'ZBGMONT1'.
*  tsc1-activetab = 'BGMON'.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module CALL_SCREEN_0120 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0120  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0120 INPUT.
  CASE sy-ucomm.
    WHEN 'BACK'.
      LEAVE PROGRAM.
    WHEN 'SM12'.
      IF lv_tab EQ 1.
        lv_tab  = 2.
        tsc1-activetab = 'SM12'.
        lv_screen = '0132'.
      ENDIF.
    WHEN 'BGMON'.
      IF lv_tab EQ 2.
        lv_tab  = 1.
        tsc1-activetab = 'BGMON'.
        lv_screen = '0130'.
      ENDIF.



  ENDCASE.
ENDMODULE.


MODULE exit_command_0120 INPUT.
  CASE sy-ucomm.
    WHEN 'EXIT' OR 'CANCEL'.
      LEAVE PROGRAM.
  ENDCASE.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module ZSM12MAPPING OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE zsm12mapping OUTPUT.
  clientrow = wa_lockdetail-client.
  zuserrow = wa_lockdetail-zuser.
  tcoderow = wa_lockdetail-tcode.
  ztablerow = wa_lockdetail-ztable.
  lockmoderow = wa_lockdetail-lockmode.
  zdaterow = wa_lockdetail-zdate.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0132  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0132 INPUT.

  CASE sy-ucomm.
    WHEN 'GETLOCK'.

      CLEAR: it_lockdetails, wa_lockdetail.

      CALL FUNCTION 'ZBASIS_SM12_MON'
        IMPORTING
          lock_details = it_lockdetails.


  ENDCASE.

ENDMODULE.
*&---------------------------------------------------------------------*
*& Module STATUS_0131 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0131 OUTPUT.
  SET PF-STATUS 'ZBGMONGUI2'.
* SET TITLEBAR 'xxx'.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0131  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0131 INPUT.

  CASE sy-ucomm.
    WHEN 'DBCLICK'.
      REFRESH: it_jobloG.
      CLEAR: ws_field, ws_idx, it_joblog, wa_joblog.
      GET CURSOR FIELD ws_field LINE ws_idx.
      PERFORM get_job_logs.
  ENDCASE.

ENDMODULE.
*&---------------------------------------------------------------------*
*& Module STATUS_0133 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0133 OUTPUT.
  SET PF-STATUS 'ZBGMONGUI2'.
* SET TITLEBAR 'xxx'.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0133  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0133 INPUT.


  CASE sy-ucomm.
    WHEN 'BACK1'.
      CLEAR: ws_field, ws_idx, it_joblog, wa_joblog.
      SET SCREEN 0.
  ENDCASE.

ENDMODULE.
*&---------------------------------------------------------------------*
*& Module LOGTABLEMAPPING OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE logtablemapping OUTPUT.



  logtimerow = wa_joblog-entertime.
  logdaterow = wa_joblog-enterdate.
  logidrow = wa_joblog-msgid.
  logrow = wa_joblog-text.



ENDMODULE.
