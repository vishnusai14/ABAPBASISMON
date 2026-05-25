FUNCTION ZEMPLOYEE_UPDATE_NAME.
*"----------------------------------------------------------------------
*"*"Update Function Module:
*"
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(EIDIMP) TYPE  ZEMPID
*"     VALUE(ENAMEIMP) TYPE  ZEMPNAME
*"  EXCEPTIONS
*"      UPDATE_FAILED
*"----------------------------------------------------------------------


TRY.
  UPDATE ZEMPLOYEE
  SET ENAME = ENAMEIMP
  WHERE EID = EIDIMP.

CATCH CX_ROOT.
  RAISE UPDATE_FAILED.

ENDTRY.




ENDFUNCTION.
