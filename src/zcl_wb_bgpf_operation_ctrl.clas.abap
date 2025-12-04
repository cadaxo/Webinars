CLASS zcl_wb_bgpf_operation_ctrl DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_bgmc_op_single.

    METHODS constructor
      IMPORTING i_data TYPE string.

  PROTECTED SECTION.
    DATA data TYPE string.

    METHODS modify RAISING cx_bgmc_operation.

    METHODS save.
ENDCLASS.


CLASS zcl_wb_bgpf_operation_ctrl IMPLEMENTATION.
  METHOD constructor.
    data = i_data.
  ENDMETHOD.

  METHOD if_bgmc_op_single~execute.
    TRY.

        MODIFY ENTITIES OF ZR_Webinar_bgPFData ENTITY ZR_Webinar_bgPFData
               CREATE FROM VALUE #( ( %cid               = 'MyCID_1'
                                      uuid               = cl_uuid_factory=>create_system_uuid( )->create_uuid_x16( )
                                      %control-uuid      = if_abap_behv=>mk-on
                                      TimeStamp          = utclong_current( )
                                      %control-TimeStamp = if_abap_behv=>mk-on
                                      Data               = 'RAP Create:' && data
                                      %control-Data      = if_abap_behv=>mk-on ) )
               FAILED FINAL(failed)
               REPORTED FINAL(reported).

*         COMMIT WORK. "DUMP! BEHAVIOR_ILLEGAL_STMT_IN_CALL

        modify( ).

        cl_abap_tx=>save( ).
        save( ).

      CATCH cx_root.
        " just to suppress warnings
    ENDTRY.
  ENDMETHOD.

  METHOD modify.

    " fill buffer
    IF data IS INITIAL.
      RAISE EXCEPTION NEW cx_bgmc_operation( textid = cx_bgmc_operation=>t100_operation_failed ).
    ENDIF.

  ENDMETHOD.

  METHOD save.
    TRY.

      " save buffer
        MODIFY zwb_bgpf_data FROM @( VALUE #( uuid  = cl_uuid_factory=>create_system_uuid( )->create_uuid_x16( )
                                              data  = data
                                              stamp = utclong_current( ) ) ).

      CATCH cx_root.
        " just to suppress warnings
    ENDTRY.
  ENDMETHOD.
ENDCLASS.
