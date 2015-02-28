UPDATE Groups
SET Name='Lazy'
WHERE Name='Lazy People'

UPDATE Groups
SET Name='Lazy People'
WHERE Name='Lazy'

UPDATE Users
SET LastLoginDate = GETDATE()
WHERE UserName='Kakata' OR  UserName='KakaMenda'