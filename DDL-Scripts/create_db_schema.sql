-- Set the used date format for the session 
ALTER SESSION SET nls_date_format = 'DD.MM.YYYY'; 

-- Empty Oracle's recycle bin and disable the recycle bin for the session
PURGE RECYCLEBIN;
ALTER SESSION SET RECYCLEBIN = OFF;
-- ALTER SESSION SET recyclebin = ON;



/* DDL statement to create table <Tablename> */

CREATE TABLE fluggesellschaften(
    iatacode VARCHAR2(256) CONSTRAINT pk_fluggesellschaften PRIMARY KEY,
    servicequalitaetskennzahl INTEGER NOT NULL CONSTRAINT check_fluggesellschaften_servicequalitaetskennzahl CHECK(servicequalitaetskennzahl BETWEEN 1 AND 10));

COMMENT ON COLUMN fluggesellschaften.servicequalitaetskennzahl IS '10 ist das Beste und 1 das schlechteste Ergebnis.';

    
CREATE TABLE laender(
    isocode CHAR(2) CONSTRAINT pk_laender PRIMARY KEY,
    NAME VARCHAR2(256) NOT NULL CONSTRAINT ak_laender UNIQUE);


CREATE TABLE bankverbindungen(
    iban CHAR(22) CONSTRAINT pk_bankverbindungen PRIMARY KEY,
    blz CHAR(8) NOT NULL,
    kontonummer CHAR(10) NOT NULL,
    bic CHAR(11) NOT NULL,
    CONSTRAINT ak_bankverbindungen UNIQUE (blz, kontonummer));
  
    
-- flughafen erstmal ohne FK -> spaeter ueber alter table wieder hinzufuegen.
CREATE TABLE flughaefen(
    iatacodeflughafen VARCHAR2(256) CONSTRAINT pk_flughaefen PRIMARY KEY,
    adressid int NOT NULL CONSTRAINT ak_flughaefen UNIQUE);


CREATE TABLE orte(
    ortsid INT CONSTRAINT pk_orte PRIMARY KEY,
    NAME VARCHAR2(256) NOT NULL,
    isocode CHAR(2) NOT NULL CONSTRAINT fk_orte_laender REFERENCES laender(isocode),
    iatacodeflughafen VARCHAR2(256) NOT NULL CONSTRAINT fk_orte_flughaefen REFERENCES flughaefen(iatacodeflughafen) DEFERRABLE INITIALLY DEFERRED);

    
CREATE TABLE adressen(
    adressid INT CONSTRAINT pk_adressen PRIMARY KEY,
    hausnummer VARCHAR2(256) NOT NULL,
    strasse VARCHAR2(256) NOT NULL,
    plz VARCHAR2(256) NOT NULL,
    ortsid INT NOT NULL CONSTRAINT fk_adressen_orte REFERENCES orte(ortsid));


CREATE TABLE ferienwohnungen(
    wohnungsid INT CONSTRAINT pk_ferienwohnungen PRIMARY KEY,
    beschreibung VARCHAR2(256) NOT NULL,
    anzahl_zimmer INTEGER NOT NULL CONSTRAINT check_ferienwohnungen_anzahl_zimmer CHECK (anzahl_zimmer > 0),
    preis_pro_tag NUMBER(12,2) NOT NULL CONSTRAINT check_ferienwohnungen_preis_pro_tag CHECK (preis_pro_tag >= 0),
    groesse_qm NUMBER (6,2) NOT NULL CONSTRAINT check_ferienwohnungen_groesse_qm CHECK (groesse_qm > 0),
    adressid INT NOT NULL CONSTRAINT ak_ferienwohnungen UNIQUE CONSTRAINT fk_ferienwohnungen_adressen REFERENCES adressen(adressid));


CREATE TABLE bilder(
    dateipfad VARCHAR2(256) CONSTRAINT pk_bilder PRIMARY KEY,
    bildbeschreibung VARCHAR2(256) NOT NULL,
    bildetab INT NOT NULL CONSTRAINT fk_bilder_ferienwohnungen REFERENCES ferienwohnungen(wohnungsid) ON DELETE CASCADE);

COMMENT ON TABLE bilder IS 'zusaetzliche Constraint waere maximal vier Bilder je Ferienwohnung';


CREATE TABLE zusatzausstattungen(
    NAME VARCHAR2(256) CONSTRAINT pk_zusatzausstattungen PRIMARY KEY);


CREATE TABLE touristenattraktionen(
    NAME VARCHAR2(256) CONSTRAINT pk_touristenattraktionen PRIMARY KEY,
    beschreibung VARCHAR2(256),
    adressid INT NOT NULL CONSTRAINT ak_touristenattraktionen UNIQUE CONSTRAINT fk_touristenattraktionen_adressen REFERENCES adressen(adressid));


