CREATE DATABASE `db_capstone_project` /*!40100 DEFAULT CHARACTER SET utf8mb3 */ /*!80016 DEFAULT ENCRYPTION='N' */;
SELECT 
customers.CustomerID AS customer_ID,
customers.FullName AS FullName,
orders.OrderID AS OrderID,
orders.TotalCost AS Cost,
menus.MenuID AS MenuID,
menuitems.CourseName AS CourseName,
menuitems.DesertName AS DesertName
FROM customers
JOIN orders ON customers.CustomerID = orders.CustomerID
JOIN menus ON menus.MenuID = orders.MenuID
JOIN menuitems ON menuitems.MenuItemsID = menus.MenuItemsID
WHERE TotalCost > 150
ORDER BY TotalCost;

SELECT 
MenuName
FROM menus
WHERE MenuID = ANY (SELECT MenuID FROM orders WHERE Quantity > 2);

CREATE PROCEDURE GetMaxQuantity()  
SELECT MAX(Quantity) AS 'Max Quantity in Order'
FROM orders;

CREATE PROCEDURE GetOrderDetail(id INT)
SELECT OrderID, Quantity, TotalCost
FROM orders
WHERE CustomerID = id;

CALL GetOrderDetail(1)

DELIMITER //

CREATE PROCEDURE CancelOrder1(id INT)
BEGIN
    DELETE FROM orders WHERE OrderID = id;
    SELECT CONCAT ('Order', id, 'has been canceled.') AS Confirmation;
END //

DELIMITER ;

CALL CancelOrder1(10);

