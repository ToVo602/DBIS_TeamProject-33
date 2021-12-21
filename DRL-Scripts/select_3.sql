alter session set nls_date_format = 'DD.MM.YYYY';

select count(*) as Buchungen_Kunde
from belegungen b
where   b.belegtvon = &kundennummer
        and
        b.statusflag = 'Buchung';
        