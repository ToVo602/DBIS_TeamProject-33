alter session set nls_date_format = 'DD.MM.YYYY'; 

create or replace trigger stornoSpeicherung
before delete on belegungen
for each row
when (old.statusflag = 'Buchung')
    declare
        zahlungsstatus varchar2(256);
        vorname varchar2(256);
        nachname varchar2(256);
        wohnbeschreibung varchar2(256);
        tage int;
    begin
        tage := :old.abreisetermin - :old.anreisetermin;

        select case when rech.zahlungsdatum is null then 'offen' else 'bezahlt' end into zahlungsstatus
            from    rechnungen rech
            where   :old.belegungsnummer = rech.belegungsnummer;

        select kun.vorname, kun.nachname into vorname, nachname
            from    kunden kun
            where   :old.belegtvon = kun.kundennummer;

        /*select kun.nachname into nachname
            from    kunden kun
            where   :old.belegtvon = kun.kundennummer;*/

        select  fewo.beschreibung into wohnbeschreibung
            from    ferienwohnungen fewo
            where   :old.wohnungsid = fewo.wohnungsid;

        insert into stornierteBuchungen
            values  (geloeschteBuchungen.nextval, current_date, :old.belegungsnummer,
                    :old.buchungsdatum, :old.anreisetermin, :old.abreisetermin,
                    preis(tage, :old.wohnungsid),
                    zahlungsstatus, :old.belegtvon, vorname, nachname, :old.wohnungsid,
                    wohnbeschreibung);
    end;
    /


