DROP PROC usp_WithdrawMOney
GO
CREATE PROC usp_WithdrawMOney(@PersonID INT, @amount MONEY)
AS
	IF @amount > 0
	BEGIN
		BEGIN TRAN
			UPDATE Accounts 
			SET Balance = (Balance - @amount)
			WHERE PersonsID = @PersonID
		
			DECLARE @balance INT;
			SET @balance = (SELECT Balance FROM Accounts
									WHERE AccountsID = @PersonID)

		IF @balance > 0
			BEGIN
				COMMIT TRAN
				PRINT 'Withdraw successful! Account balance: ' 
					+ CONVERT(NVARCHAR(10), @balance)
			END
		ELSE
			BEGIN
				RAISERROR('Not enough money to withdraw!', 16, 1)
				ROLLBACK TRAN
			END
	END
	ELSE
		BEGIN
			RAISERROR('Can not withdraw neagtive values!', 16, 1)
		END
GO

DROP PROC usp_DepositMoney
GO
CREATE PROC usp_DepositMoney(@PersonID INT, @amount MONEY)
AS
	IF @amount > 0
		BEGIN
			UPDATE Accounts 
			SET Balance = (Balance + @amount)
			WHERE PersonsID = @PersonID

			DECLARE @balance INT;
			SET @balance = (SELECT Balance FROM Accounts
									WHERE AccountsID = @PersonID)

			PRINT 'Deposit successful! Account balance: ' 
				+ CONVERT(NVARCHAR(10), @balance)
		END
	ELSE
		BEGIN
			RAISERROR('Can not deposit neagtive values!', 16, 1)
		END
GO
	
EXEC usp_DepositMoney 1, 100
EXEC usp_DepositMoney 1, -100

EXEC usp_WithdrawMOney 1, 100
EXEC usp_WithdrawMOney 1, 1000000000
EXEC usp_WithdrawMOney 1, -90