-- Step 1: Create a temporary ProductDetail table
CREATE TEMPORARY TABLE ProductDetail (
    OrderID INT,
    CustomerName VARCHAR(100),
    Products VARCHAR(255)
);

-- Step 2: Insert sample data
INSERT INTO ProductDetail VALUES 
(101, 'John Doe', 'Laptop, Mouse'),
(102, 'Jane Smith', 'Tablet, Keyboard, Mouse'),
(103, 'Emily Clark', 'Phone');

-- Step 3: Split the Products column into separate rows using JSON_TABLE
SELECT 
    OrderID,
    CustomerName,
    TRIM(product) AS Product
FROM (
    SELECT 
        OrderID,
        CustomerName,
        -- Replace commas with '","' to convert into JSON array format
        CONCAT('["', REPLACE(Products, ',', '","'), '"]') AS ProductJSON
    FROM ProductDetail
) AS temp
JOIN JSON_TABLE(
    temp.ProductJSON,
    '$[*]' COLUMNS (product VARCHAR(100) PATH '$')
) AS jt;





--2
CREATE TEMPORARY TABLE Orders AS
SELECT DISTINCT
    OrderID,
    CustomerName
FROM OrderDetails;

CREATE TEMPORARY TABLE OrderItems AS
SELECT
    OrderID,
    Product,
    Quantity
FROM OrderDetails;
