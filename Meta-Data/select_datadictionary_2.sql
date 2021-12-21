alter session set nls_date_format = 'DD.MM.YYYY'; 


(select table_name as tableOrView
from user_tables)
union
(select view_name as tableOrView
from user_views);


