alter session set nls_date_format = 'DD.MM.YYYY'; 


(select table_name as tableOrView, 'Table' as Type
from user_tables)
union
(select view_name as tableOrView, 'View' as Type
from user_views)
order by type, TableOrView;



