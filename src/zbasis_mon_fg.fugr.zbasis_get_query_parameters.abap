FUNCTION zbasis_get_query_parameters.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(REQUEST_URI) TYPE  STRING
*"  EXPORTING
*"     REFERENCE(QUERY_PARAMS) TYPE  ZQUERY_PARAMSTAB
*"----------------------------------------------------------------------


  "REQUEST_URI = '/sap/bc/uc/..././././?x=y&z=a'

  DATA: wa_queryparams LIKE LINE OF query_params.

  SPLIT request_uri AT '?' INTO DATA(uri) DATA(queries).

  SPLIT queries AT '&' INTO TABLE DATA(raw_query_params).

  LOOP AT raw_query_params INTO DATA(query_param).
    SPLIT query_param AT '=' INTO wa_queryparams-query wa_queryparams-value.
    APPEND wa_queryparams TO query_params.
    CLEAR: wa_queryparams.
  ENDLOOP.




ENDFUNCTION.
