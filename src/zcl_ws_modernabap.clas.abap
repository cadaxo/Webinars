CLASS zcl_ws_modernabap DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
    METHODS old_version IMPORTING out TYPE REF TO if_oo_adt_classrun_out OPTIONAL.
    METHODS new_version IMPORTING out TYPE REF TO if_oo_adt_classrun_out OPTIONAL.
ENDCLASS.



CLASS zcl_ws_modernabap IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    old_version( out ).

    new_version( out ).

  ENDMETHOD.
  METHOD old_version.


  ENDMETHOD.

  METHOD new_version.

  ENDMETHOD.
ENDCLASS.
