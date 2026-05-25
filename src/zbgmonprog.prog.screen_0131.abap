PROCESS BEFORE OUTPUT.


  LOOP AT it_jobdetails INTO wa_jobdetail WITH CONTROL table1.

    MODULE tablemapping.

  ENDLOOP.
* MODULE STATUS_0131.
*
PROCESS AFTER INPUT.
  LOOP .

  ENDLOOP.
  MODULE user_command_0131.
