*&---------------------------------------------------------------------*
*& Report ZDEMO_TIMER
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zdemo_timer.

DATA: go_timer  TYPE REF TO zcl_util_timer,
      gv_active TYPE flag.


SELECTION-SCREEN BEGIN OF BLOCK b0 WITH FRAME TITLE TEXT-t00.

SELECTION-SCREEN SKIP.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-t01.


SELECTION-SCREEN PUSHBUTTON 5(15)  TEXT-b11 USER-COMMAND ini.
SELECTION-SCREEN PUSHBUTTON 30(15) TEXT-b12 USER-COMMAND fin.

SELECTION-SCREEN COMMENT /5(20) comm1.

SELECTION-SCREEN END OF BLOCK b1.

SELECTION-SCREEN SKIP.

SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE TEXT-t02.

PARAMETERS: p_sec    TYPE tzntstmpl MODIF ID m20,
            p_min    TYPE tzntstmpl MODIF ID m20,
            p_hour   TYPE tzntstmpl MODIF ID m20,
            p_hhmmss TYPE syuzeit   MODIF ID m20.

SELECTION-SCREEN END OF BLOCK b2.

SELECTION-SCREEN END OF BLOCK b0.

INITIALIZATION.
  comm1 = '@5C@ Timer parado'.

AT SELECTION-SCREEN OUTPUT.
  PERFORM change_screen.


AT SELECTION-SCREEN.

  CASE sy-ucomm.
    WHEN 'INI'.
      PERFORM start.
    WHEN 'FIN'.
      PERFORM stop.
  ENDCASE.


*&---------------------------------------------------------------------*
*&      Form  CHANGE_SCREEN
*&---------------------------------------------------------------------*
FORM change_screen .

  LOOP AT SCREEN.

    IF screen-group1 EQ 'M10'.
      IF gv_active IS NOT INITIAL.
        screen-invisible = 0.
      ELSE.
        screen-invisible = 1.
      ENDIF.
      MODIFY SCREEN.
    ENDIF.

    IF screen-group1 EQ 'M20'.
      screen-input = 0.
      MODIFY SCREEN.
    ENDIF.

  ENDLOOP.

ENDFORM.


*&---------------------------------------------------------------------*
*&      Form  START
*&---------------------------------------------------------------------*
FORM start .

  CLEAR: go_timer.
  CREATE OBJECT go_timer.

  gv_active = 'X'.

  CLEAR: p_sec, p_min, p_hour, p_hhmmss.

  comm1 = '@5B@ Timer activo'.

ENDFORM.


*&---------------------------------------------------------------------*
*&      Form  STOP
*&---------------------------------------------------------------------*
FORM stop .

  p_sec    = go_timer->stop( ).
  p_min    = go_timer->get_time_min( ).
  p_hour   = go_timer->get_time_hour( ).
  p_hhmmss = go_timer->get_time_uzeit( ).

  CLEAR: gv_active.

  comm1 = '@5C@ Timer parado'.

ENDFORM.
