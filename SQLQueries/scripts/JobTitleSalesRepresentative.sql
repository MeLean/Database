SELECT e.FirstName + ' ' + e.LastName AS [Sales Representative], e.JobTitle AS [Job Title]
FROM Employees e
WHERE e.JobTitle = 'Sales Representative'
ORDER BY e.EmployeeID