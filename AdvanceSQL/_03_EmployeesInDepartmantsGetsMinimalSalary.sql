SELECT e.FirstName + ' ' + e.LastName AS Name, e.Salary AS [Minimal Salary], d.Name
FROM Employees e
JOIN Departments d
	ON e.DepartmentID = d. DepartmentID
WHERE e.Salary = 
		(SELECT MIN(Salary) 
			FROM Employees
			WHERE DepartmentID = e.DepartmentID)
	AND e.DepartmentID = d.DepartmentID
ORDER BY e.Salary DESC
