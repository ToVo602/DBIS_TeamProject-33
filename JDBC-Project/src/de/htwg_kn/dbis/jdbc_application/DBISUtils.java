/*
 * NOTE:
 * THIS PACKAGE CONTAINS ONLY A
 * *JDBC SAMPLE* PROGRAM
 * JUST TO SHOW THE USAGE OF THE USAGE OF THE BASIC JDBC API!
 *
 * This is not an example of (good) object-oriented programming ;-)
 */
package de.htwg_kn.dbis.jdbc_application;


import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.sql.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;


/*
 * UTILITY CLASS for DBIS JDBC SAMPLE program
 *
 * Author: Prof. Dr. Juergen Waesch, HTWG Konstanz
 * Last modified:  Jan 10, 2022
 *
 */
public class DBISUtils {


    // Debug flag: if set to true, the "debug info" methods print to standard out
    private static boolean DEBUG = false;


    // Reference to the JDBC connection
    private static Connection theConnection = null;



    // TODO: SET "DB_LOGIN" AND "DB_PASSWORD" TO YOUR ORACLE LOGIN AND PASSWORD!!!

    // User(name) and password used for connecting to the DBS instance
    private static final String DB_LOGIN =    "dbs33";
    private static final String DB_PASSWORD = "dbs33";


    // Connection parameters to be used for connecting to the DBIS@HTWG Oracle 19c DBS instance are:
    // + jdbc:oracle:thin:             -> identifier for the thin Oracle JDBC driver
    // + oracle19c.in.htwg-konstanz.de -> host running the Oracle DBS instance
    // + 1521                          -> port used by the Oracle DBS instance for JDBC connections
    // + ora19c                        -> identifier of the Oracle DBS instance to be connected with

    // Oracle JDBC-URL pattern is:
    // <Oracle-JDBC-Driver-identifier>@<host>:<port>:<instance-identifier>,
    // e.g.,         jdbc:oracle:thin:@oracle19c.in.htwg-konstanz.de:1521:ora19c


    // TODO: PROVIDE THE CORRECT ORACLE JDBC-URL!!!

    // JDBC-URL to connect to the DBIS@HTWG Oracle DBS instance
    private static final String DB_CONNPARAMSTRING = "jdbc:oracle:thin:@oracle19c.in.htwg-konstanz.de:1521:ora19c";



    /*
     * Set the debug flag:
     * if set to true, the "debug info" methods print to standard out
     */
    public static void setDebugFlag(boolean theDebugFlag) {

        DEBUG = theDebugFlag;

    }


    /*
     * Create or return a JDBC connection to connect to an Oracle DBS instance
     * (with auto-commit disabled and serializability as isolation level)
     */
    public static Connection getConnection() throws SQLException {

        //if JDBC connection does not already exist, create it
        if (theConnection == null) {

            System.out.println();

            System.out.println("Loading Oracle JDBC driver ...");
            DriverManager.registerDriver(new oracle.jdbc.OracleDriver());
            System.out.println("... Oracle JDBC driver loaded!");

            System.out.println();

            System.out.println("Connecting to DBS instance ...");
            System.out.println(" - JDBC-URL: " + DB_CONNPARAMSTRING);
            System.out.println(" - User    : " + DB_LOGIN);
            Connection aConnection = DriverManager.getConnection(DB_CONNPARAMSTRING, DB_LOGIN, DB_PASSWORD);
            System.out.println("... connected to DBS instance!");

            System.out.println();

            System.out.println("Setting transaction parameters for connection ...");

            // Set the transaction isolation level to serializable:
            // to be sure that the DBS uses serializability as correctness criterion
            System.out.println(" - transaction isolation level is    : " + aConnection.getTransactionIsolation()
                    + " (" + decodeTransactionIsolationLevel(aConnection.getTransactionIsolation()) + ")");
            aConnection.setTransactionIsolation(Connection.TRANSACTION_SERIALIZABLE);
            System.out.println(" - transaction isolation level is now: " + aConnection.getTransactionIsolation()
                    + " (" + decodeTransactionIsolationLevel(aConnection.getTransactionIsolation()) + ")");

            // Turn off auto-commit to respect the transaction borders:
            // transactions are not automatically/implicitly committed after each SQL DML statement
            System.out.println(" - auto commit is     : " + aConnection.getAutoCommit());
            aConnection.setAutoCommit(false);
            System.out.println(" - auto commit is now : " + aConnection.getAutoCommit());

            System.out.println("... transaction parameters for connection set!");

            System.out.println();

            System.out.println("JDBC connection ready to use!");
            System.out.println();

            theConnection = aConnection;
        }

        return theConnection;

    }



    /*
     * Decode SQL transaction isolation levels
     */
    public static String decodeTransactionIsolationLevel(int transactionIsolationLevel) {

        switch (transactionIsolationLevel) {

            case Connection.TRANSACTION_NONE:
                return "No transactions supported";
            case Connection.TRANSACTION_READ_COMMITTED:
                return "Read committed";
            case Connection.TRANSACTION_READ_UNCOMMITTED:
                return "Read uncommitted";
            case Connection.TRANSACTION_REPEATABLE_READ:
                return "Repeatable read";
            case Connection.TRANSACTION_SERIALIZABLE:
                return "Serializable";
            default:
                return "Unknown trasaction isolation level";
        }

    }



    /*
     * Decode and print a single SQL exception to standard output
     */
    public static void decodeAndPrintSQLException(SQLException se)  {

        System.out.println();
        
        System.out.println("*** SQL exception: ***********");
        System.out.println("  - Error message     : " + se.getMessage().replaceAll("\\n", " "));
        System.out.println("  - SQL state         : " + se.getSQLState());
        System.out.println("  - Vendor error code : " + se.getErrorCode());
        System.out.println("******************************");
		
    }



