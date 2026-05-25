FUNCTION ZTEST1.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(EID) TYPE  ZEMPID
*"  EXPORTING
*"     REFERENCE(EMP) TYPE  ZEMPTAB
*"  CHANGING
*"     REFERENCE(AGE) TYPE  ZEMPAGE
*"----------------------------------------------------------------------

SELECT eid, ename, eage FROM ZEMPLOYEE INTO  TABLE @EMP WHERE eid = @EID.

age = age + 10.


ENDFUNCTION.
