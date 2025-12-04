CLASS lsc_zr_webinar_bgpfdata DEFINITION INHERITING FROM cl_abap_behavior_saver.

  PROTECTED SECTION.
    METHODS save_modified REDEFINITION.

ENDCLASS.


CLASS lhc_zr_Webinar_bgPFData DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PUBLIC SECTION.
    CLASS-DATA bgpf_process TYPE REF TO if_bgmc_process_single_op.

  PRIVATE SECTION.
    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zr_Webinar_bgPFData RESULT result.

    METHODS generate FOR MODIFY
      IMPORTING keys FOR ACTION zr_Webinar_bgPFData~generate.

ENDCLASS.


CLASS lsc_zr_webinar_bgpfdata IMPLEMENTATION.
  METHOD save_modified.
    TRY.
        IF lhc_zr_Webinar_bgPFData=>bgpf_process IS BOUND.
          lhc_zr_Webinar_bgPFData=>bgpf_process->save_for_execution( ).

          MODIFY zwb_bgpf_data FROM @( VALUE #( uuid  = cl_uuid_factory=>create_system_uuid( )->create_uuid_x16( )
                                                data  = 'Action'
                                                stamp = utclong_current( ) ) ).
        ENDIF.

      CATCH cx_root.
        " just to suppress warnings
    ENDTRY.
  ENDMETHOD.
ENDCLASS.


CLASS lhc_zr_Webinar_bgPFData IMPLEMENTATION.
  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD generate.
    TRY.

        FINAL(bgpf_operation) = NEW zcl_wb_bgpf_operation_ctrl( CONV #( 'BGPF_Action' ) ).

        bgpf_process = cl_bgmc_process_factory=>get_default( )->create( ).

        bgpf_process->set_name( 'Webinar' )->set_operation( bgpf_operation ).

      CATCH cx_root.
        " just to suppress warnings
    ENDTRY.
  ENDMETHOD.
ENDCLASS.
