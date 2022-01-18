-- SELECT für alle Orte samt Länder
select o.ortsid, o.name, l.name
    from orte o, laender l
    where o.isocode = l.isocode;
    
insert into bankverbindungen (iban, blz, kontonummer, bic)
    values();

insert into adresse (adressid, hausnummer, strasse, plz, ortsid)
    values((select max(adressid) + 1 from adressen), );
(select max(adressid) + 1 from adressen);

insert into kunden (kundennummer, vorname, nachname, geburtsdatum, telefonnummer, emailadresse, iban)
    values((select max(kundennummer) + 1 from kunden), newKundennummer, newVorname, newNachname, newGeburtsdatum, newTelefonnummer, newEmailAdresse, newIBAN);
(select max(kundennummer) + 1 from kunden);

select *
    from kunden
    where   vorname = upper('&name') or
            nachname = upper('&name');