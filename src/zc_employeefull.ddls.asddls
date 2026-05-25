@AbapCatalog.sqlViewName: 'ZEMPJOINVW'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Employee with Address and Pay'

define view ZC_EmployeeFull as
  select from zemployee as A
    inner join zemployeeaddr as B
      on A.eid = B.eid
    inner join zemployeepay as C
      on A.eid = C.eid
{
    key A.eid as Employee_ID,
    A.ename as Employee_Name,
    A.eage as Employee_Age,
    A.erole as Employee_Role,
    B.eaddr as Employee_Address,
    B.econt as Employee_Country,
    B.ephone as Employee_PhoneNumber,
    C.ectc as Employee_CTC,
    C.ecurr as Employee_Currency,
    C.edoj as Employee_DateOfJoining    
}
