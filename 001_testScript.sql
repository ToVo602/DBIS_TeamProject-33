alter session set nls_date_format = 'DD.MM.YYYY'; 

delete from ferienwohnungen where wohnungsid = 8;

delete from kunden where kundennummer = 2;

delete from fluggesellschaften where iatacode = 'LH';

delete from touristenattraktionen where name = 'Hoernle';

delete from belegungen --where belegungsnummer in (1, 4, 6);


rollback;


select startflughafen, Zielflughafen
    from anfliegen
    connect by startflughafen = prior Zielflughafen
    start with zielflughafen = 'BCN';

select startflughafen, Zielflughafen
    from anfliegen
    connect by Zielflughafen = prior startflughafen
    start with startflughafen = 'FRA';
    

-- create user dbs999 identified by dbs999; --> nicht genug Zugriffsrechte