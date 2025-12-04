CLASS zcl_wb_runner_uncontrolled DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
ENDCLASS.


CLASS zcl_wb_runner_uncontrolled IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    DATA bgpf_process TYPE REF TO if_bgmc_process_single_op.

    TRY.
        FINAL(bgpf_operation) = NEW zcl_wb_bgpf_operation_unctrl( CONV #( 'BGPF_U' ) ).

        bgpf_process = cl_bgmc_process_factory=>get_default( )->create( ).

        bgpf_process->set_name( 'Webinar' )->set_operation_tx_uncontrolled( bgpf_operation ).
        bgpf_process->save_for_execution( ).

        MODIFY zwb_bgpf_data FROM @( VALUE #( uuid  = cl_uuid_factory=>create_system_uuid( )->create_uuid_x16( )
                                              data  = 'RUN'
                                              stamp = utclong_current( ) ) ).

      CATCH cx_root.
        " just to suppress warnings
    ENDTRY.

    COMMIT WORK.

    out->write( 'UNControlled Process started!' ).
  ENDMETHOD.
ENDCLASS.
