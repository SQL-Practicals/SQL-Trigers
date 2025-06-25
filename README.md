# SQL Triggers
---
This README contains SQL code for creating and manipulating the 'Stocks' database, which includes tables for Laptops, Products, Printers, and Personal Computers.
It demonstrates transactions and triggers based on the provided exercise.


## 1. 🗄️ Database Creation
Creates the `Stocks` database and sets it as the active database.

```sql
CREATE DATABASE Stocks;
USE Stocks;
```

---

## 2. 📋 Table Definitions
Defines the four tables with their respective columns and constraints.

```sql
CREATE TABLE Personal_Computers (
    PC_Model INT PRIMARY KEY,
    PC_Speed INT,
    PC_RAM INT,
    PC_HD INT,
    CD_ROM VARCHAR(10),
    PC_Price INT
);

CREATE TABLE Laptops (
    LT_Model INT PRIMARY KEY,
    LT_Speed INT,
    LT_RAM INT,
    LT_HD INT,
    Screen DECIMAL(4,1),
    LT_Price DECIMAL(10,2)
);

CREATE TABLE Printers (
    PR_Model INT PRIMARY KEY,
    Colour BOOLEAN,
    PR_Type VARCHAR(20),
    PR_Price DECIMAL(10,2)
);

CREATE TABLE Products (
    Maker CHAR(1),
    Model INT PRIMARY KEY,
    Type VARCHAR(20)
);
``` 

---

## 3. 📥 Data Insertion
Inserts sample data into each of the tables.

```sql
INSERT INTO Laptops (LT_Model, LT_Speed, LT_RAM, LT_HD, Screen, LT_Price) VALUES
(2001, 700, 64, 5, 12.1, 1448),
(2002, 800, 96, 10, 15.1, 2584),
(2003, 850, 64, 10, 15.1, 2738),
(2004, 550, 32, 5, 12.1, 999),
(2005, 600, 64, 6, 12.1, 2399),
(2006, 800, 96, 20, 15.7, 2999),
(2007, 850, 128, 20, 15.0, 3099),
(2008, 650, 64, 10, 12.1, 1249),
(2009, 750, 256, 20, 15.1, 2599),
(2010, 366, 64, 10, 12.1, 1499);

INSERT INTO Personal_Computers (PC_Model, PC_Speed, PC_RAM, PC_HD, CD_ROM, PC_Price) VALUES
(1001, 700, 64, 10, '48XCD', 799),
(1002, 1500, 128, 60, '12XCD', 2499),
(1003, 866, 128, 20, '8XCD', 1999),
(1004, 866, 64, 10, '12XCD', 999),
(1005, 1000, 128, 20, '12XCD', 1499),
(1006, 1300, 256, 40, '16XCD', 2119),
(1007, 1400, 128, 80, '12XCD', 2299),
(1008, 700, 64, 30, '24XCD', 999),
(1009, 1200, 128, 80, '16XCD', 1699),
(1010, 750, 64, 30, '40XCD', 699),
(1011, 1100, 128, 60, '16XCD', 1299),
(1012, 350, 64, 7, '48XCD', 799),
(1013, 733, 256, 60, '12XCD', 2499);

INSERT INTO Printers (PR_Model, Colour, PR_Type, PR_Price) VALUES
(3001, TRUE, 'ink-jet', 231),
(3002, TRUE, 'ink-jet', 267),
(3003, FALSE, 'laser', 390),
(3004, TRUE, 'ink-jet', 439),
(3005, TRUE, 'bubble', 200),
(3006, TRUE, 'laser', 1999),
(3007, FALSE, 'laser', 350);

INSERT INTO Products (Maker, Model, Type) VALUES
('A', 1001, 'pc'),
('A', 1002, 'pc'),
('A', 1003, 'pc'),
('A', 2004, 'laptop'),
('A', 2005, 'laptop'),
('A', 2006, 'laptop'),
('B', 1004, 'pc'),
('B', 1005, 'pc'),
('B', 1006, 'pc'),
('B', 2001, 'laptop'),
('B', 2002, 'laptop'),
('B', 2003, 'laptop'),
('C', 1007, 'pc'),
('C', 1008, 'pc'),
('C', 2008, 'laptop'),
('C', 2009, 'laptop'),
('C', 3002, 'printer'),
('C', 3003, 'printer'),
('C', 3006, 'printer'),
('D', 1009, 'pc'),
('D', 1010, 'pc'),
('D', 1011, 'pc'),
('D', 2007, 'laptop'),
('E', 1012, 'pc'),
('E', 1013, 'pc'),
('E', 2010, 'laptop'),
('F', 3001, 'printer'),
('F', 3004, 'printer'),
('G', 3005, 'printer'),
('H', 3007, 'printer');
```  

---

## 4. 🔄 Transactions
Performs various queries on the database with their results.

1. **Display laptops with speed > 600**
```sql
SELECT * FROM Laptops WHERE LT_Speed > 600;
```
```
-- Result:
 LT_Model | LT_Speed | LT_RAM | LT_HD | Screen | LT_Price
----------+----------+--------+-------+--------+----------
      2001 |      700 |     64 |     5 |   12.1 |  1448.00
      2002 |      800 |     96 |    10 |   15.1 |  2584.00
      2003 |      850 |     64 |    10 |   15.1 |  2738.00
      2006 |      800 |     96 |    20 |   15.7 |  2999.00
      2007 |      850 |    128 |    20 |   15.0 |  3099.00
      2008 |      650 |     64 |    10 |   12.1 |  1249.00
      2009 |      750 |    256 |    20 |   15.1 |  2599.00
```  

