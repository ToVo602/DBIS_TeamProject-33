-- Set the used date format for the session 
alter session set nls_date_format = 'DD.MM.YYYY'; 

-- Empty Oracle's recycle bin and disable the recycle bin for the session
purge recyclebin;
alter session set recyclebin = off;
-- ALTER SESSION SET recyclebin = ON;

-- start mit einem Alter table befehl um ein FK-Constraint in der Zirkelbeziehung auszuhebeln.
/*alter table flughaefen
    disable constraint fk_flughaefen_adressen;*/
    
delete from bilder;

delete from anfliegen;

delete from touristenattraktionen;

delete from bietet;

delete from rechnungen;

delete from belegungen;

delete from kunden;

delete from ferienwohnungen;

delete from flughaefen;

delete from adressen;

delete from istentfernt;

delete from orte;

delete from fluggesellschaften;

delete from bankverbindungen;

delete from zusatzausstattungen;

delete from laender;

/*alter table flughaefen
    enable constraint fk_flughaefen_adressen;*/

commit;