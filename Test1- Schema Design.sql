DROP DATABASE IF EXISTS Shopping_Management;
CREATE DATABASE Shopping_Management;
USE Shopping_Management;

CREATE TABLE customers (
    Customer_Id INT AUTO_INCREMENT PRIMARY KEY,
    Customer_Name VARCHAR(100) NOT NULL,
    Email VARCHAR(254) UNIQUE,
    Phone_Number CHAR(10) NOT NULL UNIQUE,
    Age TINYINT UNSIGNED,
    Gender ENUM('Male', 'Female', 'Other'),
    Country VARCHAR(50) DEFAULT 'India',
    City VARCHAR(50) NOT NULL,
    Pincode CHAR(6) DEFAULT '152123',
    Registration_Date DATE DEFAULT (CURRENT_DATE),
    Registration_Time TIME DEFAULT (CURRENT_TIME),
    Created_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Address VARCHAR(250),
    Customer_Status ENUM('Active', 'Inactive', 'Blocked') DEFAULT 'Active',
    Customer_Notes VARCHAR(999),
    CHECK (Phone_Number REGEXP '^[0-9]{10}$'),
    CHECK (Age IS NULL OR Age > 0),
    CHECK (Pincode REGEXP '^[0-9]{6}$')
) ENGINE=InnoDB;

CREATE TABLE orders (
    Order_Id INT AUTO_INCREMENT PRIMARY KEY,
    Customer_Id INT NOT NULL,
    Order_Date DATE DEFAULT (CURRENT_DATE),
    Order_Amount DECIMAL(10,2) NOT NULL,
    Order_Status ENUM('Pending', 'Processing', 'Shipped', 'Delivered', 'Cancelled')
        DEFAULT 'Pending',
    Payment_Method ENUM('Cash', 'Card', 'UPI', 'Net Banking'),
    Payment_Status ENUM('Pending', 'Paid', 'Failed') DEFAULT 'Pending',
    Shipping_Address VARCHAR(250) NOT NULL,
    Delivery_Pincode CHAR(6),
    Quantity INT NOT NULL,
    Discount_Amount DECIMAL(10,2) DEFAULT 0.00,
    Delivery_Date DATE NULL,
    Created_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Tracking_Number VARCHAR(30) UNIQUE,
    Delivery_Status ENUM('Not Dispatched', 'In Transit', 'Delivered', 'Returned')
        DEFAULT 'Not Dispatched',
    Order_Notes VARCHAR(999),
    CHECK (Delivery_Pincode IS NULL OR Delivery_Pincode REGEXP '^[0-9]{6}$'),
    CHECK (Quantity > 0),
    CHECK (Order_Amount >= 0),
    CHECK (Discount_Amount >= 0),
    CONSTRAINT fk_orders_customers
        FOREIGN KEY (Customer_Id)
        REFERENCES customers(Customer_Id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB;
DESCRIBE customers;
DESCRIBE orders;
SHOW CREATE TABLE orders;
USE Shopping_Management;

DESCRIBE customers;
DESCRIBE orders;
SHOW CREATE TABLE orders;
INSERT INTO customers
    (Customer_Name, Email, Phone_Number, City)
VALUES
    ('Gourav', 'gourav@example.com', '9999999999', 'Fazilka');

INSERT INTO orders
    (Customer_Id, Order_Amount, Shipping_Address, Quantity)
VALUES
    (LAST_INSERT_ID(), 1500.50, 'Punjab, Fazilka', 2);

SELECT * FROM customers;
SELECT * FROM orders;
USE Shopping_Management;

SHOW CREATE TABLE customers;
SHOW CREATE TABLE orders;
INSERT INTO customers
    (Customer_Name, Phone_Number, City)
VALUES
    ('Test Cascade', '8360345360', 'Fazilka');

SET @new_customer_id = LAST_INSERT_ID();

INSERT INTO orders
    (Customer_Id, Order_Amount, Shipping_Address, Quantity)
VALUES
    (@new_customer_id, 500.00, 'Delhi', 2);

SELECT * FROM customers WHERE Customer_Id = @new_customer_id;
SELECT * FROM orders WHERE Customer_Id = @new_customer_id;
-- DROP DATABASE IF EXISTS Shopping_Management;
