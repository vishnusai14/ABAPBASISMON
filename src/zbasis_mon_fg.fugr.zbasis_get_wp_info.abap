FUNCTION zbasis_get_wp_info.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(SERVERNAME) TYPE  MSNAME2
*"  EXPORTING
*"     VALUE(WPLIST) TYPE  ZSM50TAB
*"----------------------------------------------------------------------

  DATA: tmplist   TYPE TABLE OF wpinfo,
        wa_wplist TYPE zsm50.

  CALL FUNCTION 'TH_WPINFO'
    EXPORTING
      srvname    = servername
*     WITH_CPU   = 0
*     WITH_MTX_INFO       = 0
*     MAX_ELEMS  = 0
    TABLES
      wplist     = tmplist
    EXCEPTIONS
      send_error = 1
      OTHERS     = 2.




  IF sy-subrc <> 0.
    CLEAR: wplist.
  ENDIF.


  LOOP AT tmplist INTO DATA(wa_tmp).

    wa_wplist-wp_typ = wa_tmp-wp_typ.
    wa_wplist-wp_pid  = wa_tmp-wp_pid.
    wa_wplist-wp_status = wa_tmp-wp_status.
    wa_wplist-wp_report = wa_tmp-wp_report.
    wa_wplist-wp_bname = wa_tmp-wp_bname.

    APPEND wa_wplist TO wplist.

    CLEAR: wa_wplist.

  ENDLOOP.

ENDFUNCTION.
