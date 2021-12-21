-- Set the used date format for the session 
alter session set nls_date_format = 'DD.MM.YYYY'; 

-- Empty Oracle's recycle bin and disable the recycle bin for the session
purge recyclebin;
alter session set recyclebin = off;
-- ALTER SESSION SET recyclebin = ON;

--FK-Constraint ausschalten -> ist ein DDL Statement wird also mit allem davor committed.

/*alter table orte
    disable constraint fk_orte_flughaefen;*/


insert into laender (isocode, name)
    values ('DE', 'Deutschland');
insert into laender (isocode, name)
    values ('CH', 'Schweiz');
insert into laender (isocode, name)
    values ('FR', 'Frankreich');
insert into laender (isocode, name)
    values ('TR', 'Tuerkei');
insert into laender (isocode, name)
    values ('ES', 'Spanien');    
insert into laender (isocode, name)
    values ('GL', 'Groenland');



insert into zusatzausstattungen (Name)  
    values ('Schwimmbad');    
insert into zusatzausstattungen (Name)
    values ('Sauna');
insert into zusatzausstattungen (Name)
    values ('Aufzug');
insert into zusatzausstattungen (Name)
    values ('Autoabstellplatz');
insert into zusatzausstattungen (Name)
    values ('Kinderbetreuung');
insert into zusatzausstattungen (Name)
    values ('Sat-TV');    
insert into zusatzausstattungen (Name)
    values ('Reinigung');
insert into zusatzausstattungen (Name)
    values ('Dachterrasse');
insert into zusatzausstattungen (Name)
    values ('Garage');



insert into bankverbindungen (iban, blz, kontonummer, bic)
    values ('DE85692717230007823212', '69271723', '7823212', 'KARSDE66XXX');
insert into bankverbindungen (iban, blz, kontonummer, bic)
    values ('DE83692717230008929368', '32793968', '8929368', 'BARSDE77XXX');
insert into bankverbindungen (iban, blz, kontonummer, bic)
    values ('DE85692717230001347291', '69271723', '1347291', 'KARSDE66XXX');
insert into bankverbindungen (kontonummer, blz, iban, bic)
    values ('8792978', '29788431', 'CH85692717230008792978', 'MEMECH88XXX');
insert into bankverbindungen (kontonummer, blz, iban, bic)
    values ('9082780', '87890271', 'CH85692717230009082780', 'KONSCH12XXX');
insert into bankverbindungen (kontonummer, blz, iban, bic)
    values ('7322890', '69271723', 'DE85692717230007322890', 'KARSDE66XXX');



insert into fluggesellschaften (iatacode, servicequalitaetskennzahl)
    values ('LH', 1);
insert into fluggesellschaften (iatacode, servicequalitaetskennzahl)
    values ('MT', 8);
insert into fluggesellschaften (iatacode, servicequalitaetskennzahl)
    values ('4U', 4);
insert into fluggesellschaften (iatacode, servicequalitaetskennzahl)
    values ('X3', 9);
insert into fluggesellschaften (iatacode, servicequalitaetskennzahl)
    values ('LX', 8);



insert into orte (ortsid, name, isocode, iatacodeflughafen)
    values (1, 'Konstanz', 'DE', 'FRA');
insert into orte (ortsid, name, isocode, iatacodeflughafen)
    values (2, 'Stuttgart', 'DE', 'FRA');
insert into orte (ortsid, name, isocode, iatacodeflughafen)
    values (3, 'Öludeniz', 'TR', 'ISL');
insert into orte (ortsid, name, isocode, iatacodeflughafen)
    values (4, 'Heidelberg', 'DE', 'FRA');
insert into orte (ortsid, name, isocode, iatacodeflughafen)
    values (5, 'Rust', 'DE', 'FRA');
insert into orte (ortsid, name, isocode, iatacodeflughafen)
    values (6, 'Bern', 'CH', 'ZRH');
insert into orte (ortsid, name, isocode, iatacodeflughafen)
    values (7, 'Zuerich', 'CH', 'ZRH');
insert into orte (ortsid, name, isocode, iatacodeflughafen)
    values (8, 'Chur', 'CH', 'ZRH');
