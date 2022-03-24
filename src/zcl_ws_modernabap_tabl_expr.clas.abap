CLASS zcl_ws_modernabap_tabl_expr DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
    METHODS old_version IMPORTING out TYPE REF TO if_oo_adt_classrun_out OPTIONAL.
    METHODS new_version IMPORTING out TYPE REF TO if_oo_adt_classrun_out OPTIONAL.

    METHODS old_version_2 IMPORTING out TYPE REF TO if_oo_adt_classrun_out OPTIONAL.
    METHODS new_version_2 IMPORTING out TYPE REF TO if_oo_adt_classrun_out OPTIONAL.
ENDCLASS.



CLASS zcl_ws_modernabap_tabl_expr IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    " Table Expressions

    old_version( out ).

    new_version( out ).

  ENDMETHOD.

  METHOD old_version.

    DATA: but000s TYPE STANDARD TABLE OF but000 WITH DEFAULT KEY
                                                WITH UNIQUE SORTED KEY guid COMPONENTS partner_guid.
    DATA: sorted_but000s TYPE SORTED TABLE OF but000 WITH UNIQUE KEY partner.

* Variant 1
    READ TABLE but000s WITH KEY partner = '1234567890' ASSIGNING FIELD-SYMBOL(<but000>).
    IF sy-subrc = 0.
      ...
    ENDIF.


* Variant 2
    READ TABLE but000s WITH KEY partner = '1234567890' INTO DATA(but000).
    IF sy-subrc = 0.
      ...
    ENDIF.


* Variant 3
    READ TABLE but000s WITH KEY partner = '1234567890' REFERENCE INTO DATA(ref_but000).
    IF sy-subrc = 0.
      ...
    ENDIF.


* Variant 4
    READ TABLE but000s INDEX 1 INTO but000.
    IF sy-subrc = 0.
      ...
    ENDIF.


    old_version_2( out ).
  ENDMETHOD.

  METHOD new_version.

    DATA: but000s TYPE STANDARD TABLE OF but000 WITH DEFAULT KEY
                                                WITH UNIQUE SORTED KEY guid COMPONENTS partner_guid.
    DATA: sorted_but000s TYPE SORTED TABLE OF but000 WITH UNIQUE KEY partner.

* Variant 1
    ASSIGN but000s[ partner = '1234567890' ] TO FIELD-SYMBOL(<but000>).
    IF sy-subrc = 0.
      ...
    ENDIF.


* Variant 2
    DATA(but000) = but000s[ partner = '1234567890' ].
*    IF sy-subrc = 0.
*      ...
*    ENDIF.


* Variant 3
    DATA(ref_but000) = REF #( but000s[ partner = '1234567890' ] ).
*    IF sy-subrc = 0.
*      ...
*    ENDIF.


* Variant 4
    but000 = but000s[ KEY guid INDEX 1 ].
*    IF sy-subrc = 0.
*      ...
*    ENDIF.

* Variant 2/3 A
    TRY.

        DATA(save_but000) = but000s[ partner = '1234567890' ].

      CATCH cx_sy_itab_line_not_found.
    ENDTRY.


* Variant 2/3 B
    save_but000 =  VALUE #( but000s[ partner = '1234567890' ] DEFAULT
                            VALUE #( but000s[ partner_guid = '1234567891' ] OPTIONAL ) ).
    save_but000 =  VALUE #( but000s[ partner = '1234567890' ] OPTIONAL ).


* Variant 2/3 C
    IF line_exists( but000s[ partner = '1234567890' ] ).
      save_but000 = but000s[ partner = '1234567890' ].
    ENDIF.
    IF line_exists( but000s[ 1 ] ).
      save_but000 = but000s[ 1 ].
    ENDIF.

  ENDMETHOD.

  METHOD old_version_2.
    DATA: but000s TYPE STANDARD TABLE OF but000 WITH DEFAULT KEY
                                                WITH UNIQUE SORTED KEY guid COMPONENTS partner_guid.

* Variant 1
    READ TABLE but000s WITH TABLE KEY guid COMPONENTS partner_guid = '1234567890ABCDEF1234567890ABCDEF' ASSIGNING FIELD-SYMBOL(<but000>).
    IF sy-subrc = 0.
      ...
    ENDIF.


* Variant 2
    READ TABLE but000s INDEX 1 USING KEY guid ASSIGNING <but000>.
    IF sy-subrc = 0.
      ...
    ENDIF.


* Variant 3
    READ TABLE but000s WITH KEY partner_guid = '1234567890' BINARY SEARCH ASSIGNING <but000>.
    IF sy-subrc = 0.
      ...
    ENDIF.

  ENDMETHOD.

  METHOD new_version_2.

    DATA: but000s TYPE STANDARD TABLE OF but000 WITH DEFAULT KEY
                                                WITH UNIQUE SORTED KEY guid COMPONENTS partner_guid.


* Variant 1
    ASSIGN but000s[ KEY guid
                    COMPONENTS partner_guid = '1234567890ABCDEF1234567890ABCDEF' ] TO FIELD-SYMBOL(<but000>).


* Variant 2
    DATA(but000) = but000s[ KEY guid INDEX 1 ].


* Variant 3
* :(


  ENDMETHOD.

ENDCLASS.
