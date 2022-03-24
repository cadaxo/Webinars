CLASS zcl_ws_modernabap_tabl_comp DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
    METHODS old_version IMPORTING out TYPE REF TO if_oo_adt_classrun_out OPTIONAL.
    METHODS new_version IMPORTING out TYPE REF TO if_oo_adt_classrun_out OPTIONAL.
  PROTECTED SECTION.
    TYPES: ty_range_guid_32s  TYPE RANGE OF bu_partner_guid_bapi.
    METHODS select_with_range IMPORTING i_range_guid_32 TYPE ty_range_guid_32s.
ENDCLASS.

CLASS zcl_ws_modernabap_tabl_comp IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    " Table Comprehensions

    old_version( out ).

    new_version( out ).

  ENDMETHOD.

  METHOD old_version.

    DATA: lt_but000s TYPE TABLE OF but000 WITH DEFAULT KEY.
    DATA: lt_range_guid_32 TYPE RANGE OF bu_partner_guid_bapi.
    DATA: lwa_range_guid_32 LIKE LINE OF lt_range_guid_32.

    SELECT * FROM but000 INTO TABLE lt_but000s WHERE type = '1'.
    LOOP AT lt_but000s ASSIGNING FIELD-SYMBOL(<but000>).
      lwa_range_guid_32-sign = 'I'.
      lwa_range_guid_32-option = 'EQ'.
      lwa_range_guid_32-low = <but000>-partner_guid.
      APPEND lwa_range_guid_32 TO lt_range_guid_32.
    ENDLOOP.

    select_with_range( lt_range_guid_32 ).

  ENDMETHOD.

  METHOD new_version.
    CONSTANTS person TYPE bu_type VALUE '1'.

    SELECT *
           FROM but000
           WHERE type = @person
           INTO TABLE @DATA(but000s).

    select_with_range( VALUE #( FOR <partner> IN but000s
                                sign = 'I' option = 'EQ' ( low = <partner>-partner_guid ) ) ).
  ENDMETHOD.

  METHOD select_with_range.

  ENDMETHOD.

ENDCLASS.
