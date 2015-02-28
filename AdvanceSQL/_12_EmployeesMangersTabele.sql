SELECT e.FirstName + ' ' + e.LastName AS [Employee Name], 
	ISNULL(m.FirstName + ' ' + m.LastName, 'no manager') AS [Manager Name] 
FROM Employees e
LEFT OUTER JOIN  Employees m
	ON e.ManagerID = m.EmployeeID
ORDER BY m.FirstName