CREATE TABLE kunden(
    kundennummer INT CONSTRAINT pk_kunden PRIMARY KEY,
    vorname VARCHAR2(256) NOT NULL,
    nachname VARCHAR2(256) NOT NULL,
    geburtsdatum DATE NOT NULL,
    telefonnummer VARCHAR2 (32) NOT NULL,
    emailadresse VARCHAR2 (256) NOT NULL CONSTRAINT ak1_kunden UNIQUE, -- evtl. mit check nach "." und "@"
    adressid INT NOT NULL CONSTRAINT ak2_kunden UNIQUE CONSTRAINT fk_kunden_adressen REFERENCES adressen(adressid),
    iban CHAR(22) NOT NULL CONSTRAINT ak3_kunden UNIQUE CONSTRAINT fk_kunden_bankverbindungen REFERENCES bankverbindungen(iban));


CREATE TABLE belegungen(
    belegungsnummer INT CONSTRAINT pk_belegungen PRIMARY KEY,
    anreisetermin DATE NOT NULL,
    abreisetermin DATE NOT NULL,
    statusflag VARCHAR2(12) NOT NULL CONSTRAINT check_belegungen_statusflag CHECK(statusflag IN ('Reservierung', 'Buchung')),
    buchungsdatum DATE NOT NULL,
    belegtvon INT NOT NULL CONSTRAINT fk_belegungen_kunden REFERENCES kunden(kundennummer) ON DELETE CASCADE,
    wohnungsid INT NOT NULL CONSTRAINT fk_belegungen_ferienwohnungen REFERENCES ferienwohnungen(wohnungsid) ON DELETE CASCADE,
    CONSTRAINT check_belegungen_anreisetermin_abreisetermin CHECK(anreisetermin < abreisetermin));

COMMENT ON COLUMN belegungen.statusflag IS 'Umwandlung von Reservierung zu Buchung ist moeglich, andersherum nicht.';


CREATE TABLE rechnungen(
    rechnungsnummer INT CONSTRAINT pk_rechnungen PRIMARY KEY,
    betrag NUMBER(12,2) NOT NULL CONSTRAINT check_rechnungen_betrag CHECK(betrag >= 0),
    rechnungsdatum DATE NOT NULL,
    zahlungsdatum DATE,
    belegungsnummer INT NOT NULL CONSTRAINT ak_rechnungen UNIQUE CONSTRAINT fk_rechnungen_belegungen REFERENCES belegungen(belegungsnummer) ON DELETE CASCADE,
    CONSTRAINT check_rechnungen_zahlungsdatum_rechnungsdatum CHECK(zahlungsdatum >= rechnungsdatum));


CREATE TABLE bietet(
    wohnungsid INT CONSTRAINT fk_bietet_ferienwohnungen REFERENCES ferienwohnungen(wohnungsid) ON DELETE CASCADE,
    NAME VARCHAR2(256) CONSTRAINT fk_bietet_zusatzausstattung REFERENCES zusatzausstattungen(NAME),
    CONSTRAINT pk_bietet PRIMARY KEY(wohnungsid, NAME));


CREATE TABLE anfliegen(
    startflughafen VARCHAR2(256) CONSTRAINT fk_anfliegen_startflughafen_flughaefen REFERENCES flughaefen(iatacodeflughafen),
    zielflughafen VARCHAR2(256) CONSTRAINT fk_anfliegen_zielflughafen_flughaefen REFERENCES flughaefen(iatacodeflughafen),
    iatacodegesellschaft VARCHAR2(256) CONSTRAINT fk_anfliegen_fluggesellschaften REFERENCES fluggesellschaften(iatacode) ON DELETE CASCADE,
    CONSTRAINT pk_anfliegen PRIMARY KEY(startflughafen, zielflughafen, iatacodegesellschaft),
    CONSTRAINT check_anfliegen_startflughafen_zielflughafen CHECK(startflughafen<>zielflughafen));


CREATE TABLE istentfernt(
    startort INT CONSTRAINT fk_istentfernt_startort_orte REFERENCES orte(ortsid),
    zielort INT CONSTRAINT fk_istentfernt_zielort_orte REFERENCES orte (ortsid),
    entfernung NUMBER(12,2) NOT NULL CONSTRAINT check_istentfernt_entfernung CHECK(entfernung>=0),
    CONSTRAINT check_istentfernt_startort_zielort CHECK(startort<>zielort),
    CONSTRAINT pk_istentfernt PRIMARY KEY(startort, zielort));


ALTER TABLE flughaefen
    ADD CONSTRAINT fk_flughaefen_adressen FOREIGN KEY (adressid) REFERENCES adressen(adressid);
  
-- commit; -> DDL Statements werden automatisch committed, also nicht unbedingt notwendig

CREATE OR REPLACE VIEW reservierungen (belegungsnummer, anreisetermin, abreisetermin, buchungsdatum, belegtvon, wohnungsid) AS
    SELECT belegungsnummer, anreisetermin, abreisetermin, buchungsdatum, belegtvon, wohnungsid
    FROM belegungen bel
    WHERE bel.statusflag = 'Reservierung';