insert into orte (ortsid, name, isocode, iatacodeflughafen)
    values (9, 'Flims-Laax', 'CH', 'ZRH');
insert into orte (ortsid, name, isocode, iatacodeflughafen)
    values (10, 'Antalya', 'TR', 'ISL');
insert into orte (ortsid, name, isocode, iatacodeflughafen)
    values (11, 'Bordeaux', 'FR', 'CDG');
insert into orte (ortsid, name, isocode, iatacodeflughafen)
    values (12, 'Paris', 'FR', 'CDG');
insert into orte (ortsid, name, isocode, iatacodeflughafen)
    values (13, 'Disneyland', 'FR', 'CDG');
insert into orte (ortsid, name, isocode, iatacodeflughafen)
    values (14, 'Barcelona', 'ES', 'BCN');
insert into orte (ortsid, name, isocode, iatacodeflughafen)
    values (15, 'Frankfurt', 'DE', 'FRA');
insert into orte (ortsid, name, isocode, iatacodeflughafen)
    values (16, 'Istanbul', 'TR', 'ISL');



insert into adressen (adressid, hausnummer, strasse, plz, ortsid)
    values (1, '104', 'Reutestr.', '78467', 1);
insert into adressen (adressid, hausnummer, strasse, plz, ortsid)
    values (2, '54', 'Schlossstr.', '70173', 2);
insert into adressen (adressid, hausnummer, strasse, plz, ortsid)
    values (3, '5', 'Highway', '2359', 3);
insert into adressen (adressid, hausnummer, strasse, plz, ortsid)
    values (4, '12', 'Hauptstr.', '69115', 4);
insert into adressen (adressid, hausnummer, strasse, plz, ortsid)
    values (5, '11', 'Alpen.', '3001', 6);    
insert into adressen (adressid, hausnummer, strasse, plz, ortsid)
    values (6, '23', 'Seeweg', '8001', 7);
insert into adressen (adressid, hausnummer, strasse, plz, ortsid)
    values (7, '14', 'Rheingutstr.', '78462', 1);
insert into adressen (adressid, hausnummer, strasse, plz, ortsid)
    values (8, '33', 'Markgrafenstr.', '78461', 1);
insert into adressen (adressid, hausnummer, strasse, plz, ortsid)
    values (9, '189', 'Zur Piste', '2234', 8);
insert into adressen (adressid, hausnummer, strasse, plz, ortsid)
    values (10, '980', 'rue Monsieur', '8234', 11);
insert into adressen (adressid, hausnummer, strasse, plz, ortsid)
    values (11, '22', 'rue de gaulle', '8787', 13);
insert into adressen (adressid, hausnummer, strasse, plz, ortsid)
    values (12, '32', 'rue de la Maison Blanche', '8787', 12);
insert into adressen (adressid, hausnummer, strasse, plz, ortsid)
    values (13, '78', 'rue liberte', '8792', 12);
insert into adressen (adressid, hausnummer, strasse, plz, ortsid)
    values (14, '90', 'Strandweg', '2321', 10);
insert into adressen (adressid, hausnummer, strasse, plz, ortsid)
    values (15, '91', 'Strandweg', '2321', 10);
insert into adressen (adressid, hausnummer, strasse, plz, ortsid)
    values (16, '821', 'Calle del torro', '5221', 14);
insert into adressen (adressid, hausnummer, strasse, plz, ortsid)
    values (17, '45', 'Strandweg', '2321', 10);
insert into adressen (adressid, hausnummer, strasse, plz, ortsid)
    values (18, '1', 'Europapark', '78231', 5);
insert into adressen (adressid, hausnummer, strasse, plz, ortsid)
    values (19, '12', 'Seestr.', '78463', 1);
insert into adressen (adressid, hausnummer, strasse, plz, ortsid)
    values (20, '78', 'Bergweg', '2371', 9);
insert into adressen (adressid, hausnummer, strasse, plz, ortsid)
    values (21, '29', 'GreenOne', '1352', 7);
insert into adressen (adressid, hausnummer, strasse, plz, ortsid)
    values (22, '10', 'rue de gaulle', '8787', 13);
