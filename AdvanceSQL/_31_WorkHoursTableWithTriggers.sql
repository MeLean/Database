CREATE TABLE WorkHoursLogs
(
Id int PRIMARY KEY IDENTITY NOT NULL,
Message nvarchar(150) NOT NULL,
DateOfChange datetime NOT NULL
)
GO
CREATE TRIGGER tr_WorkHoursInsert
ON WorkHours
FOR INSERT
AS
INSERT INTO WorkHoursLogs (Message, DateOfChange)
VALUES('Added row', GETDATE ( ))
GO
CREATE TRIGGER tr_WorkHoursDelete
ON WorkHours
FOR DELETE
AS
INSERT INTO WorkHoursLogs (Message, DateOfChange)
VALUES('Deleted row', GETDATE ( ))
GO
CREATE TRIGGER tr_WorkHoursUpdate
ON WorkHours
FOR UPDATE
AS
INSERT INTO WorkHoursLogs (Message, DateOfChange)
VALUES('Update row', GETDATE ( ))
GO
INSERT INTO WorkHours (EmployeeId, Date, Task, Hours)
VALUES(10, GETDATE ( ), 'Bla-Bla', 10)
INSERT INTO WorkHours (EmployeeId, Date, Task, Hours)
VALUES(11, GETDATE ( ), 'Bla-Bla-2', 100)
DELETE WorkHours
WHERE EmployeeId = 10
UPDATE WorkHours
SET Task = 'Bla-Bla Ura-a-a'
WHERE EmployeeId = 11
SELECT * FROM WorkHoursLogs