    /*
     * Decode and print *all* chained SQL exceptions
     */
    public static void decodeAndPrintAllSQLExceptions(SQLException anSQLException)  {

        SQLException theActualSQLException = anSQLException;

        while (theActualSQLException != null) {

            decodeAndPrintSQLException(theActualSQLException);
            theActualSQLException = theActualSQLException.getNextException();

        }

    }



    /*
     *  "Simple" generic print method to
     *  print the data of any JDBC result set to standard output
     *
     *  Note: method can be improved / output formatting can be beautified
     */
    public static int printResultSet(ResultSet rset) {

        int noRows = 0;

        try {

            ResultSetMetaData rsmd = rset.getMetaData();

            while(rset.next()){

                if (noRows == 0) {

                    for(int i=1; i<=rsmd.getColumnCount(); i++) {
                        System.out.print(rsmd.getColumnName(i));
                        if (i == rsmd.getColumnCount()) {
                            System.out.print("\n");
                        }
                        else {
                            System.out.print("\t");
                        }
                    }
                }

                for(int col=1; col<=rsmd.getColumnCount(); col++) {
                    System.out.print(rset.getObject(col));
                    if (col == rsmd.getColumnCount()) {
                        System.out.print("\n");
                    }
                    else {
                        System.out.print("\t");
                    }
                }

                noRows++;

            }

        } catch (SQLException se) {

            decodeAndPrintAllSQLExceptions(se);

            return -1;

        }


        if (noRows == 0) {

            System.out.println("No rows found!");

        }

        return noRows;

    }



    /*
     *  Simple Method to
     *  handle reading of strings from standard input
     *  (prints a caption to standard output and reads data from standard input)
     */
    public static String readFromStdIn(String aCaption) {

        BufferedReader stdIn = new BufferedReader(new InputStreamReader(System.in));
        String inputString;

        System.out.print(aCaption + ": ");

        try {

            inputString = stdIn.readLine();

        }

        catch (Exception e){

            System.out.println();
            System.out.println("Error: " + e.getMessage());
            System.out.println();

            return null;

        }

        return inputString;

    }



    /*
     *  Simple Method to
     *  handle reading of integer values from standard input
     *  (prints a caption to standard output and reads data from standard input)
     */
    public static int readIntFromStdIn(String aCaption) {

        while(true) {

            String inputString = readFromStdIn(aCaption);

            try {

                return Integer.parseInt(inputString);

            }

            catch (Exception e) {

                System.out.println();
                System.out.println("Error: " + e.getMessage());
                System.out.println("Please provide a correct integer value!");
                System.out.println();

            }

        }

    }



    /*
     *  Simple Method to
     *  handle reading of date values from standard input
     *  (prints a caption to standard output and reads data from standard input)
     */
    public static String readDateFromStdIn(String aCaption) {

        while(true) {

            String inputString = readFromStdIn(aCaption);

            try {

                //validate if input string represents a valid/correct date value/format
                //date format is adjusted to 'dd.MM.yyyy', e.g., '24.12.1928'
                validateDateString(inputString,"dd.MM.yyyy");

                return inputString;

            }

            catch (Exception e) {

                System.out.println();
                System.out.println("Error: " + e.getMessage());
                System.out.println("Please provide a correct date value!");
                System.out.println();

            }

        }

    }



    /*
     *  Print debug information (followed by newline) to standard output
     *  if debug mode is activated (debug flag == true)
     */
    public static void printlnDebugInfo(String aDebugInfo) {

        if (DEBUG)  {
            System.out.println(">>>DEBUG INFO: " + aDebugInfo);
        }

    }



    /*
     *  Print debug information to standard output
     *  if debug mode is activated (debug flag == true)
     */
    public static void printDebugInfo(String aDebugInfo) {

        if (DEBUG)  {
            System.out.print(">>>DEBUG INFO: " + aDebugInfo);
        }

    }



    /*
     *  Print newline to standard output
     *  if debug mode is activated (debug flag == true)
     *
     */
    public static void printlnDebugInfo() {

        if (DEBUG)  {
            System.out.println();
        }

    }



    /*
     *  *Simple* method to validate if the given date string represents a
     *  a valid/correct date value/format with respect the given date format string
     *
     *  Note: works in a lot of cases; not proven that it works in all cases
     */
     public static Date validateDateString(String aDateString, String aDateFormatString) throws ParseException {

        SimpleDateFormat sdf = new SimpleDateFormat(aDateFormatString);

        //use strict parsing instead of lenient parsing: with strict parsing,
        //the date string must match the (simple date format) object's format
        sdf.setLenient(false);

        try {

            Date aDate = sdf.parse(aDateString);

            //printlnDebugInfo("Date string is: "+ aDateString);
            //printlnDebugInfo("Date after parsing is: "+ aDate);
            //printlnDebugInfo("Parsed date after formatting is: "+ sdf.format(aDate));
            //printlnDebugInfo("Date string cut is: "+ aDateString.substring(0,Math.min(aDateString.length(),10)));

            //cross check if parsed date's string representation is equal to the given date string
            if (sdf.format(aDate).equals(aDateString.substring(0,Math.min(aDateString.length(),10)))) {

                return aDate;

            } else {

                throw new ParseException("Incorrect date (format is '" + aDateFormatString + "'): " + "\"" + aDateString + "\"", 0);

            }

        }

        catch (ParseException pe) {

            throw new ParseException("Incorrect date (format is '" + aDateFormatString + "'): " + "\"" + aDateString + "\"", 0);

        }


    }




}

