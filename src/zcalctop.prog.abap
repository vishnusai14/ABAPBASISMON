*&---------------------------------------------------------------------*
*& Include ZCALCTOP
*&---------------------------------------------------------------------*

PROGRAM ZCALCTOP.
*&---------------------------------------------------------------------*
*& Module STATUS_0101 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0101 OUTPUT.
 SET PF-STATUS 'ZCALGUI1'.
 SET TITLEBAR 'ZCALTITLE1'.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0101  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0101 INPUT.

  DATA: IO1 TYPE i,
        IO2 TYPE i,
        IO3 TYPE i.

  CASE sy-ucomm.
    WHEN 'BACK'.
      LEAVE PROGRAM.
    WHEN 'EXIT'.
      LEAVE PROGRAM.
    WHEN 'SUM'.
      IO3 = IO1 + IO2.
    WHEN 'MINUS'.
      IO3 = IO1 - IO2.
    WHEN  'PRODUCT'.
      IO3 = IO1 * IO2.
    WHEN 'CLEAR'.
      CLEAR: IO1, IO2, IO3.
  ENDCASE.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  ZEXIT  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE zexit INPUT.

  CASE sy-ucomm.
    WHEN 'CANCEL'.
      LEAVE PROGRAM.
  ENDCASE.

ENDMODULE.
