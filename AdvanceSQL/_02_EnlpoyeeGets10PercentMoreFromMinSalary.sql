SELECT e.FirstName, e.LastName, e.Salary
FROM Employees e
WHERE e.Salary <= 
	(SELECT MIN(Salary) FROM Employees) * 1.1 
ORDER BY e.Salary DESC