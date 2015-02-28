USE BANK
GO

ALTER PROC usp_calculateInterestForPeriod(@accountID INT, @yearInterest MONEY = 0.07, @months INT = 12)
AS
	SELECT p.FirstName + ' ' + p.LastName AS [Customer Name], 
	dbo.ufn_calculateInterest(a.Balance, @yearInterest, @months) AS [Account Balance]
FROM Persons p
	JOIN Accounts a
		ON p.PersonsID = a.PersonsID
WHERE a.AccountsID = @accountID
GO

EXEC usp_calculateInterestForPeriod 1, 0.08, 12
