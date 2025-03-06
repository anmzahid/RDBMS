ALTER TABLE Books
ADD availability NUMBER DEFAULT 0;
-- Create the Borrowed_Books table
CREATE TABLE Borrowed_Books (
    txn_id NUMBER(10) PRIMARY KEY,
    b_id NUMBER(10),
    borrower_name VARCHAR2(100),
    borrowed_date DATE,
    returning_date DATE,
    CONSTRAINT fk_borrowed_books_book
    FOREIGN KEY (b_id)
    REFERENCES Books (book_id)
);

CREATE TABLE book_transaction_log (
    log_id NUMBER PRIMARY KEY,
    txn_type VARCHAR2(10),
    txn_date TIMESTAMP,
    b_id NUMBER,
    borrower_name VARCHAR2(100),
    borrowed_date DATE,
    returning_date DATE
);
-- Create a sequence for log_id in book_transaction_log table
CREATE SEQUENCE log_id_sequence
START WITH 1
INCREMENT BY 1;

-- Create the function to log book transactions
CREATE OR REPLACE FUNCTION log_book_transaction(
    p_txn_type VARCHAR2,
    p_b_id NUMBER,
    p_borrower_name VARCHAR2,
    p_borrowed_date DATE,
    p_returning_date DATE
) RETURN NUMBER
AS
BEGIN
    INSERT INTO book_transaction_log (
        log_id,
        txn_type,
        txn_date,
        b_id,
        borrower_name,
        borrowed_date,
        returning_date
    ) VALUES (
        log_id_sequence.NEXTVAL,
        p_txn_type,
        CURRENT_TIMESTAMP,
        p_b_id,
        p_borrower_name,
        p_borrowed_date,
        p_returning_date
    );

    RETURN log_id_sequence.CURRVAL;
END log_book_transaction;
/


-- Create the trigger to call the log_book_transaction function
CREATE OR REPLACE TRIGGER log_borrowed_books_changes
AFTER INSERT OR UPDATE ON borrowed_books
FOR EACH ROW
DECLARE
    v_txn_type VARCHAR2(10);
    logid NUMBER;
BEGIN
    IF INSERTING THEN
        v_txn_type := 'INSERT';
    ELSIF UPDATING THEN
        v_txn_type := 'UPDATE';
    END IF;

    -- Call the log_book_transaction function
    logid := log_book_transaction(
        v_txn_type,
        :NEW.b_id,
        :NEW.borrower_name,
        :NEW.borrowed_date,
        :NEW.returning_date
    );

END log_borrowed_books_changes;
/


ALTER TRIGGER log_borrowed_books_changes
ENABLE
FOLLOWS update_book_availability;

