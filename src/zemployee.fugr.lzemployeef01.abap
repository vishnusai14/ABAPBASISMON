*----------------------------------------------------------------------*
***INCLUDE LZEMPLOYEEF01.
*----------------------------------------------------------------------*

FORM SET_CREATED_FILED.

  ZEMPLOYEE-CREATED_ON = sy-datum.
  ZEMPLOYEE-CREATED_BY = sy-uname.
  ZEMPLOYEE-CREATED_AT = sy-uzeit.



ENDFORM.

FORM SET_CHANGED_FIELD.

  BREAK DEVELOPER.

  FIELD-SYMBOLS: <fs_field> TYPE ANY.
  LOOP AT total_m.
   IF <action> EQ 'U'.

    ASSIGN COMPONENT 'LAST_CHAGED_AT' OF STRUCTURE <vim_total_struc> TO <fs_field>.
    <fs_field> = sy-uzeit.

    ASSIGN COMPONENT 'LAST_CHANED_ON' OF STRUCTURE <vim_total_struc> TO <fs_field>.
    <fs_field> = sy-datum.

    ASSIGN COMPONENT 'LAST_CHANED_BY' OF STRUCTURE <vim_total_struc> TO <fs_field>.
    <fs_field> = sy-uname.

     READ TABLE extract WITH KEY <vim_xtotal_key>.

      IF sy-subrc EQ 0.
       extract = total_m.
       MODIFY extract INDEX sy-tabix.
      ENDIF.

     MODIFY total_m.
   ENDIF.
  ENDLOOP.
ENDFORM.