CREATE OR REPLACE VIEW buchungen (belegungsnummer, anreisetermin, abreisetermin, buchungsdatum, belegtvon, wohnungsid) AS
    SELECT belegungsnummer, anreisetermin, abreisetermin, buchungsdatum, belegtvon, wohnungsid
    FROM belegungen bel
    WHERE bel.statusflag = 'Buchung';
    

CREATE OR REPLACE VIEW familienwohnungen (wohnungsid, beschreibung, anzahl_zimmer, preis_pro_tag, groesse_qm, adressid) AS
    SELECT wohnungsid, beschreibung, anzahl_zimmer, preis_pro_tag, groesse_qm, adressid
    FROM ferienwohnungen fewo
    WHERE fewo.groesse_qm > 100
WITH CHECK OPTION;


CREATE OR REPLACE VIEW uebersichtkunden (kundennummer, vorname, nachname, geburtsdatum, telefonnummer, emailadresse, iban, 
                            strasse, hausnummer, plz, ort, wohnungsnummer, beschreibung, rechnungserstellung) AS
    SELECT  kun.kundennummer, kun.vorname, kun.nachname, kun.geburtsdatum, kun.telefonnummer, kun.emailadresse, bank.iban, ad.strasse,
            ad.hausnummer, ad.plz, orte.NAME, fewo.wohnungsid, fewo.beschreibung, CASE
                                                                                    WHEN rech.rechnungsnummer IS NULL THEN 'Nein'
                                                                                    ELSE 'ja'
                                                                                    END AS rechnungserstellung
    FROM    kunden kun LEFT OUTER JOIN belegungen bel ON (kun.kundennummer = bel.belegtvon)
            LEFT OUTER JOIN ferienwohnungen fewo ON(fewo.wohnungsid = bel.wohnungsid)
            LEFT OUTER JOIN rechnungen rech ON(rech.belegungsnummer = bel.belegungsnummer),
            bankverbindungen bank, adressen ad, orte
    WHERE   kun.iban = bank.iban
            AND
            kun.adressid = ad.adressid
            AND
            ad.ortsid = orte.ortsid;


CREATE OR REPLACE VIEW zahlungsstatus      (belegungsnummer, anreisetermin, abreisetermin, buchungsdatum, wohnungsid, beschreibung,
                                            kundennummer, vorname, nachname, rechnungsnummer, rechnungsdatum,
                                            rechnungsbetrag, zahlungsstatus, zahlungsdatum) AS
    SELECT      bel.belegungsnummer, bel.anreisetermin, bel.abreisetermin, bel.buchungsdatum, fewo.wohnungsid, fewo.beschreibung,
                kun.kundennummer, kun.vorname, kun.nachname, rech.rechnungsnummer, rech.rechnungsdatum, rech.betrag,
                CASE
                    WHEN rech.zahlungsdatum IS NULL THEN 'offen'
                    ELSE 'bezahlt'
                    END AS zahlungsstatus, rech.zahlungsdatum
    FROM        belegungen bel LEFT OUTER JOIN rechnungen rech ON (bel.belegungsnummer = rech.belegungsnummer), ferienwohnungen fewo, kunden kun
    WHERE       bel.statusflag = 'Buchung'
                AND
                bel.wohnungsid = fewo.wohnungsid
                AND
                bel.belegtvon = kun.kundennummer;


CREATE OR REPLACE VIEW midagekunden (kundennummer, vorname, nachname, geburtsdatum, kundenalter, telefonnummer, emailadresse, adressid, iban) AS 
    SELECT  kun.kundennummer, kun.vorname, kun.nachname, kun.geburtsdatum, floor(months_between(sysdate, kun.geburtsdatum)/12),
    kun.telefonnummer, kun.emailadresse, kun.adressid, kun.iban 
    FROM    kunden kun
    WHERE   floor(months_between(sysdate, kun.geburtsdatum)/12) BETWEEN 30 AND 40;


create sequence geloeschteBuchungen
    increment by 1
    start with 1;


create or replace function preis(Tage int, FeWoNr int)
    return number as
    buchungswert number(12,2);
    tagespreis number(12,2);
    begin
        select fewo.preis_pro_tag into tagespreis
            from ferienwohnungen fewo
            where fewo.wohnungsid = FeWoNr;
        buchungswert := tagespreis * Tage;
        return buchungswert;
    end;
    /


CREATE TABLE stornierteBuchungen(
    Stornonummer int primary key,
    Stornodatum date not null,
    BuchungsNr int not null constraint ak_stornierteBuchungen unique,
    Buchungsdatum date not null,
    Buchungsanfang date not null,
    Buchungsende date not null,
    Buchungswert number(12,2) not null,
    Zahlungsstatus varchar2(256) not null constraint check_stornierteBuchungen_Zahlungsstatus check (zahlungsstatus in ('bezahlt', 'offen')),
    Kundennummer int not null,
    Vorname varchar2(256) not null,
    Nachname varchar2(256) not null,
    Wohnungsid int not null,
    WohnBeschreibung varchar(256) not null);

    
    