2. **List laptops with RAM size = 64**
```sql
SELECT * FROM Laptops WHERE LT_RAM = 64;
```
```
-- Result:
 LT_Model | LT_Speed | LT_RAM | LT_HD | Screen | LT_Price
----------+----------+--------+-------+--------+----------
      2001 |      700 |     64 |     5 |   12.1 |  1448.00
      2003 |      850 |     64 |    10 |   15.1 |  2738.00
      2005 |      600 |     64 |     6 |   12.1 |  2399.00
      2008 |      650 |     64 |    10 |   12.1 |  1249.00
      2010 |      366 |     64 |    10 |   12.1 |  1499.00
```  

3. **Find maker and type of the cheapest laptop**
```sql
SELECT P.Maker, P.Type
FROM Products P
JOIN Laptops L ON P.Model = L.LT_Model
WHERE L.LT_Price = (SELECT MIN(LT_Price) FROM Laptops);
```
```
-- Result:
 Maker | Type  
-------+-------
  A    | laptop
```  

4. **Details of PC with highest price**
```sql
SELECT * FROM Personal_Computers
WHERE PC_Price = (SELECT MAX(PC_Price) FROM Personal_Computers);
```
```
-- Result:
 PC_Model | PC_Speed | PC_RAM | PC_HD | CD_ROM | PC_Price
----------+----------+--------+-------+--------+----------
    1002  |    1500  |   128  |   60  | 12XCD  |   2499
    1013  |     733  |   256  |   60  | 12XCD  |   2499
```  

5. **List model numbers and prices of colour printers**
```sql
SELECT PR_Model, PR_Price FROM Printers WHERE Colour = TRUE;
```
```
-- Result:
 PR_Model | PR_Price
----------+----------
   3001   |    231.00
   3002   |    267.00
   3004   |    439.00
   3005   |    200.00
   3006   |   1999.00
```  

6. **Find makers of laptops**
```sql
SELECT DISTINCT Maker FROM Products WHERE Type = 'laptop';
```
```
-- Result:
 Maker
------
  A
  B
  C
  D
  E
```  

7. **Find makers of printers**
```sql
SELECT DISTINCT Maker FROM Products WHERE Type = 'printer';
```
```
-- Result:
 Maker
------
  C
  F
  G
  H
```  

8. **Find maker(s) of the highest speed laptop**
```sql
SELECT P.Maker
FROM Products P
JOIN Laptops L ON P.Model = L.LT_Model
WHERE L.LT_Speed = (SELECT MAX(LT_Speed) FROM Laptops);
```
```
-- Result:
 Maker
------
  B
  D
```  

9. **Maker and price of the highest speed PC**
```sql
SELECT P.Maker, PC.PC_Price
FROM Products P
JOIN Personal_Computers PC ON P.Model = PC.PC_Model
WHERE PC_Speed = (SELECT MAX(PC_Speed) FROM Personal_Computers);
```
```
-- Result:
 Maker | PC_Price
-------+----------
  A    |   2499  
```  

10. **RAM size of the slowest PC**
```sql
SELECT PC_RAM FROM Personal_Computers
WHERE PC_Speed = (SELECT MIN(PC_Speed) FROM Personal_Computers);
```
```
-- Result:
 PC_RAM
-------
  64   
```  

---

## 5. 🛡️ Triggers
Defines triggers to enforce constraints and perform actions on data modifications.

### 5.1 Check RAM size before inserting into Personal_Computers
Ensures RAM size is either 64, 128, or 256 before inserting a new record.

```sql
DELIMITER //
CREATE TRIGGER CheckPCRAM
BEFORE INSERT ON Personal_Computers
FOR EACH ROW
BEGIN
  IF NEW.PC_RAM NOT IN (64, 128, 256) THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'RAM must be 64, 128, or 256';
  END IF;
END;//
DELIMITER ;

-- ✅ Insert with valid RAM
INSERT INTO Personal_Computers VALUES (1014, 800, 128, 20, '12XCD', 1500);

-- ❌ Insert with invalid RAM (fails)
INSERT INTO Personal_Computers VALUES (1015, 800, 512, 20, '12XCD', 1500);
```  

### 5.2 Backup and double the price of printers before update
Backs up the old price and model of printers before doubling their price.

```sql
CREATE TABLE Printer_Backup (
    PR_Model INT,
    Old_Price DECIMAL(10,2)
);

DELIMITER //
CREATE TRIGGER BackupAndDoublePrice
BEFORE UPDATE ON Printers
FOR EACH ROW
BEGIN
  INSERT INTO Printer_Backup (PR_Model, Old_Price)
  VALUES (OLD.PR_Model, OLD.PR_Price);
  SET NEW.PR_Price = OLD.PR_Price * 2;
END;//
DELIMITER ;
```  

### 5.3 Backup deleted printer records from Products
Stores details of deleted printer records in a separate table.

```sql
CREATE TABLE Deleted_Printers (
    Maker CHAR(1),
    Model INT,
    Type VARCHAR(20)
);

DELIMITER //
CREATE TRIGGER BackupDeletedPrinters
BEFORE DELETE ON Products
FOR EACH ROW
BEGIN
  IF OLD.Type = 'printer' THEN
    INSERT INTO Deleted_Printers (Maker, Model, Type)
    VALUES (OLD.Maker, OLD.Model, OLD.Type);
  END IF;
END;//
DELIMITER ;
```

---

This file provides a comprehensive overview of the **Stocks** database, including its creation, table structures, data, transactions, and triggers.
