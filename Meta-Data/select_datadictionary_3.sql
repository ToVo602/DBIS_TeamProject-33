alter session set nls_date_format = 'DD.MM.YYYY'; 

select column_name, data_type, nullable
from user_tab_columns
where table_name = 'FERIENWOHNUNGEN';


