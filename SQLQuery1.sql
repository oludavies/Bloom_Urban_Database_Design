
-- Database Schema for Multi-Branch Retail Inventory Management System

CREATE DATABASE bloom_urban;

USE bloom_urban;
GO


-- Regional Management
DROP TABLE IF EXISTS Regions;

DELETE TABLE Regions;

CREATE TABLE Regions (
    region_id INT PRIMARY KEY,
    region_name VARCHAR(100) NOT NULL,
    region_manager_id INT,
    contact_phone VARCHAR(20),
    contact_email VARCHAR(100)
);
GO

INSERT INTO Regions (
		region_id, region_name, region_manager_id, contact_phone, contact_email
	)
VALUES (
		
	);
	GO

SELECT * FROM Regions;

EXEC sp_help Regions;


-- Branch Information
DROP TABLE IF EXISTS Branches;

DELETE TABLE Branches;

CREATE TABLE Branches (
    branch_id INT PRIMARY KEY,
    branch_name VARCHAR(150) NOT NULL,
    region_id INT NOT NULL,
    branch_address VARCHAR(255) NOT NULL,
    branch_type VARCHAR(30) CHECK(branch_type IN('Supermarket', 'Mall', 'Convenience Store')) NOT NULL,
    opening_date DATE,
    manager_id INT,
    contact_number VARCHAR(20),
    
    FOREIGN KEY (region_id) REFERENCES Regions(region_id)
);
GO

INSERT INTO Branches (
		branch_address, branch_name, region_id, branch_address, branch_type, opening_date, manager_id, contact_number
	)
VALUES (
		
	);
	GO

SELECT * FROM Branches;

EXEC sp_help Branches;


-- Employee Management

DROP TABLE IF EXISTS Employees;

DELETE TABLE Employees;

CREATE TABLE Employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    branch_id INT NOT NULL,
    position VARCHAR CHECK(position IN('Manager', 'Assistant Manager', 'Inventory Clerk', 'Sales Associate')) NOT NULL,
    hire_date DATE,
    contact_number VARCHAR(20),
    email VARCHAR(100),
    
    FOREIGN KEY (branch_id) REFERENCES Branches(branch_id)
);

INSERT INTO Employees (
		employee_id, first_name, last_name, branch_id, position, hire_date, contact_number, email
	)
VALUES (
		
	);
	GO

SELECT * FROM Employees;

EXEC sp_help Employees;

-- Supplier Management

DROP TABLE IF EXISTS Suppliers;

DELETE TABLE Suppliers;

CREATE TABLE Suppliers (
    supplier_id INT PRIMARY KEY,
    supplier_name VARCHAR(150) NOT NULL,
    contact_person VARCHAR(100),
    contact_number VARCHAR(20),
    email VARCHAR(100),
    supplier_address VARCHAR(255),
    tax_identification_number VARCHAR(50),
    payment_terms VARCHAR(100)
);

INSERT INTO Suppliers (
		supplier_id, supplier_id, contact_person, contact_number, email, supplier_address, tax_identification_number, payment_terms
	)
VALUES (
		
	);
	GO

SELECT * FROM Suppliers;

EXEC sp_help Suppliers;


-- Product Categories

DROP TABLE IF EXISTS Product_Categories;

DELETE TABLE Product_Categories;

CREATE TABLE Product_Categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL,
    category_description TEXT,
    parent_category_id INT,
    
    FOREIGN KEY (parent_category_id) REFERENCES Product_Categories(category_id)
);
GO

INSERT INTO Product_Categories (
		category_id, category_name, category_description, parent_category_id
	)
VALUES (
		
	);
	GO

SELECT * FROM Product_Categories;

EXEC sp_help Product_Categories;


-- Product Master

DROP TABLE IF EXISTS Products;

DELETE TABLE Products;

CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(200) NOT NULL,
    category_id INT NOT NULL,
    supplier_id INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    barcode VARCHAR(50) UNIQUE,
    reorder_level INT,
    max_stock_level INT,
    tax_rate DECIMAL(5,2),
    
    FOREIGN KEY (category_id) REFERENCES Product_Categories(category_id),
    FOREIGN KEY (supplier_id) REFERENCES Suppliers(supplier_id)
);
GO

