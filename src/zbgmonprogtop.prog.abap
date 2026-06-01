*&---------------------------------------------------------------------*
*& Include ZBGMONPROGTOP                            - Module Pool      ZBGMONPROG
*&---------------------------------------------------------------------*
PROGRAM zbgmonprog.
*&---------------------------------------------------------------------*
*& Module STATUS_0130 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

DATA: it_jobdetails         TYPE TABLE OF zbgmonstruc,
      wa_jobdetail          TYPE zbgmonstruc,
      jobnameio             TYPE tbtco-jobname,
      startdateio           TYPE tbtco-strtdate,
      tmp_jobdetails        TYPE TABLE OF tbtco,
      tmpwa_jobdetail       TYPE tbtco,
      lv_failedjob          TYPE zstatusjobcount VALUE 0,
      lv_successjob         TYPE zstatusjobcount VALUE 0,
      lv_screen             TYPE sy-dynnr VALUE '0130',
      lv_tab                TYPE i VALUE 1,
      it_lockdetails        TYPE TABLE OF zsm12,
      wa_lockdetail         TYPE zsm12,
      ws_field              TYPE c LENGTH 30,
      ws_idx                TYPE i,
      it_joblog             TYPE TABLE OF ztbtc5,
      wa_joblog             TYPE ztbtc5,
      it_serverdetails      TYPE zsm51tab,
      wa_serverdetail       LIKE LINE OF it_serverdetails,
      it_singleserverdetail TYPE TABLE OF zsm50,
      wa_singleserverdetail TYPE zsm50,
      lv_serverscount       TYPE i.

DATA: jobnamerow    TYPE btcjob,
      statusrow     TYPE btcstatus,
      startdaterow  TYPE btcxdate,
      joblogrow     TYPE zlogstrtype,
      jobcountrow   TYPE btcjobcnt,
      bgicon        TYPE icons-text,
      lv_iconname   TYPE char30,
      clientrow     TYPE eqeclient,
      zuserrow      TYPE eqeuname,
      tcoderow      TYPE eqetcode,
      ztablerow     TYPE eqeobj,
      lockmoderow   TYPE eqegramode,
      zdaterow      TYPE eqedate,
      logtimerow    TYPE btcetime,
      logdaterow    TYPE btcedate,
      logidrow      TYPE symsgid,
      logrow        TYPE btctxuncod,
      sm51name      TYPE msname2,
      sm51host      TYPE mshost2,
      sm51serv      TYPE msserv,
      sm51type      TYPE mstypes,
      sm51adr       TYPE mshostadr,
      sm51no        TYPE msservno,
      sm51state     TYPE msstate,
      zsm50wptyp    TYPE wptyP,
      zsm50wppid    TYPE wppid,
      zsm50wpstatus TYPE wpstatus,
      zsm50wpreport TYPE wpreport,
      zsm50wpbname  TYPE wpbname.




CONTROLS: table1       TYPE TABLEVIEW USING SCREEN 0131,
          tsc1         TYPE TABSTRIP,
          zsm12tab     TYPE TABLEVIEW USING SCREEN 0132,
          tblog        TYPE TABLEVIEW USING SCREEN 0133,
          zsm51tabview TYPE TABLEVIEW USING SCREEN 0134,
          zsm50tabview TYPE TABLEVIEW USING SCREEN 0135.



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
      IF lv_tab EQ 1 OR lv_tab EQ 3.
        lv_tab  = 2.
        tsc1-activetab = 'SM12'.
        lv_screen = '0132'.
      ENDIF.
    WHEN 'BGMON'.
      IF lv_tab EQ 2 OR lv_tab EQ 3.
        lv_tab  = 1.
        tsc1-activetab = 'BGMON'.
        lv_screen = '0130'.
      ENDIF.
    WHEN 'SM51'.
      IF lv_tab EQ 1 OR lv_tab EQ 2.
        lv_tab = 3.
        tsc1-activetab = 'SM51'.
        lv_screen = '0134'.
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

      CALL FUNCTION 'ZBASIS_GET_LOCKS_DETAILS'
        IMPORTING
          lockdetails = it_lockdetails.


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
      MESSAGE 'Double Click' TYPE 'I'.
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
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0134  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0134 INPUT.

  CASE sy-ucomm.
    WHEN 'GETSRVDETAILS'.

      CLEAR: it_serverdetails, wa_serverdetail.

      CALL FUNCTION 'ZBASIS_GET_SERVER_LIST'
        IMPORTING
          list = it_serverdetails.

      DESCRIBE TABLE it_serverdetails LINES zsm51tabview-lines.
      DESCRIBE TABLE it_serverdetails LINES lv_serverscount.
    WHEN 'DBCLICK'.
      REFRESH: it_singleserverdetail.
      CLEAR: ws_field, ws_idx, it_singleserverdetail, wa_singleserverdetail.
      GET CURSOR FIELD ws_field LINE ws_idx.

      PERFORM get_single_server_detail.

  ENDCASE.


ENDMODULE.
*&---------------------------------------------------------------------*
*& Module ZSM51MAPPING OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE zsm51mapping OUTPUT.

  sm51name = wa_serverdetail-name.
  sm51host = wa_serverdetail-host.
  sm51serv = wa_serverdetail-serv.
  sm51type = wa_serverdetail-msgtypes.
  sm51adr  = wa_serverdetail-hostadr.
  sm51no   = wa_serverdetail-servno.
  sm51state = wa_serverdetail-state.

ENDMODULE.
*&---------------------------------------------------------------------*
*& Module STATUS_0134 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0134 OUTPUT.
  SET PF-STATUS 'ZBGMONGUI4'.
* SET TITLEBAR 'xxx'.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module STATUS_0135 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0135 OUTPUT.
  SET PF-STATUS 'ZBGMONGUI5'.
* SET TITLEBAR 'xxx'.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0135  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0135 INPUT.
  CASE sy-ucomm.
    WHEN 'BACK2'.
      CLEAR: ws_field, ws_idx, it_singleserverdetail, wa_singleserverdetail.
      SET SCREEN 0.
  ENDCASE.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module ZSINGLESERVERMAPPING OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE zsingleservermapping OUTPUT.

  zsm50wptyp = wa_singleserverdetail-wp_typ.
  zsm50wppid = wa_singleserverdetail-wp_pid.
  zsm50wpstatus = wa_singleserverdetail-wp_status.
  zsm50wpreport = wa_singleserverdetail-wp_report.
  zsm50wpbname = wa_singleserverdetail-wp_bname.





ENDMODULE.
