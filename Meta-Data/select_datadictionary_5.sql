alter session set nls_date_format = 'DD.MM.YYYY'; 

select uc.constraint_name, uc.constraint_type, ucc.column_name, ucc.position, uc.search_condition_vc, uc.deferrable, uc.deferred, uc.status
from user_constraints uc, user_cons_columns ucc
where   uc.constraint_name = ucc.constraint_name and
        uc.table_name = upper('&table') and
        uc.constraint_type in ('C', 'U', 'P');
