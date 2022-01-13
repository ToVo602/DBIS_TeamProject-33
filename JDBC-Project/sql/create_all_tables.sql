/****************************************************/
/* Create database schema for DBIS JDBC example     */
/*                                                  */
/* Author: Prof. Dr. Juergen Waesch, HTWG Konstanz  */
/* Last modified: May 21, 2014                      */
/****************************************************/


/* DDL statement to create table FACHBEREICH */
CREATE TABLE Fachbereich (
  FB_ID   CHAR(5) CONSTRAINT PK_Fachbereich PRIMARY KEY,
  FB_Name VARCHAR2(40) NOT NULL);


/* DDL statement to create table STUDENT */
CREATE TABLE Student (
  MatrNr      NUMBER(6) CONSTRAINT PK_Student PRIMARY KEY CONSTRAINT CK_Student_MatrNr CHECK (MatrNr >= 100000 AND MatrNr <= 999999),
  Fachbereich CHAR(5) NOT NULL,
  Name        VARCHAR2(40) NOT NULL,
  Vorname     VARCHAR2(40),
  CONSTRAINT FK_Student_Fachbereich FOREIGN KEY (Fachbereich) REFERENCES Fachbereich(FB_ID));
