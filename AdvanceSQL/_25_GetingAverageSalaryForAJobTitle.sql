SELECT d.Name AS [Department Name], e.JobTitle AS [Job Title], AVG(e.Salary) AS [Average Salary]
FROM Departments d
JOIN Employees e
	ON d.DepartmentID = e.DepartmentID
GROUP BY d.Name, e.JobTitle
ORDER BY AVG(e.Salary) DESC