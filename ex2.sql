CREATE DATABASE Stockes;

use Stockes;

CREATE TABLE Products(
	Maker VARCHAR(10),
	Model INT PRIMARY KEY,
	Type VARCHAR(20)
);

CREATE TABLE Personal_Computers(
	PC_Model INT PRIMARY KEY,
	PC_Speed INT,
	PC_RAM INT,
	PC_HD INT,
	CD_ROM VARCHAR(10),
	PC_Price DECIMAL(10,2),
	FOREIGN KEY(PC_Model) REFERENCES Products(Model)
);

CREATE TABLE Laptops(
	LT_Model INT PRIMARY KEY,
	LT_Speed INT,
	LT_RAM INT,
	LT_HD INT,
	Screen DECIMAL(4,1),
	LT_Price DECIMAL(10,2),
	FOREIGN KEY(LT_Model) REFERENCES Products(Model)
);

CREATE TABLE Printers(
	PR_Model INT PRIMARY KEY,
	Colour BOOLEAN,
	PR_Type VARCHAR(20),
	PR_Price DECIMAL(10,2),
	FOREIGN KEY (PR_Model) REFERENCES Products(Model)
);

INSERT INTO Personal_Computers (PC_Model, PC_Speed, PC_RAM, PC_HD, CD_ROM, PC_Price) VALUES
  (1001,  700,  64, 10, '48XCD',  799.00),
  (1002, 1500, 128, 60, '12XCD', 2499.00),
  (1003,  866, 128, 20,  '8XCD', 1999.00),
  (1004,  866,  64, 10, '12XCD',  999.00),
  (1005, 1000, 128, 20, '12XCD', 1499.00),
  (1006, 1300, 256, 40, '16XCD', 2119.00),
  (1007, 1400, 128, 80, '12XCD', 2299.00),
  (1008,  700,  64, 30, '24XCD',  999.00),
  (1009, 1200, 128, 80, '16XCD', 1699.00),
  (1010,  750,  64, 30, '40XCD',  699.00),
  (1011, 1100, 128, 60, '16XCD', 1299.00),
  (1012,  350,  64,  7, '48XCD',  799.00),
  (1013,  733, 256, 60, '12XCD', 2499.00);

INSERT INTO Laptops (LT_Model, LT_Speed, LT_RAM, LT_HD, Screen, LT_Price) VALUES
  (2001, 700,  64,  5,  12.1, 1448.00),
  (2002, 800,  96, 10,  15.1, 2584.00),
  (2003, 850,  64, 10,  15.1, 2738.00),
  (2004, 550,  32,  5,  12.1,  999.00),
  (2005, 600,  64,  6,  12.1, 2399.00),
  (2006, 800,  96, 20,  15.7, 2999.00),
  (2007, 850, 128, 20,  15.0, 3099.00),
  (2008, 650,  64, 10,  12.1, 1249.00),
  (2009, 750, 256, 20,  15.1, 2599.00),
  (2010, 366,  64, 10,  12.1, 1499.00);
  
INSERT INTO Printers (PR_Model, Colour, PR_Type, PR_Price) VALUES
  (3001, TRUE,  'ink-jet',  231.00),
  (3002, TRUE,  'ink-jet',  267.00),
  (3003, FALSE, 'laser',    390.00),
  (3004, TRUE,  'ink-jet',  439.00),
  (3005, TRUE,  'bubble',   200.00),
  (3006, TRUE,  'laser',   1999.00),
  (3007, FALSE, 'laser',    350.00);
  
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


-- Q1. List all laptops faster than 800 MHz. --
SELECT *
FROM Laptops
WHERE LT_Speed > 800;
+----------+----------+--------+-------+--------+----------+
| LT_Model | LT_Speed | LT_RAM | LT_HD | Screen | LT_Price |
+----------+----------+--------+-------+--------+----------+
|     2003 |      850 |     64 |    10 |   15.1 |  2738.00 |
|     2007 |      850 |    128 |    20 |   15.0 |  3099.00 |
+----------+----------+--------+-------+--------+----------+
2 rows in set (0.001 sec)


-- Q2. Find every laptop with exactly 64 MB of RAM.
SELECT LT_Model , LT_Speed , LT_RAM , LT_HD , Screen , LT_Price
FROM Laptops
WHERE LT_RAM = 64;
+----------+----------+--------+-------+--------+----------+
| LT_Model | LT_Speed | LT_RAM | LT_HD | Screen | LT_Price |
+----------+----------+--------+-------+--------+----------+
|     2001 |      700 |     64 |     5 |   12.1 |  1448.00 |
|     2003 |      850 |     64 |    10 |   15.1 |  2738.00 |
|     2005 |      600 |     64 |     6 |   12.1 |  2399.00 |
|     2008 |      650 |     64 |    10 |   12.1 |  1249.00 |
|     2010 |      366 |     64 |    10 |   12.1 |  1499.00 |
+----------+----------+--------+-------+--------+----------+
5 rows in set (0.001 sec)

