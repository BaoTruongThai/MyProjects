--1 Details of Rejected Orders
SELECT PurchaseOrderID,
       PurchaseOrderDetailID,
       DueDate,
       OrderQty,
       ProductID,
       UnitPrice,
       LineTotal,
       ReceivedQty,
       RejectedQty,
       ModifiedDate
FROM Purchasing.PurchaseOrderDetail
WHERE RejectedQty > 0

--2 Rank Employees have the highest sales
SELECT EmployeeID,
       COUNT(DISTINCT PurchaseOrderDetailID) AS num_order,
       SUM(ReceivedQty) AS sum_received_product,
       SUM(d.LineTotal) AS sum_sold,
RANK() OVER(ORDER BY SUM(d.LineTotal) DESC) AS rank_

FROM Purchasing.PurchaseOrderDetail d
RIGHT JOIN Purchasing.PurchaseOrderHeader h
ON d.PurchaseOrderID = h.PurchaseOrderID 
GROUP BY EmployeeID

--3 Number of employees change departments or quit job
SELECT *
FROM HumanResources.EmployeeDepartmentHistory
WHERE BusinessEntityID IN (
    SELECT BusinessEntityID
    FROM HumanResources.EmployeeDepartmentHistory
    GROUP BY BusinessEntityID
    HAVING COUNT(*) > 1
) 