INSERT INTO Products (
		product_id, category_id, supplier_id, unit_price, barcode, reorder_level, max_stock_level, tax_rate
	)
VALUES (
		
	);
	GO

SELECT * FROM Products;

EXEC sp_help Products;


-- Inventory Tracking

DROP TABLE IF EXISTS Inventory;

DELETE TABLE Inventory;

CREATE TABLE Inventory (
    inventory_id INT IDENTITY(1,1) PRIMARY KEY,
    branch_id INT NOT NULL,
    product_id INT NOT NULL,
    current_stock INT NOT NULL,
    last_updated DATETIME DEFAULT GETDATE(),
    
    FOREIGN KEY (branch_id) REFERENCES Branches(branch_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id),
    
    UNIQUE (branch_id, product_id)
);
GO

INSERT INTO Inventory(
		inventory_id, branch_id, product_id, current_stock, last_updated
	)
VALUES (
		
	);
GO

SELECT * FROM Inventory;

EXEC sp_help Inventory;


-- Purchase Orders

DROP TABLE IF EXISTS Purchase_Orders;

DELETE TABLE Purchase_Orders;

CREATE TABLE Purchase_Orders (
    purchase_order_id INT PRIMARY KEY,
    supplier_id INT NOT NULL,
    branch_id INT NOT NULL,
    order_date DATE NOT NULL,
    expected_delivery_date DATE,
    order_status VARCHAR(20) CHECK (order_status IN ('Pending', 'Partially Received', 'Fully Received', 'Cancelled')) NOT NULL,
    total_order_value DECIMAL(12,2),
    created_by INT,
    
    FOREIGN KEY (supplier_id) REFERENCES Suppliers(supplier_id),
    FOREIGN KEY (branch_id) REFERENCES Branches(branch_id),
    FOREIGN KEY (created_by) REFERENCES Employees(employee_id)
);
GO

INSERT INTO Purchase_Orders(
		purchase_order_id, branch_id, order_date, expected_delivery_date, order_status, total_order_value, created_by
	)
VALUES (
		
	);
GO

SELECT * FROM Purchase_Orders;

EXEC sp_help Prchase_Orders;



-- Purchase Order Details

DROP TABLE IF EXISTS Purchase_Order_Details;

DELETE TABLE Purchase_Order_Details;

