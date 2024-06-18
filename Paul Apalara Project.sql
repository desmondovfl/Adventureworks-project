--MYSQL PORTFOLIO PROJECT
-----Adventureworks

---Question 1 Retrieve the names of employees who have not been assigned to any department.
SELECT FirstName, LastName
FROM Person.Person e
LEFT JOIN HumanResources.EmployeeDepartmentHistory edh ON e.BusinessEntityID = edh.BusinessEntityID
WHERE edh.DepartmentID IS NULL;

----Question 2 List the names of products that have been reviewed by customers.
SELECT DISTINCT p.Name
FROM Production.Product p
JOIN Production.ProductReview pr ON p.ProductID = pr.ProductID;

-----Question 3 Find the average review rating for each product.

SELECT ProductID, AVG(Rating) AS AverageRating
FROM Production.ProductReview
GROUP BY ProductID;

----Question 4 Retrieve the names of the top 3 employees with the highest sales.

SELECT TOP 3 e.FirstName, e.LastName, SUM(soh.TotalDue) AS TotalSales
FROM Sales.SalesOrderHeader soh
JOIN Sales.SalesPerson sp ON soh.SalesPersonID = sp.BusinessEntityID
JOIN Person.Person e ON sp.BusinessEntityID = e.BusinessEntityID
GROUP BY e.FirstName, e.LastName
ORDER BY TotalSales DESC;

-----Question 5 Get the total sales amount for each year.

SELECT YEAR(OrderDate) AS Year, SUM(TotalDue) AS TotalSales
FROM Sales.SalesOrderHeader
GROUP BY YEAR(OrderDate);

------Question 6 List the product names and their color, sorted by color.

SELECT Name, Color
FROM Production.Product
ORDER BY Color;

------Question 7 Find the sales orders that have more than 7 items.

SELECT SalesOrderID
FROM Sales.SalesOrderDetail
GROUP BY SalesOrderID
HAVING COUNT(*) > 7;

------Question 8 Retrieve the contact details of customers whose email addresses end with 'adventure-works.com'.

SELECT FirstName, LastName, EmailAddress
FROM Person.Person p
JOIN Person.EmailAddress e ON p.BusinessEntityID = e.BusinessEntityID
WHERE e.EmailAddress LIKE '%@adventure-works.com';

----Question 9 Retrieve the names of all departments and the number of employees in each department.

SELECT d.Name AS DepartmentName, COUNT(e.BusinessEntityID) AS NumberOfEmployees
FROM HumanResources.Department d
LEFT JOIN HumanResources.EmployeeDepartmentHistory edh ON d.DepartmentID = edh.DepartmentID
LEFT JOIN HumanResources.Employee e ON edh.BusinessEntityID = e.BusinessEntityID
GROUP BY d.Name;

---Question 10 Get the details of the sales orders that include a specific product

SELECT soh.SalesOrderID, soh.OrderDate, sod.ProductID, sod.OrderQty, sod.UnitPrice
FROM Sales.SalesOrderHeader soh
JOIN Sales.SalesOrderDetail sod ON soh.SalesOrderID = sod.SalesOrderID
WHERE sod.ProductID = 707;

-----Question 11 To find the product names and their associated categories.

SELECT p.Name AS ProductName, pc.Name AS CategoryName
FROM Production.Product p
JOIN Production.ProductSubcategory ps ON p.ProductSubcategoryID = ps.ProductSubcategoryID
JOIN Production.ProductCategory pc ON ps.ProductCategoryID = pc.ProductCategoryID;

----Question 12 To get the names and the modified dates of products that were modified in the last year.

SELECT Name, ModifiedDate
FROM Production.Product
WHERE ModifiedDate >= DATEADD(YEAR, -1, GETDATE());

----Question 13  List the names and email addresses of customers who placed orders in 2014.

SELECT DISTINCT p.FirstName, p.LastName, e.EmailAddress
FROM Sales.SalesOrderHeader soh
JOIN Person.Person p ON soh.CustomerID = p.BusinessEntityID
JOIN Person.EmailAddress e ON p.BusinessEntityID = e.BusinessEntityID
WHERE YEAR(soh.OrderDate) = 2014;

----Question 14 To Find the total number of employees.

Select COUNT(*) AS TotalEmployees 
FROM HumanResources.Employee;

-----Question 15 Find the total quantity of each product ordered.

SELECT ProductID, SUM(OrderQty) AS TotalQuantity
FROM Sales.SalesOrderDetail
GROUP BY ProductID;
