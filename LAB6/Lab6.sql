CREATE OR REPLACE PROCEDURE nearest_primes(n NUMBER) IS
    less_prime NUMBER;
    greater_prime NUMBER;
    foundL BOOLEAN := FALSE;
    foundG BOOLEAN := FALSE;

    FUNCTION is_prime(num IN NUMBER) RETURN BOOLEAN IS
        is_prime BOOLEAN := TRUE;
    BEGIN
        IF num <= 1 THEN
            is_prime := FALSE;
        ELSIF num <= 3 THEN
            is_prime := TRUE;
        ELSIF num MOD 2 = 0 OR num MOD 3 = 0 THEN
            is_prime := FALSE;
        ELSE
            FOR i IN 5..SQRT(num) LOOP
                IF num MOD i = 0 OR num MOD (i + 2) = 0 THEN
                    is_prime := FALSE;
                    EXIT;
                END IF;
            END LOOP;
        END IF;
        RETURN is_prime;
    END is_prime;

BEGIN
    IF n <= 1 THEN
        DBMS_OUTPUT.PUT_LINE('No prime numbers less than or greater than ' || n);
        RETURN;
    END IF;

    less_prime := n - 1;
    greater_prime := n + 1;

    WHILE (NOT foundL OR NOT foundG) AND (less_prime >= 2 OR greater_prime >= 2) LOOP
        IF is_prime(less_prime) AND NOT foundL THEN
            foundL := TRUE;
        ELSIF foundL THEN
            less_prime := less_prime;
        ELSE
            less_prime := less_prime - 1;
        END IF;

        IF is_prime(greater_prime) AND NOT foundG THEN
            foundG := TRUE;
        ELSIF foundG THEN
            greater_prime := greater_prime;
        ELSE 
            greater_prime := greater_prime + 1;
        END IF;

        -- Exit the loop if both conditions are met
        IF foundL AND foundG THEN
            EXIT;
        END IF;
    END LOOP;

    IF foundG THEN
        DBMS_OUTPUT.PUT_LINE('Nearest prime less than ' || n || ' is ' || less_prime);
    END IF;

    IF foundL THEN
        DBMS_OUTPUT.PUT_LINE('Nearest prime greater than ' || n || ' is ' || greater_prime);
    END IF;
    
    IF NOT foundL AND NOT foundG THEN
        DBMS_OUTPUT.PUT_LINE('No prime number found in either direction for ' || n);
    END IF;
END nearest_primes;
/




ACCEPT n_input PROMPT 'Enter the number : ';
DECLARE
   n_input NUMBER;
BEGIN
  n_input := &ninput;
  find_nearest_primes(n_input);
END;
/


