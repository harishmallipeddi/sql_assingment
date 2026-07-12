SELECT * FROM d20r.employees;
SELECT * FROM Employees
WHERE Salary > 60000;
SELECT * FROM Employees
WHERE Department = 'IT';
SELECT * FROM Employees
WHERE Age < 30;
SELECT * FROM Employees
WHERE City = 'Hyderabad'
ORDER BY Salary ASC;
SELECT * FROM Employees
ORDER BY Salary DESC;
SELECT * FROM Employees
WHERE Salary BETWEEN 50000 AND 80000
ORDER BY Age;
SELECT * FROM Employees
WHERE Department = 'HR'
ORDER BY Name ASC;
SELECT * FROM Employees
WHERE JoiningDate > '2021-01-01'
ORDER BY JoiningDate DESC;
SELECT * FROM Employees
WHERE City IN ('Chennai', 'Bangalore')
ORDER BY City, Salary DESC;
SELECT * FROM Employees
WHERE Age > 25
ORDER BY Department ASC, Salary DESC;
