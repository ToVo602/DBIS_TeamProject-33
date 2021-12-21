alter session set nls_date_format = 'DD.MM.YYYY'; 

delete from ferienwohnungen
    where wohnungsid = 5;

commit;



