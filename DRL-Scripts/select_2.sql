alter session set nls_date_format = 'DD.MM.YYYY';

select distinct k.kundennummer, k.vorname, k.nachname
from kunden k, belegungen b
where   b.wohnungsid = &wohnungsid
        and
        b.statusflag = 'Reservierung'
        and
        b.belegtvon = k.kundennummer;