SELECT d.Name AS [Department Name], 
MIN(e.FirstName) AS [Employee First Name],
e.JobTitle AS [Job Title],
MIN(e.Salary) AS [Minimal Salary]

FROM Departments d
JOIN Employees e
	ON d.DepartmentID = e.DepartmentID
GROUP BY d.Name, e.JobTitle
ORDER BY d.Name