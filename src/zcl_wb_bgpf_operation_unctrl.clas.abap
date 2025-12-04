CLASS zcl_wb_bgpf_operation_unctrl DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_bgmc_op_single_tx_uncontr.
    INTERFACES if_serializable_object.

    METHODS constructor
      IMPORTING i_data TYPE string.

  PROTECTED SECTION.
    DATA data TYPE string.

    METHODS modify RAISING cx_bgmc_operation.

    METHODS save.
ENDCLASS.


CLASS zcl_wb_bgpf_operation_unctrl IMPLEMENTATION.
  METHOD constructor.
    data = i_data.
  ENDMETHOD.

  METHOD if_bgmc_op_single_tx_uncontr~execute.
    DATA timestamp TYPE utclong.
    DATA uuid      TYPE sysuuid_x16.

    cl_abap_tx=>modify( ).
    timestamp = utclong_current( ).
    uuid = cl_uuid_factory=>create_system_uuid( )->create_uuid_x16( ).
    MODIFY ENTITIES OF ZR_Webinar_bgPFData ENTITY ZR_Webinar_bgPFData
           CREATE FROM VALUE #( ( %cid               = 'MyCID_1'
                                  uuid               = uuid
                                  %control-uuid      = if_abap_behv=>mk-on
                                  TimeStamp          = timestamp
                                  %control-TimeStamp = if_abap_behv=>mk-on
                                  Data               = 'RAP Create'
                                  %control-Data      = if_abap_behv=>mk-on ) )
           FAILED FINAL(failed)
           REPORTED FINAL(reported).
    COMMIT WORK.
    modify( ).

    save( ).
  ENDMETHOD.

  METHOD modify.
    IF data IS INITIAL.
      RAISE EXCEPTION NEW cx_bgmc_operation( textid = cx_bgmc_operation=>t100_operation_failed ).
    ENDIF.
  ENDMETHOD.

  METHOD save.
    MODIFY zwb_bgpf_data FROM @( VALUE #( uuid  = cl_uuid_factory=>create_system_uuid( )->create_uuid_x16( )
                                          data  = data
                                          stamp = utclong_current( ) ) ).
  ENDMETHOD.
ENDCLASS.
