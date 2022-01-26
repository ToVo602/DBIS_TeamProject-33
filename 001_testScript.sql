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
    

-- create user dbs999 identified by dbs999; --> nicht genug Zugriffsrechte