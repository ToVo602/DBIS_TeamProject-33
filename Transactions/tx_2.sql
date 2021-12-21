alter session set nls_date_format = 'DD.MM.YYYY'; 

insert into adressen (adressid, hausnummer, strasse, plz, ortsid)
    values ((select max(adressid) from adressen) + 1, '1', 'Schlossstrasse', '69115', ( select ortsid
                                                                                        from orte, laender lae
                                                                                        where
                                                                                        orte.isocode = lae.isocode and
                                                                                        lae.name like '_eutschland' and
                                                                                        orte.name like '_eidelberg'));

update kunden
    set adressid = (select max(adressid) from adressen)
    where kundennummer = 1;

update kunden
    set telefonnummer = '06221-546372'
    where kundennummer = 1;

commit;



