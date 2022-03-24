CLASS zcl_ws_modernabap_cast DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
    METHODS old_version IMPORTING out TYPE REF TO if_oo_adt_classrun_out OPTIONAL.
    METHODS new_version IMPORTING out TYPE REF TO if_oo_adt_classrun_out OPTIONAL.
  PRIVATE SECTION.
    DATA: value_attribute TYPE c LENGTH 4.
ENDCLASS.



CLASS zcl_ws_modernabap_cast IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.


    old_version( out ).

    new_version( out ).

  ENDMETHOD.

  METHOD old_version.


    DATA: class_runner TYPE REF TO if_oo_adt_classrun.
    DATA: ws_demo TYPE REF TO zcl_ws_modernabap_cast.

    class_runner = me.
    ws_demo ?= class_runner.
    ws_demo->value_attribute = 'Domi'.

    DATA: dref TYPE REF TO data.
    dref = NEW i( 7411 ).

    FIELD-SYMBOLS <integer> TYPE i.

    ASSIGN dref->* TO <integer>.

*    out->write( dref->* ).
    out->write( <integer> ).

  ENDMETHOD.

  METHOD new_version.

    DATA: class_runner TYPE REF TO if_oo_adt_classrun.
    class_runner = me.


    CAST zcl_ws_modernabap_cast( class_runner )->value_attribute = 'Domi'.


    DATA: dref TYPE REF TO data.
    dref = NEW i( 7411 ).

    out->write( cast i( dref )->* ).

  ENDMETHOD.

ENDCLASS.
