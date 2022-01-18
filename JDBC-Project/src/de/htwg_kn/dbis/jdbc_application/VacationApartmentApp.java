/*
 * NOTE:
 * THIS PACKAGE CONTAINS ONLY A
 * *JDBC SAMPLE* PROGRAM
 * JUST TO SHOW THE USAGE OF THE USAGE OF THE BASIC JDBC API!
 *
 * This is not an example of (good) object-oriented programming ;-)
 */
 
package de.htwg_kn.dbis.jdbc_application;


import java.sql.*;
import java.util.Locale;


/*
 * Vacation Apartment Application:
 * Simple command-line application program to interact with the Vacation Apartment database
 *
 * Author: Prof. Dr. Juergen Waesch, HTWG Konstanz
 * Extended by: Tobias Vogler, Dirk Bechtold, Dominik Gessler, HTWG Konstanz
 * Last modified: Jan 13, 2022
 *
 */
public class VacationApartmentApp {


    //reference to the JDBC connection for the used DBS instance
    private static Connection theConnection = null;


    /*
     * Application's main method:
     * - connect to DBS instance
     * - start main loop: show application's top menu
     * - disconnect from DBS instance
     */
    public static void main(String[] args) {

        System.out.println();
        System.out.println(">>> Starting Vacation Apartment Application ... <<<<<<<<<<<<");
        System.out.println();

        //enable debug output
        DBISUtils.setDebugFlag(true);
        
        
        //connect to DBS instance
        try {

            theConnection = DBISUtils.getConnection();

        } catch (SQLException se) {

            System.out.println();
            System.out.println("An error occurred while establishing connection to DBS:");

            DBISUtils.decodeAndPrintAllSQLExceptions(se);

            System.out.println();
            System.out.println("### Exiting Vacation Apartment Application with failure! ###");
            System.out.println();

            System.exit(-1);

        }


        //invoke main loop: show application's top menu
        System.out.println();
        showTopMenu();


        //disconnect from DBS instance
        System.out.println();
        System.out.println("Closing connection to DBS instance ...");

        try {

            if ((theConnection != null) && (theConnection.isClosed() == false)) {
                theConnection.close();
            }

        } catch (SQLException se) {

            System.out.println("");
            System.out.println("An error occurred while closing the connection to DBS instance:");

            DBISUtils.decodeAndPrintAllSQLExceptions(se);

            System.out.println();
            System.out.println("### Exiting DBIS JDBC sample program with failure! ###");
            System.out.println();

            System.exit(-1);

        }

        System.out.println("... connection to DBS instance closed!");
        System.out.println();

        System.out.println(">>> Exiting DBIS JDBC sample program with success! <<<");
        System.out.println();

        System.exit(0);

    }



    /*
     * main loop: show command-line application's top menu
     */
    private static void showTopMenu() {

        while (true) {

            System.out.println();
            System.out.println("Welche Operation wollen Sie durchf�hren ?");
            System.out.println("-----------------------------------------");

            System.out.println("1) Kunden einfügen");
            System.out.println("2) Kunden suchen");
            System.out.println("3) Ferienwohnung reservieren oder buchen");
            System.out.println("4) Reservierung oder Buchung löschen");
            System.out.println("5) Programm beenden");
            System.out.println();

            // input scan:
            int theChoice = DBISUtils.readIntFromStdIn("Option");

            System.out.println();

            switch (theChoice) {

            case 1:
                //TODO: Method for adding a new costumer -> by modifing addStudent() to addCustomer()
                addKunde();
                break;

            case 2:
                //TODO: Method for case-insensitiv search of a customer by String in forename or familyname  -> by modifing showStudent to showCustomers()
                showKunde();
                break;

            case 3:
                //TODO: Method for adding a reservation or booking for a customer
                //Actions: Select customer -> select vacation apartment -> enter period
                //If available, possibilities for reservation or booking or cancel
                //if not available, enter of a different period
                addKunde();
                break;

            case 4:
                //TODO: Method for deleting a existing reservation of booking
                //modifyStudent();
                break;

            case 5:
                System.out.println();
                System.out.println();
                System.out.println("Programm beenden ...");
                return;

            default:
                System.out.println(theChoice + " ist keine gueltige Option!");
                break;

            }

            System.out.println();
            System.out.println();

        }

    }



