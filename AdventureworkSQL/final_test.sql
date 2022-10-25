-- 1.1(1đ): Sử dụng dữ liệu từ bảng Purchasing.PurchaseOrderDetail xuất dữ liệu số lượng sản phẩm bị từ chối nhận hàng
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

--1.2 tổng số lượng đơn hàng, tổng số sản phẩm giao thành công, tổng giá trị mua theo ID nhân viên, sau đó sắp xếp theo 
-- thứ tự giảm dần theo tổng giá trị mua(1đ). Tạo cột ranking thể hiện rank theo id nhân viên theo tổng giá trị mua giảm dần
-- (tổng giá trị mua cao nhất rank là 1, cao thứ 2 rank là 2…) (1đ).

SELECT EmployeeID,
       COUNT(DISTINCT PurchaseOrderDetailID) AS num_order,
       SUM(ReceivedQty) AS sum_received_product,
       SUM(d.LineTotal) AS sum_sold,
RANK() OVER(ORDER BY SUM(d.LineTotal) DESC) AS rank_

FROM Purchasing.PurchaseOrderDetail d
RIGHT JOIN Purchasing.PurchaseOrderHeader h
ON d.PurchaseOrderID = h.PurchaseOrderID 
GROUP BY EmployeeID

--1.3(1đ): Dựa vào bảng HumanResources.EmployeeDepartmentHistory xuất ra danh sách những nhân viên từng chuyển bộ phận hoặc nghỉ việc.
SELECT *
FROM HumanResources.EmployeeDepartmentHistory
WHERE BusinessEntityID IN (
    SELECT BusinessEntityID
    FROM HumanResources.EmployeeDepartmentHistory
    GROUP BY BusinessEntityID
    HAVING COUNT(*) > 1
) 
