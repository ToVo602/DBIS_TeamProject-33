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

with upperKunden as
(select Kundennummer, upper(vorname) as Vorname, upper(nachname) as Nachname
    from kunden)
select k.*
    from upperKunden uk, kunden k
    where   uk.Kundennummer = k.kundennummer and
            (uk.vorname like upper('%ber%') or
            uk.nachname like upper('%ber%'));

delete from belegungen where belegungsnummer = 1;

select * from belegungen;

delete from belegungen;

rollback;