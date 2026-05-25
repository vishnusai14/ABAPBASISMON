*&---------------------------------------------------------------------*
*& Report ZPRINTER
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprinter.





DATA: it_printer TYPE TABLE OF tsp03d,
      wa_printer TYPE tsp03d,
      lo_alv     TYPE REF TO cl_salv_table,
      msg        TYPE string.


SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE text-001.

  PARAMETERS: p_name   TYPE tsp03d-name,
              p_sname  TYPE tsp03d-padest,
              p_type   TYPE tsp03d-patype,
              p_pahost TYPE tsp03d-palpdhost DEFAULT 'vhcalnplci',
              p_method TYPE tsp03d-pamethod,
              p_msg    TYPE tsp03d-pamsg,
              p_server TYPE tsp03d-pamsserver  DEFAULT 'vhcala4hci_A4H_00',
              p_action TYPE zaction-action DEFAULT 'R'.


SELECTION-SCREEN END OF BLOCK b1.

START-OF-SELECTION.


  CASE p_action.

    WHEN 'R'.

      IF p_name IS INITIAL AND p_sname IS INITIAL.
        MESSAGE 'Give either Long or Short Name' TYPE 'I'.
      ELSE.
        SELECT name padest patype pamsg pamsserver pamethod palpdhost
              FROM tsp03d INTO TABLE it_printer WHERE name LIKE p_name
              OR padest LIKE p_sname.
        PERFORM zprinttable.
      ENDIF.

    WHEN 'D'.

      IF p_name IS INITIAL AND p_sname IS INITIAL.
        MESSAGE 'Give either Long or Short Name' TYPE 'I'.
      ELSE.
        IF p_name IS INITIAL.
          DELETE FROM tsp03d WHERE padest = p_sname.
        ELSE.
          DELETE FROM tsp03d WHERE padest = p_name.
        ENDIF.

        IF sy-subrc EQ 0.
          CONCATENATE p_name p_sname ' Deleted Successfully ' INTO msg.
          MESSAGE msg TYPE 'I'.
        ELSE.
          CONCATENATE p_name p_sname ' not Deleted Succesfully' INTO msg.
          MESSAGE msg TYPE 'E'.
        ENDIF.

      ENDIF.

    WHEN 'C'.
      IF p_name IS INITIAL OR p_sname IS INITIAL OR p_type IS INITIAL OR p_method IS INITIAL.
        MESSAGE 'Enter all the required field (Only message is optional) ' TYPE 'I'.
      ELSE.
        CLEAR wa_printer.
        wa_printer-name = p_name.
        wa_printer-padest = p_sname.
        wa_printer-patype = p_type.
        wa_printer-pamsg = p_msg.
        wa_printer-pamsserver = p_server.
        wa_printer-pamethod = p_method.
        wa_printer-palpdhost = p_pahost.
        wa_printer-paprosname = p_name.


        CLEAR it_printer.

        SELECT * FROM tsp03d INTO TABLE it_printer WHERE padest = p_sname OR name = p_name.


        IF it_printer IS NOT INITIAL.
          MESSAGE 'There is another printer exists with same Long Name or Short Name'  TYPE 'E'.
        ELSE.


          INSERT tsp03d FROM wa_printer.
          CLEAR: wa_printer.

          IF sy-subrc EQ 0.
            MESSAGE 'Printer added Succesfully' TYPE 'I'.
          ELSE.
            MESSAGE 'Internal Error Occured' TYPE 'E'.
          ENDIF.
        ENDIF.


      ENDIF.


    WHEN 'U'.
      BREAK-POINT.
      CLEAR sy-subrc.
      IF p_name IS INITIAL AND p_sname IS INITIAL.
        MESSAGE 'Give either Long or Short Name' TYPE 'I'.
      ELSE.
        CLEAR : wa_printer.

        SELECT SINGLE * FROM tsp03d INTO wa_printer WHERE name = p_name OR padest = p_sname.
        IF p_name IS NOT INITIAL.
          wa_printer-name = p_name.
        ENDIF.
        IF p_sname IS NOT INITIAL.
          wa_printer-padest = p_sname.
        ENDIF.
        IF p_type IS NOT INITIAL.
          wa_printer-patype = p_type.
        ENDIF.
        IF p_msg IS NOT INITIAL.
           wa_printer-pamsg = p_msg.
        ENDIF.

        UPDATE tsp03d FROM wa_printer.

        IF sy-subrc EQ 0.
          MESSAGE 'Updated Succesful' TYPE 'I'.
        ELSE.
          MESSAGE 'Updated Not Succesful' TYPE 'E'.
        ENDIF.
      ENDIF.










  ENDCASE.





END-OF-SELECTION.


AT SELECTION-SCREEN OUTPUT.
  LOOP AT SCREEN.
    IF screen-name = 'P_SERVER' OR screen-name = 'P_HOST' OR screen-name = 'P_PAHOST'.
      screen-input = 0. "0 = non-editable, 1 = editable
      MODIFY SCREEN.
    ENDIF.
  ENDLOOP.



FORM zprinttable.

  TRY.
      cl_salv_table=>factory(
        IMPORTING
              r_salv_table = lo_alv
        CHANGING
              t_table      = it_printer
        ).

      lo_alv->get_columns( )->set_optimize( abap_true ).
      lo_alv->display( ).

    CATCH cx_salv_msg INTO DATA(lx_msg).
      MESSAGE lx_msg->get_text( ) TYPE 'E'.
  ENDTRY.


ENDFORM.



*CLASS zcl_alv_display DEFINITION
*  PUBLIC
*  FINAL
*  CREATE PUBLIC.
*
*  PUBLIC SECTION.
*    " Static method to display any internal table in ALV
*    CLASS-METHODS display_itab
*      IMPORTING
*        it_data TYPE STANDARD TABLE
*        OPTIONAL.
*ENDCLASS.
*
*CLASS zcl_alv_display IMPLEMENTATION.
*  METHOD display_itab.
*    DATA: lo_alv TYPE REF TO cl_salv_table.
*
*    TRY.
*        " Create ALV from the passed internal table
*        cl_salv_table=>factory(
*          IMPORTING
*            r_salv_table = lo_alv
*          CHANGING
*            t_table      = it_data
*        ).
*
*        " Optional: Optimize column widths
*        lo_alv->get_columns( )->set_optimize( abap_true ).
*
*        " Display the ALV
*        lo_alv->display( ).
*
*      CATCH cx_salv_msg INTO DATA(lx_msg).
*        MESSAGE lx_msg->get_text( ) TYPE 'E'.
*    ENDTRY.
*  ENDMETHOD.
*ENDCLASS.
*
*"-------------------------------
*" Example usage in a report
*"-------------------------------
*REPORT ztest_alv_class.
*
*TYPES: BEGIN OF ty_sflight,
*         carrid TYPE sflight-carrid,
*         connid TYPE sflight-connid,
*         fldate TYPE sflight-fldate,
*         price  TYPE sflight-price,
*       END OF ty_sflight.
*
*DATA: lt_sflight TYPE STANDARD TABLE OF ty_sflight.
*
*" Fetch some demo data
*SELECT carrid connid fldate price
*  FROM sflight
*  INTO TABLE @lt_sflight
*  UP TO 20 ROWS.
*
*" Call the class method to display
*zcl_alv_display=>display_itab( lt_sflight ).
