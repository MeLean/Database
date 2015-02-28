INSERT INTO WorkHours 
VALUES (GETDATE(), 'Programming SQL Data', 8, 'NOT SO WELL', 1),
	(GETDATE(), 'Do Nothing', 4,NULL, 22),
	(GETDATE(), 'Bug handling', 8, 'Bug #13, Bug #123', 12)
GO

DELETE FROM WorkHours
WHERE WorkedHours < 8
GO

UPDATE WorkHours
SET Comments ='Bugs: #13 and #123'
WHERE Task = 'Bug handling'