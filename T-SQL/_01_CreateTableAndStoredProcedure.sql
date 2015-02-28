CREATE TABLE Persons
(
	PersonsID INT IDENTITY,
	FirstName NVARCHAR(50) NOT NULL,
	LastName NVARCHAR(60) NOT NULL,
	SSN NVARCHAR(9) NOT NULL,
	CONSTRAINT PK_PersonsID PRIMARY KEY (PersonsID),
	CONSTRAINT UC_SSN UNIQUE (SSN)
)
GO

CREATE TABLE Accounts
(
	AccountsID INT IDENTITY,
	Balance money NOT NULL,
	PersonsID INT NOT NULL,
	CONSTRAINT PK_AccountsID PRIMARY KEY (AccountsID),
	CONSTRAINT FK_PersonsID FOREIGN KEY (PersonsID)	
	REFERENCES Persons(PersonsID)
)
GO

INSERT INTO Persons
VALUES ('Susan', 'Dimitrova', '012345678'),
	   ('Kim', 'Beisinger','123456789'),
	   ('Jimmy','Chue','234567891')
GO

INSERT INTO Accounts
VALUES (10000.50, 1),
	   (4300000.40, 2),
	   (234782287.00, 3)
GO

USE Bank
GO

CREATE PROC dbo.usp_SelectPersonsFullNames
AS
  SELECT p.FirstName + ' ' + p.LastName
  FROM Persons p
GO

EXEC dbo.usp_SelectPersonsFullNames

