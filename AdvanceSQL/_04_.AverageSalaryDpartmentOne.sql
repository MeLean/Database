SELECT d.DepartmentID AS [Department ID], 
	d.Name AS [Department Name], 
	AVG(e.Salary) AS [Average Salary]
FROM Employees e
JOIN Departments d
	ON e.DepartmentID = d.DepartmentID
WHERE e.DepartmentID = 1
GROUP BY d.Name, d.DepartmentID
ORDER BY d.DepartmentID
