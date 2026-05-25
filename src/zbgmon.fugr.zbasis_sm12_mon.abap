FUNCTION zbasis_sm12_mon.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  EXPORTING
*"     REFERENCE(LOCK_DETAILS) TYPE  ZSM12_TAB
*"----------------------------------------------------------------------

  DATA: it_locktab TYPE ZSEQG3_TAB,
        wa_lockdetailtab TYPE ZSM12.
  CALL FUNCTION 'ENQUEUE_READ'
    TABLES
      enq    = it_locktab
    EXCEPTIONS
      OTHERS = 1.
  IF sy-subrc = 0.
    LOOP AT it_locktab INTO DATA(ls_lock).
      CLEAR: wa_lockdetailtab.
      wa_lockdetailtab-CLIENT = ls_lock-GCLIENT.
      wa_lockdetailtab-ZUSER = ls_lock-GUNAME.
      wa_lockdetailtab-TCODE = ls_lock-GTCODE.
      wa_lockdetailtab-ZTABLE = ls_lock-GOBJ.
      wa_lockdetailtab-LOCKMODE = ls_lock-GMODE.
      wa_lockdetailtab-ZDATE = ls_lock-GTDATE.
      APPEND wa_lockdetailtab TO lock_details.
    ENDLOOP.
  ENDIF.




ENDFUNCTION.
