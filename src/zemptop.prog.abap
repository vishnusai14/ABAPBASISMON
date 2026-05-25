*&---------------------------------------------------------------------*
*& Include ZEMPTOP                                  - Module Pool      ZEMP
*&---------------------------------------------------------------------*
PROGRAM ZEMP.
*&---------------------------------------------------------------------*
*& Module STATUS_0101 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0101 OUTPUT.
 SET PF-STATUS 'ZEMPGUI1'.
 SET TITLEBAR 'ZEMPT1'.
ENDMODULE.

MODULE user_command_0101 INPUT.

  DATA: EIDIO TYPE ZEMPLOYEE-EID,
        ENAMEIO TYPE ZEMPLOYEE-ENAME,
        EAGEIO TYPE ZEMPLOYEE-EAGE,
        EROLEIO TYPE ZEMPLOYEE-EROLE.

  CASE sy-ucomm.
    WHEN 'BACK' OR 'EXIT'.
      LEAVE PROGRAM.
    WHEN 'GET_DATA'.
      SELECT SINGLE ENAME, EAGE, EROLE FROM ZEMPLOYEE INTO ( @ENAMEIO, @EAGEIO, @EROLEIO ) WHERE EID = @EIDIO.


      IF sy-subrc NE 0.
        MESSAGE |Internal Error Occurer or No Employee with { EIDIO } ID| TYPE 'I'.
      ENDIF.


    WHEN 'CLEAR'.
      CLEAR: EIDIO, ENAMEIO, EAGEIO, EROLEIO.
  ENDCASE.

ENDMODULE.


MODULE ZEXIT INPUT.

  CASE sy-ucomm.
    WHEN 'CANCEL'.
      LEAVE PROGRAM.
  ENDCASE.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  ZHELPEID  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE zhelpeid INPUT.



  CALL FUNCTION 'POPUP_TO_INFORM'
    EXPORTING
      titel         = 'Employee ID'
      txt1          = 'Please Provide the Employee ID here'
      txt2          = 'Employee ID of Type ZEMPID'
*     TXT3          = ' '
*     TXT4          = ' '
            .


ENDMODULE.