    /*
     * sub-menu and transaction for retrieving all students from the database
     */
    private static void showStudents() {

        System.out.println("Alle Studierende anzeigen");
        System.out.println("-----------------------------------------");

        System.out.println();
        int rowCount = printOrte();

        try {
        	
            if (rowCount >= 0) {

                //commit the (read-only) transaction,
                //e.g., to release locks if locking protocol is applied in DBS
                theConnection.commit();

                DBISUtils.printlnDebugInfo("(Read-only) Transaction committed!");

                }

            } catch (SQLException se) {

            DBISUtils.decodeAndPrintAllSQLExceptions(se);

        }


    }



    /*
     * sub-menu and transaction for retrieving data of a particular student in the database
     */
    private static void showKunde() {

        System.out.println("Kunde suchen");
        System.out.println("-----------------------------------------");

        String vorOderNachname = DBISUtils.readFromStdIn("Vor- oder Nachname");

        System.out.println();
        int rowCount = printKunde(vorOderNachname.toUpperCase(Locale.ROOT));

        try {

            if (rowCount >= 0) {

                //commit the (read-only) transaction,
                //e.g., to release locks if locking protocol is applied in DBS
                theConnection.commit();

                DBISUtils.printlnDebugInfo("(Read-only) Transaction committed!");

            }

        } catch (SQLException se) {

            DBISUtils.decodeAndPrintAllSQLExceptions(se);

        }

    }



