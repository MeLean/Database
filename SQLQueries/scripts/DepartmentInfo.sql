SELECT d.DepartmentID, d.Name as [Department Name], e.FirstName + ' ' + e.LastName as  [Manager]
FROM Departments d, Employees e
WHERE d.ManagerID = e.ManagerID
ORDER BY d.DepartmentID 