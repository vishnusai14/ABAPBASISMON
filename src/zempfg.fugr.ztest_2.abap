FUNCTION ZTEST_2.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(FIRST_NAME) TYPE  STRING
*"     VALUE(LAST_NAME) TYPE  STRING
*"  EXPORTING
*"     VALUE(NAME) TYPE  STRING
*"----------------------------------------------------------------------


NAME = | { FIRST_NAME } { LAST_NAME } |.



ENDFUNCTION.
