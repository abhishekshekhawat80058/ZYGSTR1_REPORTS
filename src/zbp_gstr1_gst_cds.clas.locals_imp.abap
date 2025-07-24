CLASS lhc_zgstr1_gst_cds DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zgstr1_gst_cds RESULT result.

ENDCLASS.

CLASS lhc_zgstr1_gst_cds IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

ENDCLASS.
