USE Bank
GO

CREATE PROC usp_RicherThan(@moneyInTheAcc INT = 0) 
AS
	SELECT p.FirstName + ' ' + p.LastName AS [Customer Name], acc.Balance AS [Balance]
	FROM Persons p
	JOIN Accounts acc
		ON p.PersonsID = acc.PersonsID
WHERE acc.Balance > @moneyInTheAcc
GO

EXEC usp_RicherThan 20000