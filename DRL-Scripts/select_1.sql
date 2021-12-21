alter session set nls_date_format = 'DD.MM.YYYY'; 

select b.*
from belegungen b
where   b.wohnungsid = &wohnungsid;