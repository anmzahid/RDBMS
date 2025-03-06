SET SERVEROUTPUT ON;

VARIABLE input_string VARCHAR2(100);
VARIABLE modified_string VARCHAR2(200);
VARIABLE reversed_string VARCHAR2(100);

-- Set the input string directly
EXEC :input_string := 'tawat';

DECLARE
    i NUMBER;
BEGIN
    :modified_string := '';
    IF :input_string IS NOT NULL THEN
        FOR i IN 1..LENGTH(:input_string) LOOP
            :modified_string := :modified_string || SUBSTR(:input_string, i, 1) || ' ';
        END LOOP;
        :modified_string := RTRIM(:modified_string, ' ');
    END IF;
END;
/

DECLARE
    i NUMBER;
    reversed_input VARCHAR2(100);
BEGIN
    IF :input_string IS NOT NULL THEN
        reversed_input := '';
        FOR i IN REVERSE 1..LENGTH(:input_string) LOOP
            reversed_input := reversed_input || SUBSTR(:input_string, i, 1);
        END LOOP;
    ELSE
        reversed_input := NULL;
    END IF;

    IF :input_string = reversed_input THEN
        DBMS_OUTPUT.PUT_LINE('Yes, it is a palindrome.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('No, it is not a palindrome.');
    END IF;

    DBMS_OUTPUT.PUT_LINE('Modified String: ' || :modified_string);
END;
/