    /*
     * sub-menu and transaction for adding a student to the database
     */
    private static void addKunde() {

        try {

            System.out.println("Kunde hinzufuegen");
            System.out.println("-----------------------------------------");

            System.out.println("Daten des Kunden:");
            // int newKundennummer = DBISUtils.readIntFromStdIn("Kundennummer");
            String newNachname = DBISUtils.readFromStdIn("Nachname");
            String newVorname = DBISUtils.readFromStdIn("Vorname");
            String newGeburtsdatum = DBISUtils.readDateFromStdIn("Geburtsdatum (dd.mm.yyyy)");
            String newTelefonnummer = DBISUtils.readFromStdIn("Telefonnummer");
            String newEmailAdresse = DBISUtils.readFromStdIn("E-Mail-Adresse");
            String newIBAN = DBISUtils.readFromStdIn("IBAN");
            String newBLZ = DBISUtils.readFromStdIn("BLZ");
            String newKontonummer = DBISUtils.readFromStdIn("Kontonummer");
            String newBIC = DBISUtils.readFromStdIn("BIC");


            System.out.println("Es gibt folgende Orte:");
            printOrte();

            //TODO: ID wird erstmals als korrekt festgelegt, aber Check muss noch eingebaut werden.
            String newOrtsID = DBISUtils.readFromStdIn("Geben Sie eine OrtsID aus der Liste ein");

            String newPLZ = DBISUtils.readFromStdIn("PLZ");
            String newStrasse = DBISUtils.readFromStdIn("Strasse");
            String newHausnummer = DBISUtils.readFromStdIn("Hausnummer");

            //Note: application logic can be improved:
            //      validate if user input is a valid "Fachbereichs-ID"
            //      if user input is not valid, repeat user input or exit transaction on user request


            //*** example of using a JDBC statement for for INSERT / UPDATE / DELETE ***

            Statement stmtBankverbindungen = theConnection.createStatement();

            String sqlStringBankverbindungen = "insert into bankverbindungen (iban, blz, kontonummer, bic)\n" +
                    "    values('" + newIBAN + "', '" + newBLZ + "', '" + newKontonummer + "', '" + newBIC + "')";

            DBISUtils.printlnDebugInfo("SQL statement is:");
            DBISUtils.printlnDebugInfo(sqlStringBankverbindungen);

            int affectedRowsBankverbindungen = stmtBankverbindungen.executeUpdate(sqlStringBankverbindungen);

            Statement stmtAdressen = theConnection.createStatement();

            String sqlStringAdressen = "insert into adressen (adressid, hausnummer, strasse, plz, ortsid)\n" +
                    "    values((select max(adressid) + 1 from adressen), '" + newHausnummer + "', '" + newStrasse + "'," +
                    " '" + newPLZ + "', '" + newOrtsID + "')";

            DBISUtils.printlnDebugInfo("SQL statement is:");
            DBISUtils.printlnDebugInfo(sqlStringAdressen);

            int affectedRowsAdressen = stmtAdressen.executeUpdate(sqlStringAdressen);

            Statement stmtKunden = theConnection.createStatement();

            String sqlStringKunden = "insert into kunden (kundennummer, vorname, nachname, geburtsdatum, telefonnummer, emailadresse, adressid, iban)\n" +
                    "    values((select max(kundennummer) + 1 from kunden), '" + newVorname + "', '" + newNachname + "', '" + newGeburtsdatum + "'," +
                    "'" + newTelefonnummer + "', '" + newEmailAdresse + "', (select max(adressid) from adressen), '" + newIBAN + "')";

            DBISUtils.printlnDebugInfo("SQL statement is:");
            DBISUtils.printlnDebugInfo(sqlStringKunden);

            int affectedRowsKunden = stmtKunden.executeUpdate(sqlStringKunden);

            //commit the transaction
            theConnection.commit();

            //DBISUtils.printlnDebugInfo();
            DBISUtils.printlnDebugInfo("Transaction committed!");

            System.out.println();

            if (affectedRowsBankverbindungen == 1) {
                System.out.println("Die Bankverbindung " + newIBAN + " wurde hinzugefuegt.");
            }
            else {
                System.out.println("Die Bankverbindung " + newIBAN + " konnte nicht hinzugefuegt werden.");
            }

            if (affectedRowsAdressen == 1) {
                System.out.println("Die Adresse " + newStrasse + " " + newHausnummer + " wurde hinzugefuegt.");
            }
            else {
                System.out.println("Die Adresse " + newStrasse + " " + newHausnummer + " konnte nicht hinzugefuegt werden.");
            }

            if (affectedRowsKunden == 1) {
                System.out.println("Der Kunde " + newVorname + " " + newNachname + " wurde hinzugefuegt.");
            }
            else {
                System.out.println("Der Kunde " + newVorname + " " + newNachname + " konnte nicht hinzugefuegt werden.");
            }

            stmtBankverbindungen.close();
            stmtAdressen.close();
            stmtKunden.close();

        } catch (SQLException se) {

            DBISUtils.decodeAndPrintAllSQLExceptions(se);

            try {

                //abort the transaction
                theConnection.rollback();

                System.out.println("");
                System.out.println("Transaction rolled back!");

            } catch (SQLException e) {

                DBISUtils.decodeAndPrintAllSQLExceptions(se);

            }

        }

    }



