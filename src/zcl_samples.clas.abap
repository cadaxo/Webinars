CLASS zcl_samples DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES: if_oo_adt_classrun.

    TYPES: ty_demo_icq TYPE n LENGTH 10.
    TYPES: BEGIN OF ts_agency,
             agency_id TYPE /dmo/agency-agency_id,
             city      TYPE /dmo/agency-city,
           END OF ts_agency,
           tt_agency TYPE STANDARD TABLE OF ts_agency WITH NON-UNIQUE KEY agency_id.


  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA m_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS field_symbols_vs_references.
    METHODS change_it
      IMPORTING
        i_agency TYPE REF TO /dmo/agency.
    METHODS about_values.
    METHODS get_agency
      RETURNING
        VALUE(r_agency) TYPE ts_agency.
    METHODS get_agencies
      RETURNING
        VALUE(r_agency) TYPE tt_agency.
    METHODS call_a_fm.
ENDCLASS.



CLASS ZCL_SAMPLES IMPLEMENTATION.


  METHOD about_values.

    DATA(agency) = get_agency(  ).

    m_out->write( agency ).


    DATA(agency_tab) = get_agencies(  ).

    m_out->write( agency_tab ).


    call_a_fm( ).

  ENDMETHOD.


  METHOD call_a_fm.


    CALL FUNCTION 'Z_SSC_DEMO_FM'
      EXPORTING
        agencies = VALUE tt_agency( city = 'Berlin'
                                    ( agency_id = '990007' )
                                    ( agency_id = '990008' ) ).

  ENDMETHOD.


  METHOD change_it.

    i_agency->city = 'Karlsruhe!'.

  ENDMETHOD.


  METHOD field_symbols_vs_references.

    DATA: r_agency TYPE REF TO /dmo/agency.

    CREATE DATA r_agency.

    SELECT SINGLE FROM /dmo/agency
    FIELDS *
        INTO @r_agency->*.

    m_out->write( r_agency->* ).


    change_it( EXPORTING i_agency = r_agency ).

    m_out->write( r_agency->* ).


    DATA(struct) = CAST cl_abap_structdescr( cl_abap_elemdescr=>describe_by_data_ref( r_agency ) ).

    LOOP AT struct->get_components( ) ASSIGNING FIELD-SYMBOL(<comp>).

      m_out->write( r_agency->(<comp>-name) ).

    ENDLOOP.

    TRY.

        DATA(city) = r_agency->city.
        DATA(icq) = CONV ty_demo_icq( r_agency->('ICQ') ).

      CATCH cx_root INTO DATA(lx_root).

        m_out->write( lx_root ).

    ENDTRY.

    FIELD-SYMBOLS: <agency_tab> TYPE any.

    SELECT FROM /dmo/agency
    FIELDS *
        INTO TABLE @DATA(agency_tab)
        UP TO 100 ROWS.

    DATA(r_agency_tab) = REF #( agency_tab ).

    ASSIGN agency_tab TO <agency_tab>.

    LOOP AT <agency_tab> ASSIGNING FIELD-SYMBOL(<agency_line>).

    ENDLOOP.

    LOOP AT r_agency_tab->* REFERENCE INTO DATA(r_agency_line).


    ENDLOOP.


  ENDMETHOD.


  METHOD get_agencies.

    r_agency = VALUE #( ( agency_id = '990002' city = 'Wien')
                        ( agency_id = '990003' city = 'Wien')
                        ( agency_id = '990004' city = 'Wien') ).




    r_agency = VALUE #( BASE r_agency
                        city = 'Munich'
                        ( agency_id = '990005' )
                        ( agency_id = '990006' )
                        ( agency_id = '990007' ) ).

  ENDMETHOD.


  METHOD get_agency.

    r_agency = VALUE #( agency_id = '990001'
                        city = 'Karlsuhe' ).

  ENDMETHOD.


  METHOD if_oo_adt_classrun~main.

    m_out = out.

*    field_symbols_vs_references( ).

    about_values( ).

  ENDMETHOD.
ENDCLASS.
