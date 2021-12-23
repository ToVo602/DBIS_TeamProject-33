alter session set nls_date_format = 'DD.MM.YYYY'; 

delete from ferienwohnungen where wohnungsid = 8;

delete from kunden where kundennummer = 2;

delete from fluggesellschaften where iatacode = 'LH';

delete from touristenattraktionen where name = 'Hoernle';

delete from belegungen where belegungsnummer in (1, 4, 6);


rollback;