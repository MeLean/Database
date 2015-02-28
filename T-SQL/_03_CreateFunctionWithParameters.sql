USE Bank
GO 

CREATE FUNCTION ufn_calculateInterest(@amount MONEY, @yearlyInterestRate MONEY, @numberOfMonths INT) 
RETURNS money AS
BEGIN
	RETURN @amount * (1 + @yearlyInterestRate) * @numberOfMonths
END
GO
-- checks Balance befor calculations
SELECT p.FirstName + ' ' + p.LastName AS [Customer Name], a.Balance AS [Account Balance]
FROM Persons p
	JOIN Accounts a
		ON p.PersonsID = a.PersonsID
ORDER BY a.Balance DESC

-- shows Balance
SELECT p.FirstName + ' ' + p.LastName AS [Customer Name], dbo.ufn_calculateInterest(a.Balance, 0.02, 12) AS [Account Balance]
FROM Persons p
	JOIN Accounts a
		ON p.PersonsID = a.PersonsID
ORDER BY a.Balance DESC
