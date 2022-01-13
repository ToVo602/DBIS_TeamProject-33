/****************************************************/
/* Transaction to delete all data from database     */
/* for DBIS JDBC example                            */
/*                                                  */
/* Author: Prof. Dr. Juergen Waesch, HTWG Konstanz  */
/* Last modified: May 21, 2014                      */
/****************************************************/


/* Commit the running transaction if any */
COMMIT;

/* Set transaction isolation level to ensure serializability of transactions */
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;


/* DML statements to delete all data from table STUDENT */
DELETE FROM Student;


/* DML statements to delete all data from table FACHBEREICH */
DELETE FROM Fachbereich;


/* Commit the transaction */
COMMIT;