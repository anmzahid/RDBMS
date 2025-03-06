CREATE TABLE Address (
    Division VARCHAR(50) NOT NULL,
    District VARCHAR(50) NOT NULL,
    PostCode INT PRIMARY KEY
);
CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    PostCode INT,
    DateOfBirth DATE,
    FOREIGN KEY(PostCode) REFERENCES Address(PostCode)
);
CREATE TABLE Subscription (
    SubscriptionID INT PRIMARY KEY,
    CustomerID INT ,
    Subscriber_Level VARCHAR(20),
    LifetimeUsage DECIMAL(10, 2),
    FOREIGN KEY(CustomerID) REFERENCES Customer(CustomerID)
);


-- Task 1--
--A--
-- Insert data into the Address table
INSERT INTO Address (Division, District, PostCode)
VALUES ('Dhaka', 'Gazipur', 1200);

INSERT INTO Address (Division, District, PostCode)
VALUES ('Khulna', 'Khulna', 9000);

INSERT INTO Address (Division, District, PostCode)
VALUES ('Chittagong', 'Cumilla', 3500);

INSERT INTO Address (Division, District, PostCode)
VALUES ('Chittagong', 'Feni', 2700);

INSERT INTO Address (Division, District, PostCode)
VALUES ('Dhaka', 'Tangail', 1500);



-- Insert data into the Customer table
INSERT INTO Customer (CustomerID, CustomerName, PostCode, DateOfBirth)
VALUES (1, 'Rafin', 2700, TO_DATE('1990-05-15', 'YYYY-MM-DD'));

INSERT INTO Customer (CustomerID, CustomerName, PostCode, DateOfBirth)
VALUES (2, 'Zahid', 3500, TO_DATE('1985-11-03', 'YYYY-MM-DD'));

INSERT INTO Customer (CustomerID, CustomerName, PostCode, DateOfBirth)
VALUES (3, 'Salvi', 1200, TO_DATE('1995-02-20', 'YYYY-MM-DD'));

INSERT INTO Customer (CustomerID, CustomerName, PostCode, DateOfBirth)
VALUES (4, 'Sahab', 1500, TO_DATE('1988-08-10', 'YYYY-MM-DD'));

INSERT INTO Customer (CustomerID, CustomerName, PostCode, DateOfBirth)
VALUES (5, 'Abeer', 9000, TO_DATE('1992-03-25', 'YYYY-MM-DD'));

INSERT INTO Customer (CustomerID, CustomerName, PostCode, DateOfBirth)
VALUES (6, 'Abesh', 1200, TO_DATE('1993-09-18', 'YYYY-MM-DD'));

INSERT INTO Customer (CustomerID, CustomerName, PostCode, DateOfBirth)
VALUES (7, 'Amit', 1500, TO_DATE('1993-09-18', 'YYYY-MM-DD'));

-- Insert data into the Subscription table
INSERT INTO Subscription (SubscriptionID, CustomerID, Subscriber_Level, LifetimeUsage)
VALUES (101, 1, 'Silver', 500.00);

INSERT INTO Subscription (SubscriptionID, CustomerID, Subscriber_Level, LifetimeUsage)
VALUES (102, 2, 'Gold', 1200.50);

INSERT INTO Subscription (SubscriptionID, CustomerID, Subscriber_Level, LifetimeUsage)
VALUES (103, 3, 'Bronze', 300.75);

INSERT INTO Subscription (SubscriptionID, CustomerID, Subscriber_Level, LifetimeUsage)
VALUES (104, 4, 'Silver', 800.20);

INSERT INTO Subscription (SubscriptionID, CustomerID, Subscriber_Level, LifetimeUsage)
VALUES (105, 5, 'Platinum', 2500.75);

INSERT INTO Subscription (SubscriptionID, CustomerID, Subscriber_Level, LifetimeUsage)
VALUES (106, 6, 'Bronze', 150.50);

INSERT INTO Subscription (SubscriptionID, CustomerID, Subscriber_Level, LifetimeUsage)
VALUES (107, 7, 'Bronze', 1500.50);

--Task-A-3-i--
SELECT c.CustomerName, c.DateOfBirth, a.District, a.Division
FROM Customer c
JOIN Address a ON c.PostCode = a.PostCode
JOIN Subscription s ON c.CustomerID = s.CustomerID
WHERE s.Subscriber_Level = 'Platinum'
  AND s.LifetimeUsage > 2 * (SELECT MAX(LifetimeUsage) FROM Subscription WHERE Subscriber_Level = 'Silver');
--Task-A-3-ii--
SELECT c.CustomerName, c.CustomerID, s.LifetimeUsage
FROM Customer c
JOIN Subscription s ON c.CustomerID = s.CustomerID
ORDER BY s.LifetimeUsage DESC
FETCH FIRST 5 ROWS ONLY; 

--Task-A-3-iv--

UPDATE Subscription 
SET Subscriber_Level='Silver'
 WHERE Subscriber_Level='Bronze' AND
 LifetimeUsage >(SELECT AVG(LifetimeUsage) 
 FROM Subscription
 WHERE Subscriber_Level='Silver');

 SELECT c.CustomerName, c.CustomerID, s.LifetimeUsage,s.Subscriber_Level
FROM Customer c
JOIN Subscription s ON c.CustomerID = s.CustomerID;

--ETA hocche Amit er row--


--Task-A-3-iii--
UPDATE Subscription 
SET Subscriber_Level='Elite'
where CustomerID IN(
SELECT CustomerID
 FROM(
SELECT c.CustomerID
FROM Customer c
JOIN Subscription s ON c.CustomerID = s.CustomerID
ORDER BY s.LifetimeUsage DESC
FETCH FIRST 5 ROWS ONLY )top_customers
);


--Task-B-
SELECT CONCAT('Anm','Zahid') as myName  FROM dual;
SELECT INSTR('Bismillahir Rahmanir Rahim','Rahman') as Indx FROM dual;
SELECT LOWER('ANM ZAHID') as myName  FROM dual;
SELECT UPPER('anm zahid') as myName  FROM dual;
SELECT LENGTH('ANM ZAHID') as namelen FROM dual;
SELECT LPAD('ANM',3,'D') as leftpad FROM dual;
SELECT RPAD('ANM',3,'D') as rightpad FROM dual;
SELECT LTRIM('   ANM   ') as lefttrim FROM dual;
SELECT RTRIM('   ANM   ') as righttrim FROM dual;
SELECT SUBSTR('anm zahid',4,8) as myName FROM dual ;
SELECT COUNT(*) FROM Customer;