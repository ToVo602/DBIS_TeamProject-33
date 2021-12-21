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
            from    belegungen bel, rechnungen rech
            where   bel.belegungsnummer = rech.belegungsnummer and
                    bel.belegungsnummer = :old.belegungsnummer;
        
        select kun.vorname into vorname
            from    belegungen bel, kunden kun
            where   bel.belegtvon = kun.kundennummer and
                    bel.belegungsnummer = :old.belegungsnummer;
        
        select kun.nachname into nachname
            from    belegungen bel, kunden kun
            where   bel.belegtvon = kun.kundennummer and
                    bel.belegungsnummer = :old.belegungsnummer;
        
        select  fewo.beschreibung into wohnbeschreibung
            from    belegungen bel, ferienwohnungen fewo
            where   bel.wohnungsid = fewo.wohnungsid and
                    bel.belegungsnummer = :old.belegungsnummer;
        
        insert into stornierteBuchungen
            values  (geloeschteBuchungen.nextval, current_date, :old.belegungsnummer,
                    :old.buchungsdatum, :old.anreisetermin, :old.abreisetermin,
                    preis(tage, :old.wohnungsid),
                    zahlungsstatus, :old.belegtvon, vorname, nachname, :old.wohnungsid,
                    wohnbeschreibung);
    end;
    /


