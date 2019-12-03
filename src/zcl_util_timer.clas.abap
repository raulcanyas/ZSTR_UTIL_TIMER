class ZCL_UTIL_TIMER definition
  public
  final
  create public .

public section.

  methods CONSTRUCTOR
    importing
      !IV_START_NOW type FLAG default 'X' .
  methods START .
  methods STOP
    returning
      value(RV_TIME) type TZNTSTMPL .
  methods GET_TIME
    returning
      value(RV_TIME) type TZNTSTMPL .
  methods GET_TIME_MIN
    returning
      value(RV_MIN) type TZNTSTMPL .
  methods GET_TIME_HOUR
    returning
      value(RV_HOUR) type TZNTSTMPL .
  methods GET_TIME_UZEIT
    returning
      value(RV_UZEIT) type SYUZEIT .
protected section.
private section.

  data MV_BEGIN type TIMESTAMPL .
  data MV_END type TIMESTAMPL .
  data MV_TIME type TZNTSTMPL .

  methods CALCULATE .
ENDCLASS.



CLASS ZCL_UTIL_TIMER IMPLEMENTATION.


METHOD calculate.

    TRY.
        " Time Interval in Seconds
        mv_time = cl_abap_tstmp=>subtract( tstmp1 = mv_end
                                           tstmp2 = mv_begin ).
      CATCH cx_parameter_invalid_range.
      CATCH cx_parameter_invalid_type.
    ENDTRY.

  ENDMETHOD.


METHOD constructor.

    IF iv_start_now IS NOT INITIAL.
      start( ).
    ENDIF.

  ENDMETHOD.


METHOD get_time.
    rv_time = mv_time.
  ENDMETHOD.


METHOD get_time_hour.

    rv_hour = mv_time / 3600.

  ENDMETHOD.


METHOD get_time_min.

    rv_min = mv_time / 60.

  ENDMETHOD.


METHOD get_time_uzeit.

    DATA: lv_sec       TYPE n LENGTH 2,
          lv_min       TYPE n LENGTH 2,
          lv_hour      TYPE n LENGTH 2,
          lv_time_sec  TYPE tzntstmpl,
          lv_time_min  TYPE tzntstmpl,
          lv_time_hour TYPE tzntstmpl.

    lv_time_min  = mv_time / 60.
    lv_time_hour = mv_time / 3600.

    lv_min  = trunc( lv_time_min ).
    lv_hour = trunc( lv_time_hour ).

    lv_time_sec = mv_time - ( lv_hour * 3600 ) + ( lv_min * 60 ).
    lv_sec  = trunc( lv_time_sec ).

    CONCATENATE lv_hour lv_min lv_sec INTO rv_uzeit.

  ENDMETHOD.


METHOD start.

    " Tomar tiempo de inicio
    GET TIME STAMP FIELD mv_begin.

  ENDMETHOD.


METHOD stop.

    " Tomar tiempo final
    GET TIME STAMP FIELD mv_end.

    " Calcular Tiempo
    calculate( ).

    rv_time = mv_time.

  ENDMETHOD.
ENDCLASS.
