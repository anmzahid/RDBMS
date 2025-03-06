SET SERVEROUTPUT ON;
DECLARE 
crt_yr NUMBER;
is_leap_year VARCHAR2(10);
nxt_yr NUMBER;
prev_yr NUMBER;
BEGIN
 SELECT TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) INTO crt_yr FROM DUAL;
 IF MOD(crt_yr,4) =0 AND MOD(crt_yr,100) !=0 OR
  MOD(crt_yr,400)=0 THEN
  is_leap_year :='YES';
  ELSE
   is_leap_year :='NO';
  END IF;

  prev_yr :=crt_yr - MOD(crt_yr,4);
  WHILE MOD(prev_yr,4) !=0 OR MOD(prev_yr,100) =0 AND
  MOD(prev_yr,400) !=0 LOOP 
  prev_yr :=prev_yr -4;
  END LOOP;

  nxt_yr := crt_yr +(4-MOD(crt_yr,4));
  WHILE MOD(nxt_yr,4) !=0 OR MOD(nxt_yr,100) =0 AND
  MOD(nxt_yr,400) !=0 LOOP
  nxt_yr :=nxt_yr+4;
  END LOOP;

 DBMS_OUTPUT.PUT_LINE('Is the current year (' || crt_year || ') a leap year? ' || is_leap_year);
   DBMS_OUTPUT.PUT_LINE('Immediate previous leap year: ' || prev_yr);
   DBMS_OUTPUT.PUT_LINE('Immediate next leap year: ' || nxt_yr);
END;
/



--Task B--

CREATE OR REPLACE FUNCTION times_table(n IN NUMBER, iter IN NUMBER)
RETURN VARCHAR2 AS
   result VARCHAR2(4000);
BEGIN
   FOR i IN 1..n LOOP
      result := result || 'Times Table for ' || i || ':' || CHR(10);
      FOR j IN 1..iter LOOP
         result := result || i || ' x ' || j || ' = ' || (i * j) || CHR(10);
      END LOOP;
      result := result || CHR(10);
   END LOOP;
   RETURN result;
END times_table;
/

ACCEPT n_input PROMPT 'Enter the number of times tables to print: ';
ACCEPT iter_input PROMPT 'Enter the range for each times table: ';

DECLARE
   table_result VARCHAR2(4000);
   n_input NUMBER;
   iter_input NUMBER;

BEGIN
   n_input := &ninput;
   iter_input := &iterinput;
   table_result := times_table(n_input, iter_input);
   DBMS_OUTPUT.PUT_LINE('Times Tables:' || CHR(10) || table_result);
END;
/
