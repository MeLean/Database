SELECT e.FirstName + ' ' + e.LastName AS [Name], e.HireDate	AS [Date of Hire]
FROM Employees e
	JOIN Departments d
		ON e.DepartmentID = d.DepartmentID AND d.Name = 'Sales' OR d.Name = 'Finance'
WHERE e.HireDate BETWEEN '1995/01/01' AND '2005/12/31'
ORDER BY e.HireDate