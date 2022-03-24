CLASS zcl_demo_string_expressions DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
    METHODS demo_date
      IMPORTING out TYPE REF TO if_oo_adt_classrun_out .
    METHODS demo_alpha
      IMPORTING
        out TYPE REF TO if_oo_adt_classrun_out.
    METHODS demo_xsd
      IMPORTING
        out TYPE REF TO if_oo_adt_classrun_out.
    METHODS demo
      IMPORTING
        out TYPE REF TO if_oo_adt_classrun_out.
    METHODS demo_concatenate
      IMPORTING
        out TYPE REF TO if_oo_adt_classrun_out.
ENDCLASS.



CLASS zcl_demo_string_expressions IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    demo( out ).

    demo_date( out ).

    demo_alpha( out ).

    demo_xsd( out ).

    demo_concatenate( out ).

  ENDMETHOD.


  METHOD demo_date.

    out->write( |Date RAW:            { cl_abap_context_info=>get_system_date( ) DATE = RAW }| ).
    out->write( |Date ISO:            { cl_abap_context_info=>get_system_date( ) DATE = ISO }| ).
    out->write( |Date USER:           { cl_abap_context_info=>get_system_date( ) DATE = USER }| ).
    out->write( |Date ENVIRONMENT     { cl_abap_context_info=>get_system_date( ) DATE = ENVIRONMENT }| ).

    out->write( |Date with COUNTRY AT { cl_abap_context_info=>get_system_date( ) COUNTRY = 'AT ' }| ).

  ENDMETHOD.


  METHOD demo_alpha.

    DATA l_matnr TYPE matnr VALUE '123'.

    out->write( |Matnr Ausgangslage { l_matnr }| ).

    l_matnr = |{ l_matnr ALPHA = IN }|.

    out->write( |Matnr ALPHA IN     { l_matnr }| ).
    out->write( |Matnr ALPHA OUT    { l_matnr ALPHA = IN }| ).

  ENDMETHOD.


  METHOD demo_xsd.

    DATA date TYPE d VALUE `19720731`.
    DATA integer TYPE p DECIMALS 2 VALUE `-100.10`.

    out->write( |{ date } ... { date XSD = YES }| ).
    out->write( |{ integer } ... { integer XSD = YES }| ).

  ENDMETHOD.


  METHOD demo.

    DATA demo_string TYPE string.

    demo_string = ||.
    " SY-DATUM; cl_abap_context_info=>get_system_date( )
    out->write( demo_string ).

  ENDMETHOD.


  METHOD demo_concatenate.

    DATA(value1) = | abc | & | def |.
    DATA(value2) = | abc | && | def |.
    DATA(value3) = ` abc ` && ` def `.
    DATA(value4) = ` abc ` & ` def `.
    DATA(value5) = ' abc ' & ' def '.
    DATA(value6) = ' abc ' && ' def '.

    out->write( value1 ).
    out->write( value2 ).
    out->write( value3 ).
    out->write( value4 ).
    out->write( value5 ).
    out->write( value6 ).


*html =
*  `<html>`   &
*  `<body>`   &
*  `Text`     &
*  `</body>`  &
*  `</html>`.

  ENDMETHOD.

ENDCLASS.
