/*
 * NOTE:
 * THIS PACKAGE CONTAINS ONLY A
 * *JDBC SAMPLE* PROGRAM
 * JUST TO SHOW THE USAGE OF THE USAGE OF THE BASIC JDBC API!
 *
 * This is not an example of (good) object-oriented programming ;-)
 */

package de.htwg_kn.dbis.jdbc_example;


import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;


/*
 * DBIS JDBC SAMPLE program:
 * Simple command-line application program to test connection with the (Oracle) Database System
 *
 * Author: Prof. Dr. Juergen Waesch, HTWG Konstanz
 * Last modified:  Jan 10, 2022
 *
 */
public class DBISJDBCTest {
	

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


	        //Test access to DBS instance / database

	        System.out.println("TEST QUERY ON ORACLE DATA DICTIONARY: Show Contents of View User_Catalog");
	        
	        printUserCatalog();
	        


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
	     * retrieve and print a list of *all* students in the database
	     */
	    private static int printUserCatalog() {


	        try {

	            Statement stmt = theConnection.createStatement();

	            //*** example of using a JDBC statement for SELECT ***

	            String sqlString = "SELECT Table_Name, Table_Type " +
	                               "FROM User_Catalog";

	            DBISUtils.printlnDebugInfo("SQL statement is:");
	            DBISUtils.printlnDebugInfo(sqlString);

	            ResultSet rs = stmt.executeQuery(sqlString);

	            int rowCount = DBISUtils.printResultSet(rs);

	            stmt.close();
	            rs.close();
	            
	            theConnection.commit();

	            return rowCount;

	        } catch (SQLException se) {

	            DBISUtils.decodeAndPrintAllSQLExceptions(se);

	            return -1;

	        }

	    }




}