insert into adressen (adressid, hausnummer, strasse, plz, ortsid)
    values (23, '2', 'Am Flughafen', '60541', 15);
insert into adressen (adressid, hausnummer, strasse, plz, ortsid)
    values (24, '1', 'Sabiha Goekcen', '1452', 16);
insert into adressen (adressid, hausnummer, strasse, plz, ortsid)
    values (25, '100', 'Flughafen-Allee', '5098', 7);
insert into adressen (adressid, hausnummer, strasse, plz, ortsid)
    values (26, '1', 'Charles de Gaulle', '8792', 12);
insert into adressen (adressid, hausnummer, strasse, plz, ortsid)
    values (27, '10', 'Aeropuerto de Barcelona', '08820', 14);



insert into ferienwohnungen (wohnungsid, beschreibung, anzahl_zimmer, preis_pro_tag, groesse_qm, adressid)
    values (1, 'Finka', 6, 349, 200, 3);
insert into ferienwohnungen (wohnungsid, beschreibung, anzahl_zimmer, preis_pro_tag, groesse_qm, adressid)
    values (2, 'Ferienwohnung mit Seeblick', 2, 120, 45, 8);
insert into ferienwohnungen (wohnungsid, beschreibung, anzahl_zimmer, preis_pro_tag, groesse_qm, adressid)
    values (3, 'im Schnee', 3, 249, 150, 9);
insert into ferienwohnungen (wohnungsid, beschreibung, anzahl_zimmer, preis_pro_tag, groesse_qm, adressid)
    values (4, 'direkt am Meer', 4, 249, 100, 10);
insert into ferienwohnungen (wohnungsid, beschreibung, anzahl_zimmer, preis_pro_tag, groesse_qm, adressid)
    values (5, 'direkt am Park', 3, 289, 110, 11);
insert into ferienwohnungen (wohnungsid, beschreibung, anzahl_zimmer, preis_pro_tag, groesse_qm, adressid)
    values (6, 'mit Blick auf Eiffelturm', 2, 549, 70, 12);
insert into ferienwohnungen (wohnungsid, beschreibung, anzahl_zimmer, preis_pro_tag, groesse_qm, adressid)
    values (7, 'Dachterrassewohnung zentral', 6, 159, 110, 13);
insert into ferienwohnungen (wohnungsid, beschreibung, anzahl_zimmer, preis_pro_tag, groesse_qm, adressid)
    values (8, 'zweigeschoessiges Haus', 12, 240, 200, 14);
insert into ferienwohnungen (wohnungsid, beschreibung, anzahl_zimmer, preis_pro_tag, groesse_qm, adressid)
    values (9, 'Topvilla am Strand', 5, 159, 111, 15);
insert into ferienwohnungen (wohnungsid, beschreibung, anzahl_zimmer, preis_pro_tag, groesse_qm, adressid)
    values (10, 'Ferienhaus am Strand', 4, 299, 100, 16);
insert into ferienwohnungen (wohnungsid, beschreibung, anzahl_zimmer, preis_pro_tag, groesse_qm, adressid)
    values (11, 'Strandbungalow', 4, 150, 100, 17);



insert into flughaefen (iatacodeflughafen, adressid)
    values ('FRA', 23);
insert into flughaefen (iatacodeflughafen, adressid)
    values ('ISL', 24);
insert into flughaefen (iatacodeflughafen, adressid)
    values ('ZRH', 25);
insert into flughaefen (iatacodeflughafen, adressid)
    values ('CDG', 26);
insert into flughaefen (iatacodeflughafen, adressid)
    values ('BCN', 27);



insert into Touristenattraktionen (Name, Beschreibung, adressid)
    values ('Europapark', 'Freizeitpark', 18);
insert into Touristenattraktionen (Name, Beschreibung, adressid)
    values ('Hoernle', 'Badestrand', 19);
insert into Touristenattraktionen (Name, Beschreibung, adressid)
    values ('Flims-Laax Arena', 'Skigebiet', 20);
insert into Touristenattraktionen (Name, Beschreibung, adressid)
    values ('GreenOne', 'Golfplatz', 21);
