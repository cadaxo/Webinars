CLASS zcl_ws_modernabap_new_data DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
    METHODS old_version IMPORTING out TYPE REF TO if_oo_adt_classrun_out OPTIONAL.
    METHODS new_version IMPORTING out TYPE REF TO if_oo_adt_classrun_out OPTIONAL.
    METHODS more_complex IMPORTING out TYPE REF TO if_oo_adt_classrun_out OPTIONAL.
ENDCLASS.



CLASS zcl_ws_modernabap_new_data IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.


    " NEW Operator

    " Data Object

    old_version( out ).

    new_version( out ).
    more_complex( out ).
  ENDMETHOD.

  METHOD old_version.

    FIELD-SYMBOLS <integer> TYPE i.
    DATA int_dref1 TYPE REF TO data. "TYPE REF TO i.

    CREATE DATA int_dref1 TYPE i.
    ASSIGN int_dref1->* TO <integer>.

    <integer> = 123.

  ENDMETHOD.

  METHOD new_version.

    DATA(int_dref2) = NEW i( 456 ).

  ENDMETHOD.

  METHOD more_complex.

    " more complex
    DATA(but000_ref) = NEW but000( ).
    but000_ref->partner = '1234567890'.

    ASSIGN COMPONENT 'PARTNER' OF STRUCTURE but000_ref TO FIELD-SYMBOL(<s>).

    DATA(but000s) = NEW bup_but000_t( ).
    INSERT but000_ref->* INTO TABLE but000s->*.



    DATA(but000_datas) = NEW bup_but000_t( ( partner = '1234567890' ) ).



    IF but000_datas = but000s.
      out->write( 'references are equal!' ).
    ELSE.
      out->write( 'references are NOT equal!' ).
    ENDIF.
    IF but000_datas->* = but000s->*.
      out->write( 'tables are equal!' ).
    ELSE.
      out->write( 'tables are NOT equal!' ).
    ENDIF.


  ENDMETHOD.


ENDCLASS.