    /*
     * sub-menu and transaction for modifying a student in the database
     */
    /*
    private static void modifyStudent() {

        try {

            System.out.println("Student/in bearbeiten");
            System.out.println("-----------------------------------------");

            int MatrNr = DBISUtils.readIntFromStdIn("Matrikelnummer des zu bearbeitenden Studierenden");

            System.out.println("Bisherige Daten des Studierenden:");

            int rowCount = printKunde(MatrNr);

            //Note: application logic can be improved:
            //      if no student is found (rowCount = 0), repeat user input or exit transaction on user request

            System.out.println();

            System.out.println("Neue Daten des Studierenden:");
            int newMatrNr = DBISUtils.readIntFromStdIn("MatrNr");
            String newName = DBISUtils.readFromStdIn("Nachname");
            String newVorname = DBISUtils.readFromStdIn("Vorname");

            System.out.println("Es gibt folgende Fachbereiche:");
            printFachbereiche();

            String newFB_ID = DBISUtils.readFromStdIn("Geben Sie eine Fachbereichs-ID ein");

            //Note: application logic can be improved:
            //      validate if user input is a valid "Fachbereichs-ID"
            //      if user input is not valid, repeat user input or exit transaction on user request


            //*** example of using a JDBC prepared statement for INSERT / UPDATE / DELETE ***
            //    NOTE: using a prepared statement does not provide any advantage here,
            //          since the prepared statement is executed only once!

            String sqlPreparedString = "UPDATE Student " +
                                       "SET MatrNr = ?, Fachbereich = ?, Name = ?, Vorname = ? " +
                                       "WHERE MatrNr = ?";

            DBISUtils.printlnDebugInfo("SQL prepared statement is:");
            DBISUtils.printlnDebugInfo(sqlPreparedString);

            PreparedStatement pstmt = theConnection.prepareStatement(sqlPreparedString);

            pstmt.setInt(1, newMatrNr);
            DBISUtils.printlnDebugInfo("1. parameter set to: " + newMatrNr);
            pstmt.setString(2, newFB_ID);
            DBISUtils.printlnDebugInfo("2. parameter set to: " + newFB_ID);
            pstmt.setString(3, newName);
            DBISUtils.printlnDebugInfo("3. parameter set to: " + newName);
            pstmt.setString(4, newVorname);
            DBISUtils.printlnDebugInfo("4. parameter set to: " + newVorname);
            pstmt.setInt(5, MatrNr);
            DBISUtils.printlnDebugInfo("5. parameter set to: " + MatrNr);

            int affectedRows = pstmt.executeUpdate();

            //commit the transaction
            theConnection.commit();

            DBISUtils.printlnDebugInfo("Transaction committed!");

            System.out.println();

            if (affectedRows == 1) {
                System.out.println("Der Studierende mit MatrNr " + MatrNr + " wurde aktualisiert.");
            }
            else {
                System.out.println("Der Studierende mit MatrNr " + MatrNr + " existiert nicht bzw. wurde nicht ver�ndert.");
            }

            pstmt.close();

        } catch (SQLException se) {

            DBISUtils.decodeAndPrintAllSQLExceptions(se);

            try {

                //abort the transaction
                theConnection.rollback();

                System.out.println("");
                System.out.println("Transaction rolled back!");

            } catch (SQLException e) {

                DBISUtils.decodeAndPrintAllSQLExceptions(se);

            }

        }

    }
     */



    /*
     * sub-menu and transaction for removing students from the database
     */
    private static void deleteStudent() {

        try {

            System.out.println("Studierende l�schen");
            System.out.println("-----------------------------------------");

            //flag indicates if (another) student should be deleted
            int flag = 1;


            //*** example of using a JDBC prepared statement for INSERT / UPDATE / DELETE ***
            //    NOTE: using a prepared statement makes sense here,
            //          since the prepared statement is potentially executed more than once!

            String sqlPreparedString = "DELETE FROM Student WHERE MatrNr = ?";

            DBISUtils.printlnDebugInfo("SQL prepared statement is:");
            DBISUtils.printlnDebugInfo(sqlPreparedString);

            PreparedStatement pstmt = theConnection.prepareStatement(sqlPreparedString);

            while (flag == 1) {

                System.out.println("Es gibt folgende Studierende:");
                printOrte();

                int MatrNr = DBISUtils.readIntFromStdIn("Matrikelnummer des zu l�schenden Studierenden");

                pstmt.setInt(1, MatrNr);
                DBISUtils.printlnDebugInfo("1. parameter set to: " + MatrNr);

                int affectedRows = pstmt.executeUpdate();

                //commit the transaction
                theConnection.commit();

                DBISUtils.printlnDebugInfo("Transaction committed!");

                System.out.println();

                if (affectedRows == 1) {
                    System.out.println("Der Studierende mit MatrNr " + MatrNr + " wurde gel�scht.");
                }
                else {
                    System.out.println("Der Studierende mit MatrNr " + MatrNr + " existierte nicht.");
                }

                flag = DBISUtils.readIntFromStdIn("Weitere Studierende l�schen (1 f�r ja)?");

                if (flag == 1) {
                    System.out.println();
                }

            }

            pstmt.close();

        } catch (SQLException se) {

            DBISUtils.decodeAndPrintAllSQLExceptions(se);

            try {

                //abort the transaction
                theConnection.rollback();

                System.out.println("");
                System.out.println("Transaction rolled back!");

            } catch (SQLException e) {

                DBISUtils.decodeAndPrintAllSQLExceptions(se);

            }

        }

    }



