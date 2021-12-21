alter session set nls_date_format = 'DD.MM.YYYY'; 

select uv.view_name
from user_views uv, user_constraints uc
where   uv.view_name = uc.table_name and
        uc.constraint_type = 'V';