insert into Touristenattraktionen (Name, Beschreibung, adressid)
    values ('Disneyland', 'Freizeitpark', 22);
    
    

   
insert into istentfernt (Startort, Zielort, Entfernung)
    values (1, 5, '180');
insert into istentfernt (Startort, Zielort, Entfernung)
    values (8, 7, '120');
insert into istentfernt (Startort, Zielort, Entfernung)
    values (8, 9, '40');
insert into istentfernt (Startort, Zielort, Entfernung)
    values (11, 13, '420');
insert into istentfernt (Startort, Zielort, Entfernung)
    values (12, 13, '30');



insert into Kunden (Kundennummer, Vorname, nachname, Geburtsdatum, Telefonnummer, emailadresse, Adressid, Iban)
    values (1, 'Karl', 'Napf', '01.01.1960', '07531-123456', 'knapf@gmx.de', 1, 'DE85692717230007823212');    
insert into Kunden (Kundennummer, Vorname, nachname, Geburtsdatum, Telefonnummer, emailadresse, Adressid, Iban)
    values (2, 'Hans', 'Meier', '02.01.1975', '06221-999888', 'meiers.hans@t-online.de', 4, 'DE83692717230008929368');
insert into Kunden (Kundennummer, Vorname, nachname, Geburtsdatum, Telefonnummer, emailadresse, Adressid, Iban)
    values (3, 'Franz', 'Huber', '03.01.1980', '0711-554673', 'huber@t-online.de', 2, 'DE85692717230001347291');
insert into Kunden (Kundennummer, Vorname, nachname, Geburtsdatum, Telefonnummer, emailadresse, Adressid, Iban)
    values (4, 'Klaus', 'Eber', '04.01.1985', '+41-171-9864785', 'eber@bluewin.ch', 5, 'CH85692717230008792978');
insert into Kunden (Kundennummer, Vorname, nachname, Geburtsdatum, Telefonnummer, emailadresse, Adressid, Iban)
    values (5, 'Egon', 'Meier', '05.01.1990', '+41-171-9864786', 'meier@gmail. com', 6, 'CH85692717230009082780');    
insert into Kunden (Kundennummer, Vorname, nachname, Geburtsdatum, Telefonnummer, emailadresse, Adressid, Iban)
    values ('6 ', 'Jim', 'Knopf', '06.01.1995', '0171-9876543', 'jim.knopf@gmx.net', 7, 'DE85692717230007322890');



insert into belegungen (belegungsnummer, anreisetermin, abreisetermin, statusflag, buchungsdatum, belegtvon, wohnungsid)
    values (1, '11.03.2016', '13.03.2016', 'Buchung', '12.02.2016', 2, 4);    
insert into belegungen (belegungsnummer, anreisetermin, abreisetermin, statusflag, buchungsdatum, belegtvon, wohnungsid)
    values (2, '11.05.2016', '17.05.2016', 'Reservierung', '13.03.2016', 2, 5);    
insert into belegungen (belegungsnummer, anreisetermin, abreisetermin, statusflag, buchungsdatum, belegtvon, wohnungsid)
    values (3, '03.04.2016', '23.04.2016', 'Reservierung', '10.02.2016', 3, 5);    
insert into belegungen (belegungsnummer, anreisetermin, abreisetermin, statusflag, buchungsdatum, belegtvon, wohnungsid)
    values (4, '04.07.2016', '05.07.2016', 'Buchung', '09.02.2016', 4, 6);
insert into belegungen (belegungsnummer, anreisetermin, abreisetermin, statusflag, buchungsdatum, belegtvon, wohnungsid)
    values (5, '28.04.2016', '02.05.2016', 'Reservierung', '14.02.2016', 2, 10);
insert into belegungen (belegungsnummer, anreisetermin, abreisetermin, statusflag, buchungsdatum, belegtvon, wohnungsid)
    values (6, '04.05.2016', '22.05.2016', 'Buchung', '18.02.2016', 3, 8);
insert into belegungen (belegungsnummer, anreisetermin, abreisetermin, statusflag, buchungsdatum, belegtvon, wohnungsid)
    values (7, '07.05.2016', '08.05.2016', 'Buchung', '01.02.2016', 1, 2);
