            -- Transactions and Triggers -- 
--Create a database ‘Stocks’ with the four relations Laptops, Products, Printers, and Personal Computers and answer the following questions based on the database. Data for the relations are given in the 2nd and 3rd page of the exercise. 

CREATE DATABASE Stocks;

 USE Stock;

-- Transactions

 CREATE TABLE PersonalComputers(
	PC_Model INT PRIMARY KEY,
	PC_Speed INT,
	PC_RAM INT,
	PC_HD INT,
	CD_ROM VARCHAR(20),
	PC_Price DECIMAL(10,2)
);
Query OK, 0 rows affected (0.019 sec)

CREATE TABLE Laptops (
    LT_Model INT PRIMARY KEY,
    LT_Speed INT,
    LT_RAM INT,
    LT_HD INT,
    Screen DECIMAL(4,1),
    LT_Price DECIMAL(10,2)
);
Query OK, 0 rows affected (0.035 sec)

CREATE TABLE Printers (
    PR_Model INT PRIMARY KEY,
    Colour BOOLEAN,
    PR_Type VARCHAR(20),
    PR_Price DECIMAL(10,2)
);
Query OK, 0 rows affected (0.017 sec)


CREATE TABLE Products (
    Maker CHAR(1),
    Model INT PRIMARY KEY,
    Type VARCHAR(20)
);
Query OK, 0 rows affected (0.017 sec)

CREATE TABLE Personal_Computers (
    PC_Model INT PRIMARY KEY,
    PC_Speed INT,
    PC_RAM INT,
    PC_HD INT,
    CD_ROM VARCHAR(10),
    PC_Price INT
);

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
Query OK, 10 rows affected (0.009 sec)
Records: 10  Duplicates: 0  Warnings: 0


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
Query OK, 13 rows affected (0.008 sec)
Records: 13  Duplicates: 0  Warnings: 0

INSERT INTO Printers (PR_Model, Colour, PR_Type, PR_Price) VALUES
(3001, TRUE, 'ink-jet', 231),
(3002, TRUE, 'ink-jet', 267),
(3003, FALSE, 'laser', 390),
(3004, TRUE, 'ink-jet', 439),
(3005, TRUE, 'bubble', 200),
(3006, TRUE, 'laser', 1999),
(3007, FALSE, 'laser', 350);
Query OK, 7 rows affected (0.008 sec)
Records: 7  Duplicates: 0  Warnings: 0

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
Query OK, 30 rows affected (0.008 sec)
Records: 30  Duplicates: 0  Warnings: 0



-- Write transactions for each of the following cases: --
--1. To display the laptops with speed more than 600. -
SELECT *
FROM Laptops
WHERE LT_Speed > 600;
+----------+----------+--------+-------+--------+----------+
| LT_Model | LT_Speed | LT_RAM | LT_HD | Screen | LT_Price |
+----------+----------+--------+-------+--------+----------+
|     2001 |      700 |     64 |     5 |   12.1 |  1448.00 |
|     2002 |      800 |     96 |    10 |   15.1 |  2584.00 |
|     2003 |      850 |     64 |    10 |   15.1 |  2738.00 |
|     2006 |      800 |     96 |    20 |   15.7 |  2999.00 |
|     2007 |      850 |    128 |    20 |   15.0 |  3099.00 |
|     2008 |      650 |     64 |    10 |   12.1 |  1249.00 |
|     2009 |      750 |    256 |    20 |   15.1 |  2599.00 |
+----------+----------+--------+-------+--------+----------+
7 rows in set (0.005 sec)

-- 2. List down the laptops with RAM size 64. 
SELECT *
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
5 rows in set (0.007 sec)

-- 3. To find the maker and the type of the cheapest price laptop.  
SELECT P.Maker,P.Type
FROM Products P
JOIN Laptops L ON P.Model = L.LT_Model
WHERE L.LT_Price = (SELECT MIN(LT_Price) FROM Laptops);
+-------+--------+
| Maker | Type   |
+-------+--------+
| A     | laptop |
+-------+--------+
1 row in set (0.015 sec)

