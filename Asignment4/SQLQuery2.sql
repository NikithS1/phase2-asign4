-- Create the database
CREATE DATABASE Assesment04Db;
USE Assesment04Db;

-- Create the Products table
CREATE TABLE Products (
    Pld INT PRIMARY KEY IDENTITY(500, 1),
    PName VARCHAR(100) NOT NULL,
    PPrice DECIMAL(10, 2),
    PTax DECIMAL(10, 2),
    PCompany VARCHAR(100),
    PQty INT DEFAULT (10),
    PPricewithTax AS (PPrice + (PPrice * PTax / 100)),
    TotalPrice AS (PQty * PPricewithTax)
);

-- Insert records into the Products table
INSERT INTO Products (PName, PPrice, PTax, PCompany) VALUES
('Samsung', 500.00, 10.00, 'Apple'),
('Redmi', 300.00, 5.00, 'Xiaomi'),
('HTC', 450.00, 8.00, 'HTC'),
('Apple', 800.00, 15.00, 'Apple'),
('Xiaomi', 350.00, 6.00, 'Xiaomi'),
('Samsung', 550.00, 10.00, 'Samsung'),
('RealMe', 400.00, 7.00, 'RealMe'),
('Redmi', 320.00, 6.00, 'Xiaomi'),
('Apple', 750.00, 12.00, 'Apple'),
('Xiaomi', 380.00, 8.00, 'Xiaomi');

-- Create the procedure to display details
CREATE PROCEDURE DisplayProductDetails
AS
BEGIN
    SELECT Pld, PName, PPricewithTax AS PPriceWithTax, PCompany, TotalPrice
    FROM Products;
END;
GO

-- Create the procedure to calculate total tax
CREATE PROCEDURE CalculateTotalTax
    @InputCompany VARCHAR(100),
    @TotalTax DECIMAL(10, 2) OUTPUT
WITH ENCRYPTION
AS
BEGIN
    SELECT @TotalTax = SUM(PTax) 
    FROM Products 
    WHERE PCompany = @InputCompany;
END;
GO