    /*
     * retrieve and print a list of *all* students in the database
     */
    private static int printOrte() {


        try {

            Statement stmt = theConnection.createStatement();


            //*** example of using a JDBC statement for SELECT ***

            String sqlString = "select o.ortsid, o.name, l.name\n" +
                    "    from orte o, laender l\n" +
                    "    where o.isocode = l.isocode";

            DBISUtils.printlnDebugInfo("SQL statement is:");
            DBISUtils.printlnDebugInfo(sqlString);

            ResultSet rs = stmt.executeQuery(sqlString);

            int rowCount = DBISUtils.printResultSet(rs);

            stmt.close();
            rs.close();

            return rowCount;

        } catch (SQLException se) {

            DBISUtils.decodeAndPrintAllSQLExceptions(se);

            return -1;

        }

    }



    /*
     * retrieve and print data of a particular student in the database
     */
    private static int printKunde(String vorOderNachnameCaseInsensitiv) {

        try {

            //*** example of using a JDBC prepared statement for SELECT ***
            //    NOTE: using a prepared statement does not provide any advantage here,
            //          since the prepared statement is executed only once!

            String sqlPreparedString = "with upperKunden as\n" +
                    "(select Kundennummer, upper(vorname) as Vorname, upper(nachname) as Nachname\n" +
                    "    from kunden)\n" +
                    "select k.*\n" +
                    "    from upperKunden uk, kunden k\n" +
                    "    where   uk.Kundennummer = k.kundennummer and\n" +
                    "            (uk.vorname like upper('%?%') or\n" +
                    "            uk.nachname like upper('%?%'))";

            DBISUtils.printlnDebugInfo("SQL prepared statement is:");
            DBISUtils.printlnDebugInfo(sqlPreparedString);

            PreparedStatement pstmt = theConnection.prepareStatement(sqlPreparedString);
            // DBISUtils.printlnDebugInfo("Prepared Statement wurde erstellt.");

            pstmt.setString(1, vorOderNachnameCaseInsensitiv);
            DBISUtils.printlnDebugInfo("1. Parameter set to: " + vorOderNachnameCaseInsensitiv);
            pstmt.setString(2, vorOderNachnameCaseInsensitiv);
            DBISUtils.printlnDebugInfo("2. Parameter set to: " + vorOderNachnameCaseInsensitiv);

            ResultSet rs = pstmt.executeQuery();

            int rowCount = DBISUtils.printResultSet(rs);

            pstmt.close();
            rs.close();

            return rowCount;

        } catch (SQLException se) {

            DBISUtils.decodeAndPrintAllSQLExceptions(se);

            return -1;

        }

    }



    /*
     * retrieve and print a list of all departments ("Fachbereiche") in the database
     */
    private static int printFachbereiche() {

        try {

            //*** example of using a JDBC statement for SELECT ***

            Statement stmt = theConnection.createStatement();

            String sqlString = "SELECT f.FB_ID, f.FB_Name " +
                               "FROM Fachbereich f";

            DBISUtils.printlnDebugInfo("SQL statement is:");
            DBISUtils.printlnDebugInfo(sqlString);

            ResultSet rs = stmt.executeQuery(sqlString);

            int rowCount = DBISUtils.printResultSet(rs);

            stmt.close();
            rs.close();

            return rowCount;

        } catch (SQLException se) {

            DBISUtils.decodeAndPrintAllSQLExceptions(se);

            return -1;

        }

    }




}