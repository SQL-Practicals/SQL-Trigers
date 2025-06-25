# SQL Triggers & Stocks Database

This `README.md` contains SQL code for creating and manipulating the **Stocks** database—which includes tables for Laptops, Products, Printers, and Personal Computers—and demonstrates triggers based on exercises.

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
  ...
  (2010, 366, 64, 10, 12.1, 1499);

INSERT INTO Personal_Computers (PC_Model, PC_Speed, PC_RAM, PC_HD, CD_ROM, PC_Price) VALUES
  (1001, 700, 64, 10, '48XCD', 799),
  ...
  (1013, 733, 256, 60, '12XCD', 2499);

INSERT INTO Printers (PR_Model, Colour, PR_Type, PR_Price) VALUES
  (3001, TRUE, 'ink-jet', 231),
  ...
  (3007, FALSE, 'laser', 350);

INSERT INTO Products (Maker, Model, Type) VALUES
  ('A', 1001, 'pc'),
  ...
  ('H', 3007, 'printer');
```

---

## 4. 🔄 Transactions
Performs various queries on the database with their results.
| Query Description                        | SQL Example                                                          |
|------------------------------------------|----------------------------------------------------------------------|
| Laptops with speed > 600                | `SELECT * FROM Laptops WHERE LT_Speed > 600;`                        |
| Laptops with RAM = 64                   | `SELECT * FROM Laptops WHERE LT_RAM = 64;`                           |
| Maker of cheapest laptop                | `SELECT P.Maker, P.Type FROM Products P JOIN Laptops L ...`          |
| Details of PC with highest price        | `SELECT * FROM Personal_Computers WHERE PC_Price = (SELECT ...)`     |
| Colour printer models and prices        | `SELECT PR_Model, PR_Price FROM Printers WHERE Colour = TRUE;`       |
| Distinct laptop makers                  | `SELECT DISTINCT Maker FROM Products WHERE Type='laptop';`           |
| Distinct printer makers                 | `SELECT DISTINCT Maker FROM Products WHERE Type='printer';`          |
| Maker(s) of fastest laptop              | `SELECT P.Maker FROM Products P JOIN Laptops L ...`                  |
| Maker and price of fastest PC           | `SELECT P.Maker, PC.PC_Price FROM Products P JOIN Personal_Computers PC ...` |
| RAM of slowest PC                       | `SELECT PC_RAM FROM Personal_Computers WHERE PC_Speed = (SELECT MIN(PC_Speed));` |

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
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'RAM must be 64, 128, or 256';
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

-- Demonstration:
UPDATE Printers SET PR_Price = PR_Price WHERE PR_Model = 3001;
SELECT * FROM Printer_Backup WHERE PR_Model = 3001;
```

### 5.3 Archive deleted printer records from Products
Stores details of deleted printer records in a separate table.
```sql
CREATE TABLE Deleted_Printers (
  Maker CHAR(1),
  Model INT,
  Type VARCHAR(20)
);

DELIMITER //
CREATE TRIGGER BackupDeletedPrinters
AFTER DELETE ON Products
FOR EACH ROW
BEGIN
  IF OLD.Type = 'printer' THEN
    INSERT INTO Deleted_Printers (Maker, Model, Type)
      VALUES (OLD.Maker, OLD.Model, OLD.Type);
  END IF;
END;//
DELIMITER ;

-- Demonstration:
DELETE FROM Products WHERE Model = 3002 AND Type = 'printer';
SELECT * FROM Deleted_Printers;
```

---

## 6. 🚀 New Stocks Schema & Data
Below is the new exercise content—**added** without altering the above sections.

```sql
CREATE DATABASE Stockes;
USE Stockes;

CREATE TABLE Products (
  Maker VARCHAR(10),
  Model INT PRIMARY KEY,
  Type VARCHAR(20)
);

CREATE TABLE Personal_Computers (
  PC_Model INT PRIMARY KEY,
  PC_Speed INT,
  PC_RAM INT,
  PC_HD INT,
  CD_ROM VARCHAR(10),
  PC_Price DECIMAL(10,2),
  FOREIGN KEY (PC_Model) REFERENCES Products(Model)
);

CREATE TABLE Laptops (
  LT_Model INT PRIMARY KEY,
  LT_Speed INT,
  LT_RAM INT,
  LT_HD INT,
  Screen DECIMAL(4,1),
  LT_Price DECIMAL(10,2),
  FOREIGN KEY (LT_Model) REFERENCES Products(Model)
);

CREATE TABLE Printers (
  PR_Model INT PRIMARY KEY,
  Colour BOOLEAN,
  PR_Type VARCHAR(20),
  PR_Price DECIMAL(10,2),
  FOREIGN KEY (PR_Model) REFERENCES Products(Model)
);

INSERT INTO Personal_Computers (PC_Model,PC_Speed,PC_RAM,PC_HD,CD_ROM,PC_Price) VALUES
  (1001,700,64,10,'48XCD',799.00),
  ...
  (1013,733,256,60,'12XCD',2499.00);

INSERT INTO Laptops (LT_Model,LT_Speed,LT_RAM,LT_HD,Screen,LT_Price) VALUES
  (2001,700,64,5,12.1,1448.00),
  ...
  (2010,366,64,10,12.1,1499.00);

INSERT INTO Printers (PR_Model,Colour,PR_Type,PR_Price) VALUES
  (3001,TRUE,'ink-jet',231.00),
  ...
  (3007,FALSE,'laser',350.00);

INSERT INTO Products (Maker,Model,Type) VALUES
  ('A',1001,'pc'),
  ...
  ('H',3007,'printer');
