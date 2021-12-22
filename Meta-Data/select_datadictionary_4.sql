alter session set nls_date_format = 'DD.MM.YYYY'; 

select text_vc
from user_views
where view_name = 'UEBERSICHTKUNDEN';

describe user_views;


