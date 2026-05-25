*&---------------------------------------------------------------------*
*& Include ZEMPCRUDTOP                              - Module Pool      ZEMPCRUD
*&---------------------------------------------------------------------*
PROGRAM ZEMPCRUD.

CONTROLS TSC1 TYPE TABSTRIP.

DATA: IOEID TYPE ZEMPLOYEE-EID,
      IOENAME TYPE ZEMPLOYEE-ENAME,
      IOEAGE TYPE ZEMPLOYEE-EAGE,
      IOEROLE TYPE ZEMPLOYEE-EROLE,
      WA_EMP TYPE ZEMPLOYEE,
      LV_V1 TYPE I VALUE 0, "0 - Hello Tab 1 - Bye Tab
      LV_SCREEN TYPE SY-DYNNR VALUE '0122', " Since by default Tb1 will be selected. We need to associate 0122 to SS1 (Sub Screen Area).
      LV_ID TYPE VRM_ID,
      LV_VALUES TYPE VRM_VALUES,
      WA_VALUE LIKE LINE OF LV_VALUES.
*&---------------------------------------------------------------------*
*& Module STATUS_0120 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0120 OUTPUT.
 SET PF-STATUS 'ZFGUI'.
 SET TITLEBAR 'ZEMPTIT1'.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0120  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0120 INPUT.

  CASE sy-ucomm.
    WHEN 'BACK'.
      LEAVE PROGRAM.
    WHEN 'CREATE'.

      WA_EMP-EID = IOEID.
      WA_EMP-ENAME = IOENAME.
      WA_EMP-EAGE = IOEAGE.
      WA_EMP-EROLE =  IOEROLE.
      WA_EMP-CREATED_ON = SY-DATUM.
      WA_EMP-CREATED_BY = SY-UNAME.
      WA_EMP-CREATED_AT  = SY-UZEIT.
      WA_EMP-LAST_CHANED_BY = SY-UNAME.
      WA_EMP-LAST_CHANED_ON = SY-DATUM.
      WA_EMP-LAST_CHAGED_AT = SY-UZEIT.

      INSERT ZEMPLOYEE FROM WA_EMP.

      CLEAR WA_EMP.

      IF SY-SUBRC EQ 0.
        MESSAGE | { IOEID } has been inserted to Zemployee Table  | TYPE 'I'.
      ELSE.
        MESSAGE | { IOEID } failed to insert | TYPE 'E'.
      ENDIF.

      CLEAR: IOEID, IOENAME, IOEAGE, IOEROLE.

    WHEN 'UPDATE'.



      SELECT SINGLE * FROM ZEMPLOYEE INTO @WA_EMP WHERE EID = @IOEID.

      IF SY-SUBRC EQ 0.
          IF IOEID IS NOT INITIAL.
            IF WA_EMP-EID = IOEID.
              IF IOENAME IS NOT INITIAL.
                WA_EMP-ENAME = IOENAME.
              ENDIF.
              IF IOEAGE IS NOT INITIAL.
                WA_EMP-EAGE = IOEAGE.
              ENDIF.
              IF IOEROLE IS NOT INITIAL.
                WA_EMP-EROLE =  IOEROLE.
              ENDIF.
              WA_EMP-LAST_CHANED_BY = SY-UNAME.
              WA_EMP-LAST_CHANED_ON = SY-DATUM.
              WA_EMP-LAST_CHAGED_AT = SY-UZEIT.
           ENDIF.
           MODIFY ZEMPLOYEE FROM WA_EMP.
           IF SY-SUBRC EQ 0.
             MESSAGE | { IOEID } has been updated| TYPE 'I'.
           ELSE.
             MESSAGE | { IOEID } has not been updated| TYPE 'E'.
           ENDIF.
           CLEAR WA_EMP.
         ENDIF.
      ENDIF.
   WHEN 'HELLO'.
     IF LV_V1 EQ 1.
       TSC1-ACTIVETAB = 'HELLO'.
       LV_SCREEN = '0122'.
       LV_V1 = 0.
     ENDIF.
   WHEN 'BYE'.
     IF LV_V1 EQ 0.
       TSC1-ACTIVETAB = 'BYE'.
       LV_SCREEN = '0123'.
       LV_V1 = 1.
     ENDIF.
  ENDCASE.

ENDMODULE.

MODULE exit_command_0120 INPUT.

  CASE sy-ucomm.
    WHEN 'CANCEL'.
      LEAVE PROGRAM.
  ENDCASE.
ENDMODULE.

MODULE eidhelp INPUT.
  CALL SCREEN 0121 STARTING AT 10 2.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module STATUS_0121 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0121 OUTPUT.
 SET PF-STATUS 'ZFGUI2'.
 SET TITLEBAR 'ZEMPTIT2'.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0121  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0121 INPUT.

  CASE SY-UCOMM.
    WHEN 'CONT'.
      SET SCREEN 0.
      LEAVE SCREEN.
   ENDCASE.

ENDMODULE.
*&---------------------------------------------------------------------*
*& Module STATUS_0122 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0122 OUTPUT.
* SET PF-STATUS 'xxxxxxxx'.
* SET TITLEBAR 'xxx'.

  SELECT EID FROM ZEMPLOYEE INTO TABLE @DATA(TMP_EMP).

  LOOP AT TMP_EMP INTO DATA(WATMP_EMP).
    WA_VALUE-KEY = WATMP_EMP-EID.
    WA_VALUE-TEXT = WATMP_EMP-EID.
    APPEND WA_VALUE TO LV_VALUES.
    CLEAR: WATMP_EMP, WA_VALUE.
  ENDLOOP.

  LV_ID = 'CHCKIO'.

  CALL FUNCTION 'VRM_SET_VALUES'
    EXPORTING
      id                    = LV_ID
      values                = LV_VALUES
*   EXCEPTIONS
*     ID_ILLEGAL_NAME       = 1
*     OTHERS                = 2
            .
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.


ENDMODULE.
