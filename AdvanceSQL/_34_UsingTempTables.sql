SELECT * INTO #TempTable
FROM EmployeesProjects
GO
 
 DROP TABLE EmployeesProjects;
GO

 CREATE TABLE EmployeesProjects (
   EmployeeID INT FOREIGN KEY REFERENCES Employees(EmployeeID) NOT NULL,
   ProjectID INT FOREIGN KEY REFERENCES Projects(ProjectID) NOT NULL)
GO

 INSERT INTO EmployeesProjects
 SELECT * FROM  #TempTable
 GO
 
 DROP TABLE #TempTable
 GO
 
