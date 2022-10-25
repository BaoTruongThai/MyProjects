--Write query to find 10 top product by sales(using window function)
SELECT d.ProductID, 
       p.Name,
       RANK() OVER(ORDER BY SUM(LineTotal) DESC) sales_rank, 
       SUM(LineTotal) total_sales
FROM Sales.SalesOrderDetail d
INNER JOIN Production.Product p 
ON d.ProductID = p.ProductID
GROUP BY d.ProductID, p.Name;

--With  query below, write query to rank category by sale
--cua thay
WITH cte AS (
select a.ProductID,a.Name, 
       a.ProductNumber, 
       b.ProductSubcategoryID,      
       c.ProductCategoryID
from production.Product a
    inner join Production.ProductSubcategory b on a.ProductModelID = b.ProductSubcategoryID 
    inner join Production.ProductCategory c on c.ProductCategoryID = b.ProductSubcategoryID),

product_sales as (
    select ProductID,sum(LineTotal) total_sales 
    from Sales.SalesOrderDetail 
    group by ProductID) 

SELECT d.ProductCategoryID,
       e.ProductID,
       RANK() OVER(PARTITION BY ProductCategoryID ORDER BY total_sales DESC) rank_category,
       e.total_sales
FROM cte d
INNER JOIN product_sales e
ON d.ProductID = e.ProductID


--C2
With cte as (
select a.ProductID,a.Name, a.ProductNumber, b.ProductSubcategoryID, c.ProductCategoryID
from production.Product a
    inner join Production.ProductSubcategory b on a.ProductModelID = b.ProductSubcategoryID
    inner join Production.ProductCategory c on c.ProductCategoryID = b.ProductSubcategoryID),
 product_sales as (select ProductID,sum(LineTotal) total_sales from Sales.SalesOrderDetail 
                    group by ProductID) 

select p.ProductCategoryID, rank() OVER(order by S.total_sales ASC) "sales_rank", S.total_sales from cte P 
inner join product_sales S on P.ProductID=S.ProductID 
group by P.ProductCategoryID, S. total_sales
;
--Write query to compare product sale with average sales using window function and group by
--USING Window function:
SELECT distinct ProductID,
       SUM(LineTotal) OVER(PARTITION BY ProductID ORDER BY ProductID) total_sales,
       AVG(LineTotal) OVER(PARTITION BY ProductID ORDER BY ProductID) avg_sales
FROM Sales.SalesOrderDetail
ORDER BY avg_sales

--USING GROUP BY
SELECT ProductID,
       SUM(LineTotal) total_sales,
       AVG(LineTotal)  avg_sales
FROM Sales.SalesOrderDetail
GROUP BY ProductID
ORDER BY ProductID


--Write query to find 10 sales person that have poor performance
SELECT SalesPersonID, 
       CONCAT(p.FirstName,' ', p.LastName) Employee_name,
       SUM(LineTotal) total_revenue,
       RANK () OVER(ORDER BY SUM(LineTotal) DESC) SALES_RANK
FROM Sales.SalesOrderHeader h
INNER JOIN Person.Person p 
    ON h.SalesPersonID = p.BusinessEntityID
INNER JOIN Sales.SalesOrderDetail d
    ON h.SalesOrderID = d.SalesOrderID
GROUP BY SalesPersonID, CONCAT(p.FirstName,' ', p.LastName)
ORDER BY SALES_RANK DESC


/*NOTE: +Câu 2 sao mình không join Production.Product (a) với Production.ProductSubcategory (b) using ProductSubcategoryID
mà phải dùng  a.ProductModelID = b.ProductSubcategoryID anh nhỉ? Với em chạy câu này có đúng yêu cầu không anh, có gì anh
giải thích đề rồi em viết lại sau ạ.
 + Câu 4 em join mấy bảng trên mà hình như thiếu thông tin nào mà cái total_revenue của em nó khác quá :) */

 select distinct ProductID,
        SUM(LineTotal) OVER (partition by productID) "total_sales", AVG(LineTotal) OVER (partition by productID) "avg_sales"
from Sales.SalesOrderDetail 
 