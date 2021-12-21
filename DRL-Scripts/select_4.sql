alter session set nls_date_format = 'DD.MM.YYYY';

select kundennummer, nachname, count(*) as Belegungen_Kunde
from belegungen b, kunden k
where   b.statusflag = 'Buchung'
        and
        k.kundennummer = b.belegtvon
        and
        k.nachname = '&nachname'
group by kundennummer, nachname;
        