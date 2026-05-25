*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZEMPLOYEE.......................................*
DATA:  BEGIN OF STATUS_ZEMPLOYEE                     .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZEMPLOYEE                     .
CONTROLS: TCTRL_ZEMPLOYEE
            TYPE TABLEVIEW USING SCREEN '0001'.
*...processing: ZEMPLOYEEEX.....................................*
DATA:  BEGIN OF STATUS_ZEMPLOYEEEX                   .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZEMPLOYEEEX                   .
CONTROLS: TCTRL_ZEMPLOYEEEX
            TYPE TABLEVIEW USING SCREEN '0003'.
*...processing: ZEMP_M_VIEW.....................................*
TABLES: ZEMP_M_VIEW, *ZEMP_M_VIEW. "view work areas
CONTROLS: TCTRL_ZEMP_M_VIEW
TYPE TABLEVIEW USING SCREEN '0002'.
DATA: BEGIN OF STATUS_ZEMP_M_VIEW. "state vector
          INCLUDE STRUCTURE VIMSTATUS.
DATA: END OF STATUS_ZEMP_M_VIEW.
* Table for entries selected to show on screen
DATA: BEGIN OF ZEMP_M_VIEW_EXTRACT OCCURS 0010.
INCLUDE STRUCTURE ZEMP_M_VIEW.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZEMP_M_VIEW_EXTRACT.
* Table for all entries loaded from database
DATA: BEGIN OF ZEMP_M_VIEW_TOTAL OCCURS 0010.
INCLUDE STRUCTURE ZEMP_M_VIEW.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZEMP_M_VIEW_TOTAL.

*...processing: ZTEST...........................................*
DATA:  BEGIN OF STATUS_ZTEST                         .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZTEST                         .
CONTROLS: TCTRL_ZTEST
            TYPE TABLEVIEW USING SCREEN '0004'.
*.........table declarations:.................................*
TABLES: *ZEMPLOYEE                     .
TABLES: *ZEMPLOYEEEX                   .
TABLES: *ZTEST                         .
TABLES: ZEMPLOYEE                      .
TABLES: ZEMPLOYEEADDR                  .
TABLES: ZEMPLOYEEEX                    .
TABLES: ZTEST                          .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
