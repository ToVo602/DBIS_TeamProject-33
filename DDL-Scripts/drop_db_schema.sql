-- Set the used date format for the session 
alter session set nls_date_format = 'DD.MM.YYYY'; 

-- Empty Oracle's recycle bin and disable the recycle bin for the session
purge recyclebin;
alter session set recyclebin = off;
-- ALTER SESSION SET recyclebin = ON;


-- start mit einem Alter table befehl um ein FK-Constraint in der Zirkelbeziehung auszuhebeln.
alter table flughaefen
    drop constraint fk_flughaefen_adressen;
    
drop table bilder;

drop table touristenattraktionen;

drop table bietet;

drop table rechnungen;

drop table belegungen;

drop table kunden;

drop table ferienwohnungen;

drop table adressen;

drop table istentfernt;

drop table orte;

drop table anfliegen;


-- alle Tabellen ohne FK
drop table flughaefen;

drop table fluggesellschaften;

drop table laender;

drop table bankverbindungen;

drop table zusatzausstattungen;

drop view Reservierungen;

drop view Buchungen;

drop view Familienwohnungen;

drop view UebersichtKunden;

drop view Zahlungsstatus;

drop view MidAgeKunden;

drop sequence geloeschteBuchungen;

drop function preis;

drop table stornierteBuchungen;

--drop trigger stornoSpeicherung;

commit;

