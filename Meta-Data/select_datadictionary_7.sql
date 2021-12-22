alter session set nls_date_format = 'DD.MM.YYYY'; 

select uc.table_name as View_name
from user_constraints uc
where uc.constraint_type = 'V';