--  Which maker produces the cheapest laptop?
SELECT P.Maker , P.Type
FROM Products P
JOIN Laptops L ON P.Model = L.LT_Model
WHERE L.LT_Price = (
	SELECT MIN(LT_Price) FROM Laptops
);
+-------+--------+
| Maker | Type   |
+-------+--------+
| A     | laptop |
+-------+--------+
1 row in set (0.005 sec)


-- Show the full details of the most expensive PC.
SELECT *
FROM Personal_Computers
WHERE PC_Price = (
	SELECT MAX(PC_Price)
	FROM Personal_Computers
);
+----------+----------+--------+-------+--------+----------+
| PC_Model | PC_Speed | PC_RAM | PC_HD | CD_ROM | PC_Price |
+----------+----------+--------+-------+--------+----------+
|     1002 |     1500 |    128 |    60 | 12XCD  |  2499.00 |
|     1013 |      733 |    256 |    60 | 12XCD  |  2499.00 |
+----------+----------+--------+-------+--------+----------+
2 rows in set (0.001 sec)


-- List all color printers’ models and prices. --
SELECT PR_Model,PR_Price
FROM Printers
WHERE Colour = TRUE;
+----------+----------+
| PR_Model | PR_Price |
+----------+----------+
|     3001 |   231.00 |
|     3002 |   267.00 |
|     3004 |   439.00 |
|     3005 |   200.00 |
|     3006 |  1999.00 |
+----------+----------+
5 rows in set (0.001 sec)

-- Give a distinct list of all makers who sell laptops. --
SELECT DISTINCT Maker
FROM Products
WHERE Type = 'printer';
+-------+
| Maker |
+-------+
| F     |
| C     |
| G     |
| H     |
+-------+
4 rows in set (0.000 sec)

--Who makes the fastest laptop(s)?
SELECT P.Maker
FROM Products P
JOIN Laptops L ON P.Model = L.LT_Model
WHERE L.LT_Speed = (
	SELECT MAX(LT_Speed)
	FROM Laptops
);
+-------+
| Maker |
+-------+
| B     |
| D     |
+-------+
2 rows in set (0.001 sec)

--- Which maker and price correspond to the fastest PC?
SELECT P.Maker , PC.PC_Price
FROM Products P
JOIN Personal_Computers PC 
	ON P.Model = PC.PC_Model
WHERE PC.PC_Speed = (
	SELECT MAX(PC_Speed)
	FROM Personal_Computers
);

-- Q10. What is the RAM size of the slowest PC?
SELECT PC_RAM
FROM Personal_Computers
WHERE PC_Speed = (
	SELECT MIN(PC_Speed)
	FROM Personal_Computers
);
+--------+
| PC_RAM |
+--------+
|     64 |
+--------+
1 row in set (0.000 sec)


--  SQL Triggers
---Q1. Validate PC RAM on insert
--Question: Write a BEFORE INSERT trigger on Personal_Computers that rejects any new row whose PC_RAM is not in (64, 128, 256). Then show one insert that succeeds and one that fails.
DELIMITER //
CREATE TRIGGER chk_pc_ram
BEFORE INSERT ON Personal_Computers
FOR EACH ROW 
BEGIN
	IF NEW.PC_RAM NOT IN (64,128,256) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'RAM must be 64 , 128 or 256 ';
	END IF;
END;
//
DELIMITER ;

--Q2. Backup & double printer prices on update
--Question: Create a table Printer_Backup(PR_Model, Old_Price). Then write a BEFORE UPDATE trigger on Printers that first logs (PR_Model, PR_Price) into Printer_Backup and then doubles the new PR_Price. Demonstrate updating model 3001.

CREATE TABLE Printer_Backup(
	PR_Model INT,
	Old_Price DECIMAL(10,2)
);

DELIMITER //
CREATE TRIGGER backup_and_double
BEFORE UPDATE ON Printers
FOR EACH ROW 
BEGIN
	INSERT INTO Printer_Backup(PR_Model,Old_Price)
		VALUES(OLD.PR_Model,OLD.PR_Price);
	SET NEW.PR_Price = OLD.PR_Price * 2;
END;
//
DELIMITER ;

UPDATE Printers
SET PR_Price = PR_Price
WHERE PR_Model = 3001;


----Q3. Archive deleted printer‐type products
---Question: Create Deleted_Printers(Maker, Model, Type). Write an AFTER DELETE trigger on Products that, whenever a row of Type='printer' is removed, copies it into Deleted_Printers. Demonstrate by deleting model 3002 from Products
CREATE TABLE Deleted_Printers(
Maker CHAR(1),
Model INT,
Type VARCHAR(20)
);

DELIMITER //
CREATE TRIGGER archive_printer_delete
AFTER DELETE ON Products
FOR EACH ROW 
BEGIN
	IF OLD.Type = 'printer' THEN 
		INSERT INTO Deleted_Printers(Maker,Model,Type)
		VALUES(OLD.Maker,OLD.Model,OLD.Type);
	END IF;
END;
//
DELIMITER ;




