alter session set nls_date_format = 'DD.MM.YYYY'; 

insert into zusatzausstattungen (name)
    values ('Whirlpool');

insert
when not exists
    (select name
    from zusatzausstattungen
    where name = 'Garten')
then
into zusatzausstattungen (name)
    select 'Garten' from dual;

insert into adressen (adressid, hausnummer, strasse, plz, ortsid)
    values ((select max(adressid) from adressen) + 1, '6', 'Highway', '2349', ( select ortsid
                                                                                from orte, laender lae
                                                                                where
                                                                                orte.isocode = lae.isocode and
                                                                                lae.name like 'T%rkei' and
                                                                                orte.name like '%ludeniz'));

insert into ferienwohnungen (wohnungsid, beschreibung, anzahl_zimmer, preis_pro_tag, groesse_qm, adressid)
    values (999, 'Seaview', 4, 100, 100, (select max(adressid) from adressen));

commit;



