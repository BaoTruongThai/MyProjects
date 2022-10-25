
SELECT a.BusinessEntityID Employee_id,
       CONCAT(d.Title, ' ',d.FirstName,' ',d.LastName) Employee_name,
       BirthDate,
       c.Name Department,
       a.JobTitle,
       b.EndDate
FROM HumanResources.Employee a
INNER JOIN HumanResources.EmployeeDepartmentHistory b ON a.BusinessEntityID = b.BusinessEntityID
INNER JOIN HumanResources.Department c ON b.DepartmentID = c.DepartmentID
INNER JOIN Person.Person d ON d.BusinessEntityID = a.BusinessEntityID
WHERE ISNULL(b.EndDate, '2099-12-31') > CURRENT_TIMESTAMP;

--Write query to count number of employees in each department
SELECT sub.Department, COUNT(Employee_id) num_employees
FROM (
    SELECT a.BusinessEntityID Employee_id,
       CONCAT(d.Title, ' ',d.FirstName,' ',d.LastName) Employee_name,
       BirthDate,
       c.Name Department,
       a.JobTitle,
       b.EndDate
    FROM HumanResources.Employee a
    INNER JOIN HumanResources.EmployeeDepartmentHistory b ON a.BusinessEntityID = b.BusinessEntityID
    INNER JOIN HumanResources.Department c ON b.DepartmentID = c.DepartmentID
    INNER JOIN Person.Person d ON d.BusinessEntityID = a.BusinessEntityID
    WHERE ISNULL(b.EndDate, '2099-12-31') > CURRENT_TIMESTAMP
) AS sub
GROUP BY sub.Department
ORDER BY num_employees;

--Write query to count number of employees in each jobtitle
WITH sub AS
    (SELECT a.BusinessEntityID Employee_id,
       CONCAT(d.Title, ' ',d.FirstName,' ',d.LastName) Employee_name,
       BirthDate,
       c.Name Department,
       a.JobTitle,
       b.EndDate
    FROM HumanResources.Employee a
    INNER JOIN HumanResources.EmployeeDepartmentHistory b ON a.BusinessEntityID = b.BusinessEntityID
    INNER JOIN HumanResources.Department c ON b.DepartmentID = c.DepartmentID
    INNER JOIN Person.Person d ON d.BusinessEntityID = a.BusinessEntityID
    WHERE ISNULL(b.EndDate, '2099-12-31') > CURRENT_TIMESTAMP)

SELECT JobTitle, COUNT(Employee_id) num_employees
FROM sub
GROUP BY JobTitle
ORDER BY num_employees;

--Write query to count number of employees in the company

WITH sub AS
    (SELECT a.BusinessEntityID Employee_id,
       CONCAT(d.Title, ' ',d.FirstName,' ',d.LastName) Employee_name,
       BirthDate,
       c.Name Department,
       a.JobTitle,
       b.EndDate
    FROM HumanResources.Employee a
    INNER JOIN HumanResources.EmployeeDepartmentHistory b ON a.BusinessEntityID = b.BusinessEntityID
    INNER JOIN HumanResources.Department c ON b.DepartmentID = c.DepartmentID
    INNER JOIN Person.Person d ON d.BusinessEntityID = a.BusinessEntityID
    WHERE ISNULL(b.EndDate, '2099-12-31') > CURRENT_TIMESTAMP)

SELECT COUNT(Employee_id) num_employees
FROM sub;

--Write query to find all employees have birthday in September
SELECT *
FROM (SELECT a.BusinessEntityID Employee_id,
       CONCAT(d.Title, ' ',d.FirstName,' ',d.LastName) Employee_name,
       BirthDate,
       c.Name Department,
       a.JobTitle,
       b.EndDate
    FROM HumanResources.Employee a
    INNER JOIN HumanResources.EmployeeDepartmentHistory b ON a.BusinessEntityID = b.BusinessEntityID
    INNER JOIN HumanResources.Department c ON b.DepartmentID = c.DepartmentID
    INNER JOIN Person.Person d ON d.BusinessEntityID = a.BusinessEntityID
    WHERE ISNULL(b.EndDate, '2099-12-31') > CURRENT_TIMESTAMP) AS sub
WHERE DATEPART(MONTH,sub.BirthDate) = 09

--Write query to find all employees have keyword “manager” in their job title
WITH sub AS
    (SELECT a.BusinessEntityID Employee_id,
       CONCAT(d.Title, ' ',d.FirstName,' ',d.LastName) Employee_name,
       BirthDate,
       c.Name Department,
       a.JobTitle,
       b.EndDate
    FROM HumanResources.Employee a
    INNER JOIN HumanResources.EmployeeDepartmentHistory b ON a.BusinessEntityID = b.BusinessEntityID
    INNER JOIN HumanResources.Department c ON b.DepartmentID = c.DepartmentID
    INNER JOIN Person.Person d ON d.BusinessEntityID = a.BusinessEntityID
    WHERE ISNULL(b.EndDate, '2099-12-31') > CURRENT_TIMESTAMP)

SELECT *
FROM sub
WHERE sub.JobTitle LIKE '%manager%';