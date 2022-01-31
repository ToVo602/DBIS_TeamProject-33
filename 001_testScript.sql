alter session set nls_date_format = 'DD.MM.YYYY'; 

delete from ferienwohnungen where wohnungsid = 8;

delete from kunden where kundennummer = 2;

delete from fluggesellschaften where iatacode = 'LH';

delete from touristenattraktionen where name = 'Hoernle';

delete from belegungen where belegungsnummer = 11;


rollback;

commit;


select startflughafen, Zielflughafen
    from anfliegen
    connect by startflughafen = prior Zielflughafen
    start with zielflughafen = 'BCN';

select startflughafen, Zielflughafen
    from anfliegen
    connect by Zielflughafen = prior startflughafen
    start with startflughafen = 'FRA';

with TransitivH (Startflughafen, Zielflughafen) as
    ((select anf.startflughafen, anf.zielflughafen
        from anfliegen anf)
    union all
    (select tH.startflughafen, anf.zielflughafen
        from TransitivH tH, anfliegen anf
        where tH.zielflughafen = anf.startflughafen))
select distinct *
    from TransitivH
    where Startflughafen = 'FRA';

--create user dbs999 identified by dbs999; --> nicht genug Zugriffsrechte

--Select-Statement für Assertion:
--Eine Adresse soll genau einem Kunden, einer FeWo, einer Touristenattraktion oder einem Flughafen gehören.
(select ad.adressid
    from adressen ad
    where ad.adressid not in
        ((select adressid
            from ferienwohnungen)
        union all
        (select adressid
            from flughaefen)
        union all
        (select adressid
            from kunden)
        union all
        (select adressid
            from touristenattraktionen)))
union all
(select ad.adressid
    from 
        ((select adressid
            from ferienwohnungen)
        union all
        (select adressid
            from flughaefen)
        union all
        (select adressid
            from kunden)
        union all
        (select adressid
            from touristenattraktionen)) TableUnion, adressen ad
    where TableUnion.adressid = ad.adressid
    group by ad.adressid
    having count(*) > 1);

-- Test-Daten, um Select für Assertion zu testen
insert into ferienwohnungen
    values((select max(wohnungsid) + 1 from ferienwohnungen), 'Beschreibung', 5, 100, 120, 1);

insert into adressen
    values((select max(adressid) + 1 from adressen), '654', 'Test', 'Test', (select max(ortsid) from orte));

