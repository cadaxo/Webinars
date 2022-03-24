CLASS zcl_ws_modernabap_tabl_func DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
    METHODS old_version IMPORTING out TYPE REF TO if_oo_adt_classrun_out OPTIONAL.
    METHODS new_version IMPORTING out TYPE REF TO if_oo_adt_classrun_out OPTIONAL.
ENDCLASS.



CLASS zcl_ws_modernabap_tabl_func IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    " Table Functions

    " !!! NOT CDS Table Functions !!!

    old_version( out ).

    new_version( out ).

  ENDMETHOD.






  METHOD old_version.

    DATA: but000s TYPE STANDARD TABLE OF but000 WITH DEFAULT KEY.


    but000s = VALUE #( ( partner = '1234567891' ) ( partner = '1234567892' ) ).

* Variant 1
    READ TABLE but000s WITH KEY partner = '1234567890' TRANSPORTING NO FIELDS.
    IF sy-subrc = 0.
      ...
    ENDIF.


* Variant 2
    READ TABLE but000s WITH KEY partner = '1234567890' TRANSPORTING NO FIELDS.
    IF sy-subrc = 0.
      DATA(index) = sy-tabix.
      out->write( index ).
      ...
    ENDIF.


* Variant 3
    DATA: line_cnt TYPE i.
    DESCRIBE TABLE but000s LINES line_cnt.
    IF line_cnt > 10.
      ...
    ENDIF.

  ENDMETHOD.
















  METHOD new_version.

    DATA: but000s TYPE STANDARD TABLE OF but000 WITH DEFAULT KEY.


* Variant 1
    IF line_exists( but000s[ partner = '1234567890' ] ).
      ...
    ENDIF.


* Variant 2
    IF line_index( but000s[ partner = '1234567890' ] ) > 0.
      ...
    ENDIF.


* Variant 3
    IF lines( but000s ) > 10.
      ...
    ENDIF.
  ENDMETHOD.
























ENDCLASS.
