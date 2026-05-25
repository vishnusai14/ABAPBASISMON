FUNCTION ZTEST2.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(EID) TYPE  ZEMPID
*"  EXPORTING
*"     REFERENCE(EMPTABLE) TYPE  ZEMPTAB
*"  CHANGING
*"     REFERENCE(NUM) TYPE  ZEMPAGE
*"----------------------------------------------------------------------


SELECT eid, ename, eage FROM zemployee INTO TABLE @EMPTABLE WHERE eid = @EID.

num = num + 20.



ENDFUNCTION.
