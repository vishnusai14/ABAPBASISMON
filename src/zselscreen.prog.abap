*&---------------------------------------------------------------------*
*& Include          ZSELSCREEN
*&---------------------------------------------------------------------*

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.

  PARAMETERS: p_d1 TYPE ZEMPLOYEE-EID,
              p_d2 TYPE ZEMPLOYEE-EAGE.


SELECTION-SCREEN END OF BLOCK b1.


DATA: it_emp TYPE zemptab.
