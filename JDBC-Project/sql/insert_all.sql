/****************************************************/
/* Transaction to insert initialdata into database  */
/* for DBIS JDBC example                            */
/*                                                  */
/* Author: Prof. Dr. Juergen Waesch, HTWG Konstanz  */
/* Last modified: May 21, 2014                      */
/****************************************************/


/* Commit the running transaction if any */
COMMIT;

/* Set transaction isolation level to ensure serializability of transactions */
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;


/* DML statements to insert data into table FACHBEREICH */
INSERT INTO Fachbereich (FB_ID, FB_Name) VALUES ('WI', 'Wirtschaftsinformatik');
INSERT INTO Fachbereich (FB_ID, FB_Name) VALUES ('TI', 'Technische Informatik');
INSERT INTO Fachbereich (FB_ID, FB_Name) VALUES ('SE', 'Software Engineering' );


/* DML statements to insert data into table STUDENT */
INSERT INTO Student (MatrNr, Fachbereich, Name, Vorname) VALUES (123456, 'TI', 'Maier',   'Daniela');
INSERT INTO Student (MatrNr, Fachbereich, Name, Vorname) VALUES (456789, 'WI', 'Mueller', 'Susi'   );
INSERT INTO Student (MatrNr, Fachbereich, Name, Vorname) VALUES (789123, 'WI', 'Ebner',   'Simon' );


/* Commit the transaction */
COMMIT;