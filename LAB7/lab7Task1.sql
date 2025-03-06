--Task A--
CREATE TABLE developers (
    ID NUMBER PRIMARY KEY,
    name VARCHAR2(50),
    salary NUMBER,
    years_of_experience NUMBER
);

-- Insert 
INSERT INTO developers (ID, name, salary, years_of_experience)
VALUES (1, 'rafin', 50000, 3);

INSERT INTO developers (ID, name, salary, years_of_experience)
VALUES (2, 'amit', 60000, 6);

INSERT INTO developers (ID, name, salary, years_of_experience)
VALUES (3, 'sahab', 70000, 9);

INSERT INTO developers (ID, name, salary, years_of_experience)
VALUES (4, 'zahid', 70000, 10);
COMMIT;

INSERT INTO developers (ID, name, salary, years_of_experience)
VALUES (5, 'zahid', 70000, 1);
COMMIT;
--procedure
DECLARE
    updated_count NUMBER := 0;
    count1 NUMBER :=0;
    count2 NUMBER :=0;
    count3 NUMBER :=0;
    
BEGIN
    
    FOR dev_rec IN (SELECT ID, name, salary, years_of_experience FROM developers) LOOP
        
        IF dev_rec.years_of_experience BETWEEN 2 AND 4 THEN
            UPDATE developers
            SET salary = dev_rec.salary * 1.08
            WHERE ID = dev_rec.ID;
            IF SQL%FOUND THEN 
            count1 :=SQL%ROWCOUNT;
            END IF;
        ELSIF dev_rec.years_of_experience BETWEEN 5 AND 7 THEN
            UPDATE developers
            SET salary = dev_rec.salary * 1.12
            WHERE ID = dev_rec.ID;
            IF SQL%FOUND THEN 
            count2 :=SQL%ROWCOUNT;
             END IF;
        ELSIF dev_rec.years_of_experience >= 8 THEN
            UPDATE developers
            SET salary = dev_rec.salary * 1.15
            WHERE ID = dev_rec.ID;
            IF SQL%FOUND THEN 
            count3 :=SQL%ROWCOUNT;
             END IF;
      
        END IF;
        updated_count :=count1+count2+count3;
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('Number of salaries changed: ' || updated_count);

    COMMIT;
END;
/



 