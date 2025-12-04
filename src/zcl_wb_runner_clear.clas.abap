CLASS zcl_wb_runner_clear DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
ENDCLASS.


CLASS zcl_wb_runner_clear IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    DELETE FROM zwb_bgpf_data.
    COMMIT WORK.

    out->write( 'Table ZWB_BGPF_DATA cleared' ).


  ENDMETHOD.
ENDCLASS.
