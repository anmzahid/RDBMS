-- Create the transactions table
CREATE TABLE transactions (
    User_ID NUMBER,
    Amount NUMBER,
    T_Date DATE
);

INSERT INTO transactions (User_ID, Amount, T_Date)
VALUES (1, 600000, TO_DATE('2023-10-20', 'YYYY-MM-DD'));

INSERT INTO transactions (User_ID, Amount, T_Date)
VALUES (2, 117500, TO_DATE('2023-10-18', 'YYYY-MM-DD'));

INSERT INTO transactions (User_ID, Amount, T_Date)
VALUES (3, 2300500, TO_DATE('2023-10-15', 'YYYY-MM-DD'));

INSERT INTO transactions (User_ID, Amount, T_Date)
VALUES (1, 2145000, TO_DATE('2023-09-25', 'YYYY-MM-DD'));

INSERT INTO transactions (User_ID, Amount, T_Date)
VALUES (2, 1600000, TO_DATE('2023-09-23', 'YYYY-MM-DD'));

INSERT INTO transactions (User_ID, Amount, T_Date)
VALUES (4, 600000, TO_DATE('2023-09-23', 'YYYY-MM-DD'));

INSERT INTO transactions (User_ID, Amount, T_Date)
VALUES (5, 1100000, TO_DATE('2023-09-23', 'YYYY-MM-DD'));


CREATE TABLE loan_type(
    Scheme NUMBER CHECK (Scheme IN (1, 2, 3)),
    Installment_Number NUMBER,
    Charge NUMBER,
    Min_Trans NUMBER
    );



INSERT INTO loan_type (Scheme, Installment_Number, Charge, Min_Trans)
VALUES (1, 30, 5, 2000000);

INSERT INTO loan_type (Scheme, Installment_Number, Charge, Min_Trans)
VALUES (2, 20, 10, 1000000);

INSERT INTO loan_type (Scheme, Installment_Number, Charge, Min_Trans)
VALUES (3, 15, 15, 500000);



-- Create a PL/SQL function to determine the loan scheme
CREATE OR REPLACE FUNCTION loan_scheme(p_User_ID IN NUMBER) RETURN NUMBER IS
    v_total_trans NUMBER := 0;
    v_loan_scheme NUMBER;
    v_loan_min_trans NUMBER;
    
    CURSOR loan_cursor IS
        SELECT Scheme, Min_Trans
        FROM loan_type;
BEGIN
    SELECT SUM(Amount) INTO v_total_trans
    FROM transactions
    WHERE User_ID = p_User_ID
    AND T_Date >= ADD_MONTHS(SYSDATE, -12);
    
    v_loan_scheme := 0;

    OPEN loan_cursor;
    FETCH loan_cursor INTO v_loan_scheme, v_loan_min_trans;

    WHILE loan_cursor%FOUND LOOP
        IF v_total_trans >= v_loan_min_trans THEN
            EXIT;
        END IF;
        FETCH loan_cursor INTO v_loan_scheme, v_loan_min_trans;
    END LOOP;

    CLOSE loan_cursor;

    RETURN v_loan_scheme;
END;
/



DECLARE
    scheme_type NUMBER;
BEGIN
    scheme_type := loan_scheme(3);
    IF scheme_type = 1 THEN
        DBMS_OUTPUT.PUT_LINE('Customer is eligable for Loan service : S-A');
    ELSIF scheme_type = 2 THEN
        DBMS_OUTPUT.PUT_LINE('Customer is eligable for Loan service : S-B');
    ELSIF scheme_type = 3 THEN
        DBMS_OUTPUT.PUT_LINE('Customer is eligable for Loan service : S-C');
    END IF;
END;
/




