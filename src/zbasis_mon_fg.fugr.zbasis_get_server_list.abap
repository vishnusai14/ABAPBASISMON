FUNCTION ZBASIS_GET_SERVER_LIST.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  EXPORTING
*"     VALUE(LIST) TYPE  ZSM51TAB
*"----------------------------------------------------------------------


CALL FUNCTION 'TH_SERVER_LIST'
 EXPORTING
   ACTIVE_SERVER         = 1
 TABLES
   LIST                  = LIST
 EXCEPTIONS
   NO_SERVER_LIST        = 1
   OTHERS                = 2.
IF sy-subrc <> 0.
  CLEAR: LIST.
ENDIF.



ENDFUNCTION.
