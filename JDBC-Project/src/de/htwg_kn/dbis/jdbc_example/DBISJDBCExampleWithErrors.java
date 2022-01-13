/*
 * NOTE:
 * THIS PACKAGE CONTAINS ONLY A
 * *JDBC SAMPLE* PROGRAM
 * JUST TO SHOW THE USAGE OF THE USAGE OF THE BASIC JDBC API!
 *
 * This is not an example of (good) object-oriented programming ;-)
 */
 
package de.htwg_kn.dbis.jdbc_example;


import java.sql.*;


/*
 * DBIS JDBC SAMPLE program:
 * Simple command-line application program to interact with the sample database
 *
 * This file contains errors to be corrected!
 *
 * Author: Prof. Dr. Juergen Waesch, HTWG Konstanz
 * Last modified: Jan 10, 2022
 *
 */
public class DBISJDBCExampleWithErrors {


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
        System.out.println(">>> Starting DBIS JDBC sample program ... <<<<<<<<<<<<");
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
            System.out.println("### Exiting DBIS JDBC sample program with failure! ###");
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

            System.out.println("1) Alle Studierende anzeigen");
            System.out.println("2) Studierende suchen");
            System.out.println("3) Student/in hinzufuegen");
            System.out.println("4) Student/in bearbeiten");
            System.out.println("5) Studierende loeschen");
            System.out.println("6) Programm beenden");
            System.out.println();

            int theChoice = DBISUtils.readIntFromStdIn("Option");

            System.out.println();

            switch (theChoice) {

            case 1:
                showStudents();
                break;

            case 2:
                showStudent();
                break;

            case 3:
                addStudent();
                break;

            case 4:
                modifyStudent();
                break;

            case 5:
                deleteStudent();
                break;

            case 6:
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
        int rowCount = printStudents();

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
    private static void showStudent() {

        System.out.println("Student/in suchen");
        System.out.println("-----------------------------------------");

        int MatrNr = DBISUtils.readIntFromStdIn("MatrikelNr des gesuchten Studierenden");

        System.out.println();
        int rowCount = printStudent(MatrNr);

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
    private static void addStudent() {

        try {

            System.out.println("Student/in hinzufuegen");
            System.out.println("-----------------------------------------");

            System.out.println("Daten des Studierenden:");
            int newMatrNr = DBISUtils.readIntFromStdIn("MatrNr");
            String newName = DBISUtils.readFromStdIn("Nachname");
            String newVorname = DBISUtils.readFromStdIn("Vorname");

            System.out.println("Es gibt folgende Fachbereiche:");
            printFachbereiche();

            String newFB_ID = DBISUtils.readFromStdIn("Geben Sie eine Fachbereichs-ID aus der Liste ein");

            //Note: application logic can be improved:
            //      validate if user input is a valid "Fachbereichs-ID"
            //      if user input is not valid, repeat user input or exit transaction on user request


            //*** example of using a JDBC statement for for INSERT / UPDATE / DELETE ***

            Statement stmt = theConnection.createStatement();

            String sqlString = "INSERT INTO Student (MatrNr, Fachbereich, Name, Vorname) " +
                               "VALUES (" + newMatrNr + ", '" + newFB_ID + "', '" + newName + "', '" + newVorname + "')";

            DBISUtils.printlnDebugInfo("SQL statement is:");
            DBISUtils.printlnDebugInfo(sqlString);

            int affectedRows = stmt.executeUpdate(sqlString);

            //commit the transaction
            theConnection.commit();

            //DBISUtils.printlnDebugInfo();
            DBISUtils.printlnDebugInfo("Transaction committed!");

            System.out.println();

            if (affectedRows == 1) {
                System.out.println("Der Studierende mit MatrNr " + newMatrNr + " wurde hinzugefuegt.");
            }
            else {
                System.out.println("Der Studierende mit MatrNr " + newMatrNr + " konnte nicht hinzugefuegt werden.");
            }

            stmt.close();

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
    private static void modifyStudent() {

        try {

            System.out.println("Student/in bearbeiten");
            System.out.println("-----------------------------------------");

            int MatrNr = DBISUtils.readIntFromStdIn("Matrikelnummer des zu bearbeitenden Studierenden");

            System.out.println("Bisherige Daten des Studierenden:");

            int rowCount = printStudent(MatrNr);

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
                printStudents();

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
    private static int printStudents() {


        try {

            Statement stmt = theConnection.createStatement();


            //*** example of using a JDBC statement for SELECT ***

            String sqlString = "SELECT s.MatrNr, s.Name, s.Vorname, f.FB_ID, f.FB_Name " +
                               "FROM Student s, Fachbereich f " +
                               "WHERE s.Fachbereich = f.FB_ID";

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
    private static int printStudent(int MatrNr) {

        try {

            //*** example of using a JDBC prepared statement for SELECT ***
            //    NOTE: using a prepared statement does not provide any advantage here,
            //          since the prepared statement is executed only once!

            String sqlPreparedString = "SELECT s.MatrNr, s.Name, s.Vorname, f.FB_ID, f.FB_Name " +
                                       "FROM Student s, Fachbereich f " +
                                       "WHERE s.fachbereich = f.FB_ID AND MatrNr = ?";

            DBISUtils.printlnDebugInfo("SQL prepared statement is:");
            DBISUtils.printlnDebugInfo(sqlPreparedString);

            PreparedStatement pstmt = theConnection.prepareStatement(sqlPreparedString);

            pstmt.setInt(1, MatrNr);
            DBISUtils.printlnDebugInfo("1. Parameter set to: " + MatrNr);

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
