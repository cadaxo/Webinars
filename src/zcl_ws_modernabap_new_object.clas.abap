CLASS zcl_ws_modernabap_new_object DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
    METHODS old_version IMPORTING out TYPE REF TO if_oo_adt_classrun_out OPTIONAL.
    METHODS new_version IMPORTING out TYPE REF TO if_oo_adt_classrun_out OPTIONAL.
ENDCLASS.



CLASS zcl_ws_modernabap_new_object IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.


    " NEW Operator

    " object/instance of Class

    old_version( out ).

    new_version( out ).

  ENDMETHOD.

  METHOD old_version.

    DATA: gui_container TYPE REF TO cl_gui_custom_container.
    DATA: alv_grid      TYPE REF TO cl_gui_alv_grid.

    CREATE OBJECT gui_container
      EXPORTING
        container_name = 'ALV_CONTAINER'
      EXCEPTIONS
        OTHERS         = 1.

    CREATE OBJECT alv_grid
      EXPORTING
        i_parent = gui_container
      EXCEPTIONS
        OTHERS   = 1.


    DATA but000s TYPE REF TO bup_but000_t.
    but000s  = NEW bup_but000_t( ).
    alv_grid->set_table_for_first_display( CHANGING   it_outtab = but000s->*
                                           EXCEPTIONS OTHERS    = 1 ).

  ENDMETHOD.

  METHOD new_version.


    DATA(alv_grid) = NEW cl_gui_alv_grid( NEW cl_gui_custom_container( 'ALV_CONTAINER' ) ).


    DATA(but000s) = NEW bup_but000_t( ).
    alv_grid->set_table_for_first_display( CHANGING   it_outtab = but000s->*
                                           EXCEPTIONS OTHERS    = 1 ).

  ENDMETHOD.

ENDCLASS.
