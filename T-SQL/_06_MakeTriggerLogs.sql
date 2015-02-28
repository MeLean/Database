USE BANK
GO

TRUNCATE TABLE Logs
GO


CREATE TABLE Accounts
(
	LogID int IDENTITY,
	AccountID INT NOT NULL,
	OldSum MONEY NULL,
	NewSum MONEY NULL,
	CONSTRAINT PK_LogID PRIMARY KEY(LogID),
	CONSTRAINT FK_AccountID FOREIGN KEY (AccountID)
	REFERENCES Accounts(AccountsID)
)
GO

CREATE TRIGGER tr_LogsUpdate ON Accounts FOR UPDATE
AS
	INSERT INTO dbo.Logs (AccountId, NewSum, OldSum)
	SELECT d.AccountsID, i.Balance, d.Balance
	FROM INSERTED i
		JOIN DELETED d
			ON d.AccountsID = i.AccountsID
GO

UPDATE Accounts
SET Balance = 10000 
WHERE AccountsID = 1
GO

SELECT * FROM Logs

