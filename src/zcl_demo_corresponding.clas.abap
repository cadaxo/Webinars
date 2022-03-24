CLASS zcl_demo_corresponding DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .



  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
    METHODS demo_corresponding_structure IMPORTING out TYPE REF TO if_oo_adt_classrun_out .
    METHODS demo_corresponding_table IMPORTING out TYPE REF TO if_oo_adt_classrun_out.
    METHODS demo_corresponding_complex
      IMPORTING
        out TYPE REF TO if_oo_adt_classrun_out.
    METHODS demo_corresponding_dynamic
      IMPORTING
        out TYPE REF TO if_oo_adt_classrun_out.
    METHODS demo_corresponding_lookup
      IMPORTING
        out TYPE REF TO if_oo_adt_classrun_out.
ENDCLASS.



CLASS zcl_demo_corresponding IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    " demo_corresponding_structure( out  ).

    " demo_corresponding_table( out ).

    " demo_corresponding_complex( out ).

    " demo_corresponding_lookup( out ).

     demo_corresponding_dynamic( out ).

  ENDMETHOD.


  METHOD demo_corresponding_structure.

    TYPES: BEGIN OF type_source,
             cola TYPE string,
             colb TYPE string,
             colc TYPE string,
             cold TYPE string,
           END OF type_source,

           BEGIN OF type_target,
             cola     TYPE c LENGTH 2, "string,
             colb     TYPE string,
             column_c TYPE string,
             cold     TYPE string,
             cole     TYPE string,
           END OF type_target.

    DATA l_structure_source TYPE type_source.
    DATA l_Structure_target TYPE type_target.

    l_structure_source-cola = 'AAA'.
    l_structure_source-colb = 'BBB'.
    l_structure_source-colc = 'CCC'.

    out->write( data = l_structure_source name = 'Source Structure' ).

    l_structure_target-cold = 'DDD'.
    l_structure_target-cole = 'EEE'.

    out->write( data = l_structure_target name = 'Target Structure before CORRESPONDING' ).

    " classical MOVE-CORRESPONDING
     move-corresponding l_structure_source to l_structure_target.
     move-corresponding exact l_structure_source to l_structure_target.

    " CORRESPONDING EXPRESSION
     l_structure_target = CORRESPONDING #( l_structure_source  ).
     l_structure_target = CORRESPONDING #( EXACT l_structure_source  ).
     l_structure_target = CORRESPONDING #( base ( l_structure_target ) l_structure_source  ).
     l_structure_target = CORRESPONDING #( base ( l_structure_target ) l_structure_source MAPPING column_c = colc ).
     l_structure_target = CORRESPONDING #( base ( l_structure_target ) l_structure_source MAPPING column_c = colc except cold ).

    out->write( data = l_structure_target name = 'Target Structure after CORRESPONDING' ).
  ENDMETHOD.


  METHOD demo_corresponding_table.

    TYPES: BEGIN OF type_source,
             cola TYPE string,
             colb TYPE string,
             colc TYPE string,
             cold TYPE string,
           END OF type_source,

           BEGIN OF type_target,
             cola     TYPE string,
             colb     TYPE string,
             column_c TYPE string,
             cold     TYPE string,
             cole     TYPE string,
           END OF type_target.

    DATA l_tab_source TYPE TABLE OF type_source.
    DATA l_tab_target TYPE TABLE OF type_target.
    DATA line TYPE n LENGTH 4.

    DO 5 TIMES.
      line = sy-index.
      l_tab_source  = VALUE #( BASE l_tab_source ( cola = |A{ line }|
                                                   colb = |B{ line }|
                                                   colc = |C{ line }|
                                                   cold = |D{ line }|
                              ) ).
    ENDDO.

    l_tab_target = VALUE #( (  cola = 'A0000' colb = 'B0000' ) ).

    out->write( data = l_tab_source name = 'Source Table' ).

    " classical MOVE-CORRESPONDING
     move-corresponding l_tab_source to l_tab_target.

    " CORRESPONDING EXPRESSION
     l_tab_target = CORRESPONDING #( l_tab_source  ).
     l_tab_target = CORRESPONDING #( base (  l_tab_target ) l_tab_source  ).
     l_tab_target = CORRESPONDING #( base (  l_tab_target ) l_tab_source mapping column_c = colc ).
     l_tab_target = CORRESPONDING #( base (  l_tab_target ) l_tab_source mapping column_c = colc except cold ).

    out->write( data = l_tab_target name = 'Target Table after CORRESPONDING' ).

  ENDMETHOD.


  METHOD demo_corresponding_complex.

    TYPES: BEGIN OF type_source,
             cola TYPE string,
             colb TYPE string,
             BEGIN OF sub,
               colc TYPE string,
               cold TYPE string,
             END OF sub,
           END OF type_source.

    TYPES: BEGIN OF type_target,
             cola     TYPE string,
             column_b TYPE string,
             BEGIN OF sub_target,
               column_c TYPE string,
               cold     TYPE string,
               cole     TYPE string,
             END OF sub_target,
           END OF type_target.

    DATA l_structure_source TYPE type_source.
    DATA l_structure_target TYPE type_target.

    l_structure_source-cola = 'AAA'.
    l_structure_source-colb = 'BBB'.
    l_structure_source-sub-colc = 'CCC'.
    l_structure_source-sub-cold = 'DDD'.

    l_structure_target-sub_target-cold = 'DDD'.
    l_structure_target-sub_target-cole = 'EEE'.

    " CORRESPONDING EXPRESSION - complex
    l_structure_target = CORRESPONDING #( l_structure_source  ).
    l_structure_target = CORRESPONDING #( base ( l_structure_target ) l_structure_source mapping column_b = colb sub_target = sub ).
    l_structure_target = CORRESPONDING #( base ( l_structure_target ) l_structure_source mapping column_b = colb ( sub_target = sub mapping column_c = colc ) ).

    out->write( sy-subrc ).

  ENDMETHOD.


  METHOD demo_corresponding_dynamic.

    TYPES: BEGIN OF type_source,
             cola TYPE string,
             colb TYPE string,
           END OF type_source,

           BEGIN OF type_target,
             column_a TYPE string,
             column_b TYPE string,
             column_c type string,
           END OF type_target.

    DATA l_structure_source TYPE type_source.
    DATA l_Structure_target TYPE type_target.

    l_structure_source-cola = 'AAA'.
    l_structure_source-colb = 'BBB'.

    l_structure_target-column_c = 'CCC'.

    " dynamic CORRESPONDING by CL_ABAP_CORRESPONDING
    DATA(mapper) = cl_abap_corresponding=>create( source      = l_structure_source
                                                  destination = l_Structure_target
                                                  mapping     = VALUE cl_abap_corresponding=>mapping_table( ( level = 0 kind = 1 srcname = 'cola' dstname = 'column_a' )
                                                                                                            ( level = 0 kind = 1 srcname = 'colb' dstname = 'column_b' ) ) ).
    " level = 0
    " mode 1 = move; 2 = except, 3 = except all, ( 4 = discarding duplicates )
    mapper->execute( EXPORTING source      = l_structure_source
                     CHANGING  destination = l_Structure_target ).

    out->write( l_structure_source ).
    out->write( l_structure_target ).

  ENDMETHOD.


  METHOD demo_corresponding_lookup.

    TYPES: BEGIN OF type_source,
             cola TYPE string,
             colb TYPE string,
              value_a type string,
           END OF type_source,

           BEGIN OF type_lookup,
             value_a TYPE string,
             value_b TYPE string,
           END OF type_lookup.

    DATA l_tab_source TYPE standard table of type_source.
    DATA l_tab_lookup TYPE sorted table of type_lookup with unique key value_b.

    l_tab_source = value #( ( cola = 'A1' colb = 'B1' ) ( cola = 'A2' colb = 'B2' ) ).
    l_tab_lookup = value #( ( value_a = 'VA1' value_b = 'A1' ) ( value_a = 'VA2' value_b = 'A2' ) ).

    " CORRESPONDING with LOOKPUP
    l_tab_source = CORRESPONDING #( l_tab_source from l_tab_lookup using value_b = cola ).

    out->write( l_tab_source ).

  ENDMETHOD.

ENDCLASS.
