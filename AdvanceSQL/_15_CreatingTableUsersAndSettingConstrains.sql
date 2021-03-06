CREATE TABLE Users (
  UserID INT IDENTITY,
  UserName NVARCHAR(50) NOT NULL,
  UserPassword VARBINARY(MAX) NOT NULL,
  FullName NVARCHAR(100) NOT NULL,  
  LastLoginDate DATETIME NOT NULL,
  CONSTRAINT PK_Persons PRIMARY KEY(UserID),
  CONSTRAINT UC_UserName UNIQUE (UserName),
  CONSTRAINT CHK_Password CHECK(LEN(UserPassword) > 5))
GO
