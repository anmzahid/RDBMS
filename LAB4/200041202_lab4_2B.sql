--TASK B--
CREATE TABLE Grades (
    ID INT PRIMARY KEY,
    Department VARCHAR(255),
    Programme VARCHAR(255),
    CourseCode VARCHAR(255),
    Grade VARCHAR(255)
);
INSERT INTO Grades (ID, Department, Programme, CourseCode, Grade)
VALUES(1, 'CSE', 'BSc', 'CSE 4508', 'A+');

INSERT INTO Grades (ID, Department, Programme, CourseCode, Grade)
VALUES  (2, 'CSE', 'BSc', 'CSE 4551', 'A+');

INSERT INTO Grades (ID, Department, Programme, CourseCode, Grade)
VALUES (3, 'EEE', 'HD', 'EEE 2001', 'A-');

INSERT INTO Grades (ID, Department, Programme, CourseCode, Grade)
VALUES (4, 'EEE', 'BSc', 'EEE 2005', 'B');

INSERT INTO Grades (ID, Department, Programme, CourseCode, Grade)
VALUES   (5, 'CSE', 'HD', 'CSE 4302', 'A');

  INSERT INTO Grades (ID, Department, Programme, CourseCode, Grade)
VALUES  (6, 'EEE', 'BSc', 'EEE 2003', 'A+');

 INSERT INTO Grades (ID, Department, Programme, CourseCode, Grade)
VALUES   (7, 'CSE', 'HD', 'CSE 4406', 'B-');

  INSERT INTO Grades (ID, Department, Programme, CourseCode, Grade)
VALUES  (8, 'MPE', 'MSc', 'MPE 1302', 'A-');

  INSERT INTO Grades (ID, Department, Programme, CourseCode, Grade)
VALUES  (9, 'BTM', 'MSc', 'BTM 6202', 'A-');

    INSERT INTO Grades (ID, Department, Programme, CourseCode, Grade)
VALUES(10, 'MPE', 'HD', 'MPE 1302', 'A+');

   INSERT INTO Grades (ID, Department, Programme, CourseCode, Grade)
VALUES (11, 'CEE', 'MSc', 'CEE 5302', 'A-');

   INSERT INTO Grades (ID, Department, Programme, CourseCode, Grade)
VALUES   (12, 'BTM', 'BSc', 'BTM 6302', 'B-');
    



    SELECT Department,Programme
    CourseCode,Grade ,
    COUNT(*) AS Count 
    FROM Grades
    GROUP BY ROLLUP (Department,Programme,CourseCode,Grade)
    ORDER BY Department,Programme,CourseCode,Grade;
     
     
     SELECT Department,Programme
    CourseCode,Grade ,
    COUNT(*) AS Count 
    FROM Grades
    GROUP BY CUBE(Department,Programme,CourseCode,Grade)
    ORDER BY Department,Programme,CourseCode,Grade;


--TASK A--
CREATE TABLE Occupation(
    ID INT PRIMARY KEY,
    General VARCHAR(30),
    Specific  VARCHAR(30),
    Salary DECIMAL(10,2)
);

INSERT INTO Occupation (ID, General, Specific, Salary)
VALUES (1, 'Teacher', 'School', 45000.00);

INSERT INTO Occupation (ID, General, Specific, Salary)
VALUES (2, 'Engineer', 'CSE', 450000.00);

INSERT INTO Occupation (ID, General, Specific, Salary)
VALUES (3, 'Teacher', 'University', 145000.00);

INSERT INTO Occupation (ID, General, Specific, Salary)
VALUES (4, 'Teacher', 'College', 115000.00);

INSERT INTO Occupation (ID, General, Specific, Salary)
VALUES (5, 'Engineer', 'Electrical', 45000.00);

INSERT INTO Occupation (ID, General, Specific, Salary)
VALUES (6, 'Engineer', 'CSE', 350000.00);


INSERT INTO Occupation (ID, General, Specific, Salary)
VALUES (7, 'Student', 'School', 1000.00);

INSERT INTO Occupation (ID, General, Specific, Salary)
VALUES (8, 'Student', 'University', 6000.00);

--i--
SELECT 
General,Specific,COUNT(*) AS Count
FROM Occupation
GROUP BY General,Specific
ORDER BY Count DESC;
--ii--
SELECT
General,
MIN(Salary) AS Min,
MAX(Salary) AS Max,
AVG(Salary) AS Avg
FROM Occupation
GROUP BY General;

--iii--
SELECT General
FROM Occupation
GROUP BY General
HAVING AVG(Salary) >= (SELECT AVG(Salary) FROM Occupation);

--iii-

WITH OverallAvg AS (
    SELECT AVG(Salary) AS TavgSal
    FROM Occupation
)

SELECT General,
       MIN(Salary) AS Min,
       MAX(Salary) AS Max,
       AVG(Salary) AS Avg
FROM Occupation
GROUP BY General
HAVING AVG(Salary) >= (SELECT TavgSal FROM OverallAvg)
ORDER BY AVG(Salary) DESC
FETCH FIRST ROW ONLY;


--iv-
CREATE VIEW GeneralAvgSalary AS
SELECT
    General,
    AVG(Salary) AS AvgSalary
FROM Occupation
GROUP BY General;

ORDER BY AvgSalary DESC;
SELECT General, AvgSalary
FROM GeneralAvgSalary
ORDER BY AvgSalary DESC
FETCH FIRST ROW ONLY;







-- Set column widths and headings
COLUMN DEPARTMENT FORMAT A15 HEADING 'DEPARTMENT'
COLUMN COURSECODE FORMAT A20 HEADING 'COURSECODE'
COLUMN GRADE FORMAT A5 HEADING 'GRADE'
COLUMN COUNT FORMAT 999 HEADING 'COUNT'

-- Create a page break for each department
BREAK ON DEPARTMENT SKIP 1

-- Query your data
SELECT DEPARTMENT, COURSECODE, GRADE, COUNT(*)
FROM Grades
ORDER BY DEPARTMENT, COURSECODE, GRADE;

-- Reset formatting options
CLEAR BREAK
CLEAR COLUMNS
