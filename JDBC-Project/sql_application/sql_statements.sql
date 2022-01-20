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
    where   upper(vorname) like upper('%ber%') or
            upper(nachname) like upper('%ber%');

delete from belegungen where belegungsnummer = 1;

select * from belegungen;

delete from belegungen;

select kundennummer, vorname, nachname from kunden;

select  fewo.wohnungsid, fewo.beschreibung, fewo.anzahl_zimmer, fewo.preis_pro_tag,
        fewo.groesse_qm, lae.name as Land, ad.strasse, ad.hausnummer, ad.plz, orte.name as Ort
    from ferienwohnungen fewo, adressen ad, orte, laender lae
    where   fewo.adressid = ad.adressid and
            ad.ortsid = orte.ortsid and
            orte.isocode = lae.isocode;

select distinct bel.belegungsnummer
from ferienwohnungen fewo, belegungen bel
where   bel.wohnungsid = fewo.wohnungsid and
        fewo.wohnungsid = '&wohnungsID' and
        ((bel.anreisetermin between '&anreisetermin' and '&abreisetermin')
        or
        (bel.abreisetermin between '&anreisetermin' and '&abreisetermin')
        or
        (bel.anreisetermin < '&anreisetermin' and bel.abreisetermin > '&abreisetermin'));

insert into belegungen (belegungsnummer, anreisetermin, abreisetermin, statusflag, buchungsdatum, belegtvon, wohnungsid)
    values(select max(belegungsnummer) + 1 from belegungen, );

select count(*)
    from    belegungen
    where   belegungsnummer = '';


rollback;