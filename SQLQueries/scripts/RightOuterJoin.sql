SELECT e.FirstName + ' ' + e.LastName [Employee Name], m.FirstName + ' ' + m.LastName [Manager Name]
FROM Employees e
	RIGHT OUTER JOIN Employees m
		ON e.ManagerID = m.EmployeeID
