SELECT d.Name AS [Department name], AVG(e.Salary) AS [Avarage salary]
FROM Employees e
JOIN Departments d
	ON e.DepartmentID = d.DepartmentID
WHERE d.Name = 'Sales'
GROUP BY d.Name