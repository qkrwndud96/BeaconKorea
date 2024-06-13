CLASS zc_numrange_jyp DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zc_numrange_jyp IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA : nr_attribute  TYPE cl_numberrange_objects=>nr_attribute,
           obj_text      TYPE cl_numberrange_objects=>nr_obj_text,
           lv_returncode TYPE cl_numberrange_objects=>nr_returncode,
           lv_errors     TYPE cl_numberrange_objects=>nr_errors.

    nr_attribute-buffer = 'X'.
    nr_attribute-object = 'ZNR_BD_JYP'.
    nr_attribute-domlen = 'ZD_BUILD_JYP'.
    nr_attribute-percentage = 10.
    nr_attribute-devclass = 'ZBP_JYP_I_BUILDINGS'.

    obj_text-langu = 'E'.
    obj_text-object = 'ZNR_BD_JYP'.
    obj_text-txt = 'Building ID Range'.
    obj_text-txtshort = 'Building ID'.

    TRY.
        cl_numberrange_objects=>create(
        EXPORTING
            attributes = nr_attribute
            obj_text   = obj_text
        IMPORTING
            errors     = lv_errors
            returncode = lv_returncode ).


      CATCH cx_number_ranges
        INTO DATA(lx_number_range).
    ENDTRY.


    DATA:
      nrt_interval TYPE cl_numberrange_intervals=>nr_interval,
      nrs_interval LIKE LINE OF nrt_interval.

    nrs_interval-subobject = ''.
    nrs_interval-nrrangenr = '01'.
    nrs_interval-fromnumber = '1000000'.
    nrs_interval-tonumber = '9999999'.
    nrs_interval-procind = 'I'.
    APPEND nrs_interval TO nrt_interval.


    TRY.

        CALL METHOD cl_numberrange_intervals=>create
          EXPORTING
            interval  = nrt_interval
            object    = 'ZNR_BD_JYP'
            subobject = ''
          IMPORTING
            error     = DATA(error)
            error_inf = DATA(error_inf)
            error_iv  = DATA(error_iv).

      CATCH  cx_nr_object_not_found
        INTO DATA(lx_no_obj_found).

      CATCH cx_number_ranges
        INTO DATA(cx_number_ranges).

    ENDTRY.

  ENDMETHOD.
ENDCLASS.
