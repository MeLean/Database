INSERT INTO Groups
SELECT 'Cheaters'
UNION
SELECT 'Quarrelsome'


INSERT INTO Users(UserName, UserPassword, FullName, LastLoginDate, GroupID)
SELECT 'Antoncho', 122345, 'Anton Strahilov', GETDATE(), 18
UNION
SELECT 'Dancho', 122334, 'Daniel Strahilov', GETDATE(), 19
UNION
SELECT 'Kakata', 123467, 'Kaka Stoqnova', GETDATE(), 19