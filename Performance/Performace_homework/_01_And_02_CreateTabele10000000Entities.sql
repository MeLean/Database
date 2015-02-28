-- Problem 1. Create a table in SQL Server
USE [master]
GO

BEGIN TRANSACTION
-- I didn't have any free space on my C: drive for the database, thats why I made database on G: Costed 30 seconds.
-- If you want to create table in default folder just delete FILENAME
    
	CREATE DATABASE [TestSpeed] ON  PRIMARY 
		( NAME = N'Test_Data', FILENAME = N'G:\SotUni\DataBase\Performance\DB\Test_Data.mdf' , SIZE = 6GB , MAXSIZE = UNLIMITED, FILEGROWTH = 500MB )
		 LOG ON 
		( NAME = N'Test_Log', FILENAME = N'G:\SotUni\DataBase\Performance\DB\Test_Log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 16384KB )
    GO
COMMIT


USE TestSpeed;
exec sp_spaceused

CREATE TABLE DateAndTex
(
	CurrentTime DATETIME NULL,
	TextInput NVARCHAR(MAX) NULL
)
GO

-- cost 6 secs for 10000 entities 	
-- INSERT INTO DateAndTex
-- VALUES(GETDATE(), 'put some peppers in the beans');
-- GO 10000

--costed 1 second for 10000 entities minutes on my PC.

-- costed 11 minutes and 54 seconds for 10000000 entities
BEGIN TRANSACTION
	DECLARE @counter INT = 10000000
	WHILE @counter > 0
	BEGIN
		INSERT INTO DateAndTex
		VALUES(GETDATE(), 'put some peppers in the beans'  + CAST(@counter AS NVARCHAR(15)));
		SET @counter = @counter - 1
	END
COMMIT TRANSACTION

-- befor indexing -- Get entities for first minute. Costed 8 seconds.
SELECT COUNT(r.TimeRange)
FROM (SELECT t.CurrentTime AS TimeRange
FROM DateAndTex t
WHERE t.CurrentTime 
BETWEEN CONVERT(DATETIME, '2015-02-22 20:27:35.973', 121) 
AND CONVERT(DATETIME, '2015-02-22 20:28:35.973', 121)) r

-- ready selects for checks --
-- TRUNCATE TABLE DateAndTex
-- SELECT * FROM DateAndTex
-- SELECT COUNT(TextInput) AS [Entities Count] FROM DateAndTex
-- SELECT CurrentTime, TextInput FROM DateAndTex

-- Problem 2. Add an index to speed-up the search by date 
-- Creating index. Costs 15 seconds

CREATE INDEX CurrentTime_Index
ON DateAndTex(CurrentTime)

-- DROP INDEX DateAndTex.CurrentTime_Index

-- clear buffers and cache
DBCC DROPCLEANBUFFERS
DBCC FREEPROCCACHE

-- after indexing -- Get entities for first minute. Costed 2 seconds.
SELECT COUNT(r.TimeRange)
FROM (SELECT t.CurrentTime AS TimeRange
FROM DateAndTex t
WHERE t.CurrentTime 
BETWEEN CONVERT(DATETIME, '2015-02-22 20:27:35.973', 121) 
AND CONVERT(DATETIME, '2015-02-22 20:28:35.973', 121)) r