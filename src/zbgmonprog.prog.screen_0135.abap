PROCESS BEFORE OUTPUT.

  LOOP AT it_singleserverdetail INTO wa_singleserverdetail WITH
CONTROL zsm50tabview.
    MODULE ZSINGLESERVERMAPPING.
  ENDLOOP.

  MODULE status_0135.

PROCESS AFTER INPUT.
  LOOP.
  ENDLOOP.

  MODULE user_command_0135.
