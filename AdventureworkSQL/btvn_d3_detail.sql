--Write the query to find customer that not have any Sales order using exist
SELECT CustomerID
FROM Sales.Customer c
WHERE NOT EXISTS (
    SELECT 1
    FROM Sales.SalesOrderHeader h
    WHERE c.CustomerID = h.CustomerID
);
--C2:
SELECT c.CustomerID, h.SalesOrderID
FROM Sales.Customer c
LEFT JOIN Sales.SalesOrderHeader h
ON c.CustomerID = h.CustomerID
WHERE h.SalesOrderID IS NULL;

--C3:
SELECT CustomerID
FROM Sales.Customer
WHERE CustomerID NOT IN (
    SELECT CustomerID
    FROM Sales.SalesOrderHeader
);
--Write the query to find customer that have at least 10 Sales order using exist
SELECT c.CustomerID
FROM Sales.Customer c
WHERE EXISTS (
    SELECT h.CustomerID
    FROM Sales.SalesOrderHeader h
    WHERE c.CustomerID = h.CustomerID
    GROUP BY h.CustomerID
    HAVING COUNT(DISTINCT SalesOrderID) >= 10
);
--C2:
SELECT h.CustomerID
FROM Sales.Customer c
INNER JOIN Sales.SalesOrderHeader h
ON c.CustomerID = h.CustomerID
GROUP BY h.CustomerID
HAVING COUNT(DISTINCT SalesOrderID) >= 10;

--Write query to extract all sales order have customer in territory (TerritoryID) 1,4,5  and sort by SalesOrderID asc 
SELECT [SalesOrderID],
       [OrderDate],
       [SalesOrderNumber],
       [TotalDue]
FROM Sales.SalesOrderHeader
WHERE TerritoryID IN (1,4,5)
ORDER BY SalesOrderID;

=> chưa có phần sort by Salesorderid. Bạn thử viết thêm sử dụng kiến thức subquery nhé.
--C2:
SELECT [SalesOrderID],
       [OrderDate],
       [SalesOrderNumber],
       [TotalDue]
FROM Sales.SalesOrderHeader
WHERE TerritoryID IN (
    SELECT TerritoryID
    FROM Sales.SalesOrderHeader
    WHERE TerritoryID IN (1,4,5)
)
ORDER BY SalesOrderID
--C3:
SELECT *
FROM (
    SELECT [SalesOrderID],
           [OrderDate],
           [SalesOrderNumber],
           [TotalDue]
    FROM Sales.SalesOrderHeader
    WHERE TerritoryID IN (1,4,5)    
) AS s
ORDER BY SalesOrderID;

--C4:
SELECT [SalesOrderID],
       [OrderDate],
       [SalesOrderNumber],
       [TotalDue]
FROM Sales.SalesOrderHeader a
WHERE EXISTS (
    SELECT 1
    FROM Sales.SalesOrderHeader b
    WHERE a.SalesOrderID = b.SalesOrderID
    AND TerritoryID IN (1,4,5)
)
ORDER BY SalesOrderID;


--Write query to find top 5 customers have total purchase in period ‘2011-07-01’ to ‘2011-07-31’
SELECT TOP 5 CustomerID, SUM(TotalDue) total_buy
FROM Sales.SalesOrderHeader
WHERE OrderDate BETWEEN '2011-07-01' AND '2011-07-31'
GROUP BY CustomerID
ORDER BY total_buy DESC;
--C2:
SELECT TOP 5 CustomerID, SUM(TotalDue) total_buy
FROM Sales.SalesOrderHeader a
WHERE EXISTS (
    SELECT 1
    FROM Sales.SalesOrderHeader b
    WHERE a.SalesOrderID = b.SalesOrderID
    AND OrderDate BETWEEN '2011-07-01' AND '2011-07-31'
)
GROUP BY CustomerID
ORDER BY total_buy DESC

--C3:
SELECT TOP 5 CustomerID, SUM(TotalDue) total_buy
FROM Sales.SalesOrderHeader a
WHERE EXISTS (
    SELECT 1
    FROM Sales.SalesOrderHeader b
    WHERE OrderDate IN (
        SELECT OrderDate
        FROM Sales.SalesOrderHeader
        WHERE OrderDate BETWEEN '2011-07-01' AND '2011-07-31'
    )
    AND a.SalesOrderID = b.SalesOrderID
)
GROUP BY CustomerID
ORDER BY total_buy DESC
--Explain the purpose of below query
select *
from Sales.Customer a
where exists 
(select 1
from sales.SalesOrderHeader b
where TotalDue < (
    select avg(TotalDue)
    from Sales.SalesOrderHeader c
    where c.OrderDate = cast('2011-06-01' as date))
and a.CustomerID = b.CustomerID 
and b.OrderDate between '2011-06-01' and '2011-06-15');

Explain: The query extracts all the customers' information 
from the Customer table whose orders from 2011-06-01 to 2011-06-15 
have the TotalDue < the average TotalDue of all orders in 2011-06-01  