CREATE TABLE Purchase_Order_Details (
    purchase_order_detail_id INT PRIMARY KEY,
    purchase_order_id INT NOT NULL,
    product_id INT NOT NULL,
    ordered_quantity INT NOT NULL,
    received_quantity INT DEFAULT 0,
    unit_price DECIMAL(10,2) NOT NULL,
    
    FOREIGN KEY (purchase_order_id) REFERENCES Purchase_Orders(purchase_order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);
GO

INSERT INTO Purchase_Order_Details(
		purchase_order_detail_id, purchase_order_id, product_id, ordered_quantity, received_quantity, unit_price
	)
VALUES (
		
	);
GO

SELECT * FROM Purchase_Order_Details;

EXEC sp_help Purchase_Order_Details;



-- Sales Transactions

DROP TABLE IF EXISTS Sales_Transactions;

DELETE TABLE Sales_Transactions;


CREATE TABLE Sales_Transactions (
    transaction_id INT PRIMARY KEY,
    branch_id INT NOT NULL,
    employee_id INT NOT NULL,
    transaction_date DATETIME DEFAULT GETDATE(),
    total_amount DECIMAL(12,2) NOT NULL,
    payment_method VARCHAR(15) CHECK(payment_method IN ('Cash', 'Credit Card', 'Debit Card', 'Mobile Payment')) NOT NULL,
    
    FOREIGN KEY (branch_id) REFERENCES Branches(branch_id),
    FOREIGN KEY (employee_id) REFERENCES Employees(employee_id)
);
GO

INSERT INTO Sales_Transactions(
		transaction_id, branch_id, employee_id, transaction_date, total_amount, payment_method
	)
VALUES (
		
	);
GO

SELECT * FROM Sales_Transactions;

EXEC sp_help Sales_Transactions;


-- Sales Transaction Details

DROP TABLE IF EXISTS Sales_Transaction_Details;

DELETE TABLE Sales_Transaction_Details;

CREATE TABLE Sales_Transaction_Details (
    sales_detail_id INT PRIMARY KEY,
    transaction_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity_sold INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    discount_percentage DECIMAL(5,2) DEFAULT 0,
    
    FOREIGN KEY (transaction_id) REFERENCES Sales_Transactions(transaction_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);
GO

INSERT INTO Sales_Transaction_Details(
		sales_detail_id, transaction_id, product_id, quantity_sold, unit_price, discount_percentage
	)
VALUES (
		
	);
GO

SELECT * FROM Sales_Transaction_Details;

EXEC sp_help Sales_Transaction_Details;


-- Audit Trail for Inventory Movements

DROP TABLE IF EXISTS Inventory_Movements;

DELETE TABLE Inventory_Movements;

CREATE TABLE Inventory_Movements (
    movement_id INT PRIMARY KEY,
    branch_id INT NOT NULL,
    product_id INT NOT NULL,
    movement_type VARCHAR(10) CHECK (movement_type IN('Purchase', 'Sale', 'Transfer', 'Adjustment')) NOT NULL,
    quantity_changed INT NOT NULL,
    movement_date DATETIME DEFAULT GETDATE(),
    reason TEXT,
    employee_id INT NOT NULL,
    
    FOREIGN KEY (branch_id) REFERENCES Branches(branch_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id),
    FOREIGN KEY (employee_id) REFERENCES Employees(employee_id)
);
GO

INSERT INTO Inventory_Movements(
		movement_id, branch_id, product_id, movement_type, quantity_changed, movement_date, reason, employee_id
	)
VALUES (
		
	);
GO

SELECT * FROM Inventory_Movements;

EXEC sp_help Inventory_Movements;


-- Additional Essential Tables

-- Customer Management

DROP TABLE IF EXISTS Customers;

DELETE TABLE Customers;

CREATE TABLE Customers (
    -- customer_id INT AUTO_INCREMENT PRIMARY KEY, --mySQL
	customer_id INT IDENTITY(1,1) PRIMARY KEY,
    full_name VARCHAR(150) NOT NULL,
    phone_number VARCHAR(20),
    email VARCHAR(100),
    registration_date DATETIME DEFAULT GETDATE(),
    loyalty_points INT DEFAULT 0
);
GO


INSERT INTO Customers(
		movement_id, branch_id, product_id, movement_type, quantity_changed, movement_date, reason, employee_id
	)
VALUES (
		
	);
GO

SELECT * FROM Customers;

EXEC sp_help Customers;


-- Warehouse Management

DROP TABLE IF EXISTS Warehouses;

DELETE TABLE Warehouses;

CREATE TABLE Warehouses (
   -- warehouse_id INT AUTO_INCREMENT PRIMARY KEY, --mySQL
   warehouse_id INT IDENTITY(1,1) PRIMARY KEY,
    warehouse_name VARCHAR(150) NOT NULL,
    branch_id INT NOT NULL,
    warehouse_location VARCHAR(255),
    storage_capacity DECIMAL(10,2),
    
    FOREIGN KEY (branch_id) REFERENCES Branches(branch_id)
);
GO

INSERT INTO Warehouses(
		warehouse_id, warehouse_name, branch_id, warehouse_location, storage_capacity
	)
VALUES (
		
	);
GO

SELECT * FROM Warehouses;

EXEC sp_help Warehouses;


-- Equipment and Asset Tracking

DROP TABLE IF EXISTS Assets;

DELETE TABLE Assets;

CREATE TABLE Assets (
    --asset_id INT AUTO_INCREMENT PRIMARY KEY, --mySQL
	asset_id INT IDENTITY(1,1) PRIMARY KEY,
    asset_name VARCHAR(150) NOT NULL,
    branch_id INT NOT NULL,
    purchase_date DATE,
    current_value DECIMAL(10,2),
    depreciation_rate DECIMAL(5,2),
    maintenance_schedule TEXT,
    
    FOREIGN KEY (branch_id) REFERENCES Branches(branch_id)
);
GO

INSERT INTO Assets(
		warehouse_id, warehouse_name, branch_id, warehouse_location, storage_capacity
	)
VALUES (
		
	);
GO

SELECT * FROM Assets;

EXEC sp_help Assets;


-- Returns and Refunds Management

DROP TABLE IF EXISTS Product_Returns;

DELETE TABLE Product_Returns;

CREATE TABLE Product_Returns (
    --return_id INT AUTO_INCREMENT PRIMARY KEY, --mySQL
    return_id INT IDENTITY(1,1) PRIMARY KEY,
	sales_transaction_id INT NOT NULL,
    product_id INT NOT NULL,
    return_date DATETIME DEFAULT GETDATE(),
    return_reason  VARCHAR(10) CHECK (return_reason IN ('Defective', 'Wrong Item', 'Customer Preference')) NOT NULL,
    refund_amount DECIMAL(10,2),
    refund_status VARCHAR(10) CHECK (refund_status IN('Pending', 'Processed', 'Rejected')) NOT NULL,
    
    FOREIGN KEY (sales_transaction_id) REFERENCES Sales_Transactions(transaction_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);
GO

INSERT INTO Product_Returns (
		return_id, sales_transaction_id, product_id, return_date, return_reason, refund_amount, refund_status
	)
VALUES (
		
	);
GO

SELECT * FROM Product_Returns;

EXEC sp_help Product_Returns;


-- Pricing and Discount Management

DROP TABLE IF EXISTS Price_Rules;

DELETE TABLE Price_Rules;

CREATE TABLE Price_Rules (
    --rule_id INT AUTO_INCREMENT PRIMARY KEY, --mySQL
    rule_id INT IDENTITY(1,1) PRIMARY KEY,
	rule_name VARCHAR(100) NOT NULL,
    product_id INT,
    category_id INT,
    discount_percentage DECIMAL(5,2),
    start_date DATE,
    end_date DATE,
    
    FOREIGN KEY (product_id) REFERENCES Products(product_id),
    FOREIGN KEY (category_id) REFERENCES Product_Categories(category_id)
);
GO

INSERT INTO Price_Rules (
		rule_id, rule_name, product_id, category_id, discount_percentage, start_date, end_date
	)
VALUES (
		
	);
GO

SELECT * FROM Price_Rules;

EXEC sp_help Price_Rules;



-- Stock Adjustments Table

DROP TABLE IF EXISTS StockAdjustments;

DELETE TABLE StockAdjustments;

CREATE TABLE StockAdjustments (
    adjustment_id INT IDENTITY(1,1) PRIMARY KEY,
    branch_id INT,
    product_id INT,
    adjustment_type VARCHAR(10) CHECK (adjustment_type IN ('ADD', 'REMOVE')) NOT NULL,
    adjustment_quantity INT,
    adjustment_date DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (branch_id) REFERENCES Branches(branch_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);
GO

INSERT INTO StockAdjustments (
		adjustment_id, branch_id, product_id, adjustment_type, adjustment_quantity, adjustment_date, 
	)
VALUES (
		
	);
GO

SELECT * FROM StockAdjustments;

EXEC sp_help StockAdjustments;


-- Admin Users Table

DROP TABLE IF EXISTS Admin_Users;

DELETE TABLE Admin_Users;

CREATE TABLE Admin_Users (
    admin_user_id INT IDENTITY(1,1) PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    user_role VARCHAR(20) CHECK (user_role IN ('Admin', 'Manager', 'Cashier', 'Data Analyst', 'Auditor', 'Accountant')) NOT NULL
);
GO

INSERT INTO Admin_Users (
		admin_user_id, username, password_hash, user_role
	)
VALUES (
		
	);
GO

SELECT * FROM Admin_Users;

EXEC sp_help Admin_Users;


-- Add Unique Constraints and Indexes
CREATE UNIQUE INDEX idx_product_barcode ON Products(barcode);
CREATE INDEX idx_inventory_stock ON Inventory(current_stock);
CREATE INDEX idx_sales_date ON Sales_Transactions(transaction_date);