-- 4. To find the details of the PC with the highest price.  
SELECT *
FROM Personal_Computers
WHERE PC_Price = ( SELECT MAX(PC_Price) FROM Personal_Computers);
+----------+----------+--------+-------+--------+----------+
| PC_Model | PC_Speed | PC_RAM | PC_HD | CD_ROM | PC_Price |
+----------+----------+--------+-------+--------+----------+
|     1002 |     1500 |    128 |    60 | 12XCD  |     2499 |
|     1013 |      733 |    256 |    60 | 12XCD  |     2499 |
+----------+----------+--------+-------+--------+----------+
2 rows in set (0.007 sec)

-- 5. List down the model numbers and price of colour printers. 
SELECT PR_Model , PR_Price
FROM Printers
WHERE Colour = 'true';
+----------+----------+
| PR_Model | PR_Price |
+----------+----------+
|     3003 |   390.00 |
|     3007 |   350.00 |
+----------+----------+
2 rows in set, 1 warning (0.002 sec)

-- 6. To find the makers of laptops. 
SELECT DISTINCT Maker
FROM Products
WHERE Type = 'laptop';
+-------+
| Maker |
+-------+
| B     |
| A     |
| D     |
| C     |
| E     |
+-------+
5 rows in set (0.007 sec)

-- 7. To find the makers of printers. 
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

-- 8. To find the maker of the high speed laptop. 
SELECT P.Maker
FROM Products P
JOIN Laptops L ON P.Model = L.LT_Model
WHERE L.LT_Speed = (SELECT MAX(LT_Speed) FROM Laptops);
+-------+
| Maker |
+-------+
| B     |
| D     |
+-------+
2 rows in set (0.001 sec)


-- 9.To find the maker and price of the high speed PC.
SELECT P.Maker , PC.PC_Price
FROM Products P
JOIN Personal_Computers PC ON P.Model = PC.PC_Model
WHERE PC_Speed = ( SELECT MAX(PC_Speed) FROM Personal_Computers);
+-------+----------+
| Maker | PC_Price |
+-------+----------+
| A     |     2499 |
+-------+----------+
1 row in set (0.001 sec)

-- 10.  To find the RAM size of the slowest PC. 
SELECT PC_RAM FROM Personal_Computers
WHERE PC_Speed = (SELECT MIN(PC_Speed) FROM Personal_Computers);
+--------+
| PC_RAM |
+--------+
|     64 |
+--------+
1 row in set (0.000 sec)




-- Triggers
--1. To check the RAM size of the PC is either 64, 128, or 256 before insert a new records. 
--Check the trigger with one true case and one false case example.
DELIMITER //
CREATE TRIGGER CheckPCRAM
BEFORE INSERT ON Personal_Computers
FOR EACH ROW
BEGIN
  IF NEW.PC_RAM NOT IN (64, 128, 256) THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'RAM must be 64, 128, or 256';
  END IF;
END;
//

DELIMITER ;
Query OK, 0 rows affected (0.028 sec)

INSERT INTO Personal_Computers VALUES (1014, 800, 128, 20, '12XCD', 1500);
Query OK, 1 row affected (0.017 sec)


INSERT INTO Personal_Computers VALUES (1015, 800, 512, 20, '12XCD', 1500);
ERROR 1644 (45000): RAM must be 64, 128, or 256


-- 2. Increase the price of all the printers by 2 times of the current price. Store the old price and model of the printers in before performing the update. 
CREATE TABLE Printer_Backup (
    PR_Model INT,
    Old_Price DECIMAL(10,2)
);
Query OK, 0 rows affected (0.023 sec)


DELIMITER //

CREATE TRIGGER BackupAndDoublePrice
BEFORE UPDATE ON Printers
FOR EACH ROW
BEGIN
  INSERT INTO Printer_Backup (PR_Model, Old_Price)
  VALUES (OLD.PR_Model, OLD.PR_Price);

  SET NEW.PR_Price = OLD.PR_Price * 2;
END;
//

DELIMITER ;

Query OK, 0 rows affected (0.024 sec)



-- 3. Delete the records of all the printers from product and store the details of deleted records in a separate relation.
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
END;
//

DELIMITER ;
Query OK, 0 rows affected (0.022 sec)