insert into belegungen (belegungsnummer, anreisetermin, abreisetermin, statusflag, buchungsdatum, belegtvon, wohnungsid)
    values (8, '22.05.2016', '28.05.2016', 'Buchung', '11.02.2016', 5, 9);
insert into belegungen (belegungsnummer, anreisetermin, abreisetermin, statusflag, buchungsdatum, belegtvon, wohnungsid)
    values (9, '03.07.2016', '08.07.2016', 'Buchung', '07.02.2016', 5, 10);
insert into belegungen (belegungsnummer, anreisetermin, abreisetermin, statusflag, buchungsdatum, belegtvon, wohnungsid)
    values (10, '01.05.2016', '24.05.2016', 'Reservierung', '10.02.2016', 4, 1);



insert into rechnungen (rechnungsnummer, betrag, rechnungsdatum, zahlungsdatum, belegungsnummer)
    values ( 1, '498', '15.03.2016', '18.03.2016', 1);
insert into rechnungen (rechnungsnummer, betrag, rechnungsdatum, zahlungsdatum, belegungsnummer)
    values ( 2, '549', '26.02.2016', null, 4);



insert into bilder (dateipfad, bildbeschreibung, bildetab)
    values ('1_1.jpg', 'Aussenansicht', 1);
insert into bilder (dateipfad, bildbeschreibung, bildetab)
    values ('1_2.jpg', 'Innenansicht', 1);
insert into bilder (dateipfad, bildbeschreibung, bildetab)
    values ('5_1.gif', 'Garage', 5);
insert into bilder (dateipfad, bildbeschreibung, bildetab)
    values ('8.jpg', 'Dachterasse', 8);



insert into bietet (wohnungsid, name) 
    values (1, 'Schwimmbad');
insert into bietet (wohnungsid, name) 
    values (1, 'Sauna');
insert into bietet (wohnungsid, name) 
    values (2, 'Autoabstellplatz');
insert into bietet (wohnungsid, name) 
    values (2, 'Aufzug');
insert into bietet (wohnungsid, name) 
    values (3, 'Sauna');
insert into bietet (wohnungsid, name) 
    values (5, 'Kinderbetreuung');
insert into bietet (wohnungsid, name) 
    values (5, 'Schwimmbad');
insert into bietet (wohnungsid, name) 
    values (6, 'Schwimmbad');
insert into bietet (wohnungsid, name) 
    values (7, 'Schwimmbad');
insert into bietet (wohnungsid, name) 
    values (8, 'Sat-TV');
insert into bietet (wohnungsid, name) 
    values (8, 'Reinigung');
insert into bietet (wohnungsid, name) 
    values (8, 'Dachterrasse');
insert into bietet (wohnungsid, name) 
    values (9, 'Schwimmbad');
insert into bietet (wohnungsid, name) 
    values (9, 'Garage');
insert into bietet (wohnungsid, name) 
    values (11, 'Schwimmbad');



insert into anfliegen (startflughafen, zielflughafen, iatacodegesellschaft)
    values ('FRA', 'BCN', 'LH');    
insert into anfliegen (startflughafen, zielflughafen, iatacodegesellschaft)
    values ('FRA', 'ISL', '4U');    
insert into anfliegen (startflughafen, zielflughafen, iatacodegesellschaft)
    values ('FRA', 'CDG', '4U');    
insert into anfliegen (startflughafen, zielflughafen, iatacodegesellschaft)
    values ('FRA', 'CDG', 'LH');    
insert into anfliegen (startflughafen, zielflughafen, iatacodegesellschaft)
    values ('FRA', 'CDG', 'MT');    
insert into anfliegen (startflughafen, zielflughafen, iatacodegesellschaft)
    values ('ISL', 'BCN', 'MT');    
insert into anfliegen (startflughafen, zielflughafen, iatacodegesellschaft)
    values ('CDG', 'BCN', 'X3');    
insert into anfliegen (startflughafen, zielflughafen, iatacodegesellschaft)
    values ('CDG', 'ZRH', 'LH');


--FK-Constraint wieder aktivieren.
/*alter table orte
    enable constraint fk_orte_flughaefen;*/


commit;











			
			

    
