
-- 1. Create the table
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE employees';
EXCEPTION
    WHEN OTHERS THEN NULL; -- ignore if table doesn't exist
END;
/

CREATE TABLE employees (
    emp_id NUMBER PRIMARY KEY,
    name VARCHAR2(50),
    salary NUMBER
);
/

-- 2. Insert sample data
BEGIN
    INSERT INTO employees VALUES (1, 'Alice', 30000);
    INSERT INTO employees VALUES (2, 'Bob', 40000);
    INSERT INTO employees VALUES (3, 'Cleo', 50000);
    COMMIT;
END;
/

-- 3. Cursor example: Display employee names
DECLARE
    CURSOR emp_cursor IS
        SELECT name FROM employees;
    emp_name employees.name%TYPE;
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- Employee List ---');
    OPEN emp_cursor;
    LOOP
        FETCH emp_cursor INTO emp_name;
        EXIT WHEN emp_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Employee: ' || emp_name);
    END LOOP;
    CLOSE emp_cursor;
END;
/

-- 4. Package spec
CREATE OR REPLACE PACKAGE emp_pkg AS
    FUNCTION get_annual_salary(emp_id IN NUMBER) RETURN NUMBER;
    PROCEDURE show_annual_salary(emp_id IN NUMBER);
END emp_pkg;
/

-- 5. Package body
CREATE OR REPLACE PACKAGE BODY emp_pkg AS

    FUNCTION get_annual_salary(emp_id IN NUMBER) RETURN NUMBER IS
        monthly_salary employees.salary%TYPE;
    BEGIN
        SELECT salary INTO monthly_salary
        FROM employees
        WHERE emp_id = emp_pkg.get_annual_salary.emp_id;
        RETURN monthly_salary * 12;
    END;

    PROCEDURE show_annual_salary(emp_id IN NUMBER) IS
        annual_salary NUMBER;
    BEGIN
        annual_salary := get_annual_salary(emp_id);
        DBMS_OUTPUT.PUT_LINE('Annual Salary for Employee ID ' || emp_id || ' is: ' || annual_salary);
    END;

END emp_pkg;
/

-- 6. Call the procedure from the package
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- Annual Salary ---');
    emp_pkg.show_annual_salary(2);
END;
/



CREATE OR REPLACE PROCEDURE Insert_employee(emp_id IN NUMBER ,name IN VARCHAR2 ,salary IN NUMBER) IS

BEGIN 

INSERT INTO employees (emp_id,name,salary)
VALUES(emp_id,name,salary);

DBMS_OUTPUT.PUT_LINE('Employee ID:'|| emp_id);
DBMS_OUTPUT.PUT_LINE('Employee Name:'|| name);
DBMS_OUTPUT.PUT_LINE('Employee salary:'|| salary);
COMMIT;
END Insert_employee;
/

EXECUTE Insert_employee(4,'Reabetswe',40000);

BEGIN
Insert_employee(5,'Mulweli',50000);
END Insert_employee;
/

CREATE OR REPLACE PROCEDURE Update_Employee_information (emp_id IN NUMBER,salary IN NUMBER) IS
BEGIN
UPDATE employees
SET salary = salary 
WHERE emp_id =Update_Employee_information.emp_id;
COMMIT;
END Update_Employee_information;

/


CREATE OR REPLACE PROCEDURE Delete_employee_information(emp_id IN NUMBER) IS

BEGIN

DELETE employees
WHERE emp_id=Delete_employee_information.emp_id;

COMMIT;
END Delete_employee_information;
/
CREATE OR REPLACE PROCEDURE add_employee IS
CURSOR employer_cursor IS 
SELECT emp_id,name,salary FROM employees;



v_emp_id    employees.emp_id%TYPE;
v_name    employees.name%TYPE;
v_salary     employees.salary%TYPE;

BEGIN
OPEN employer_cursor;

LOOP
FETCH employer_cursor INTO v_emp_id,v_name,v_salary;
EXIT WHEN employer_cursor%NOTFOUND;

INSERT INTO employees(emp_id,name,salary)
VALUES(v_emp_id,v_name,v_salary);
END LOOP;

CLOSE employer_cursor;
COMMIT;
END add_employee;
/


CREATE OR REPLACE PROCEDURE increase_salary IS 
CURSOR employer_cursor IS
SELECT emp_id ,salary FROM employees;

v_emp_id employees.emp_id%TYPE;
v_salary employees.salary%TYPE;

amount NUMBER:=430;
BEGIN

OPEN employer_cursor;

LOOP
FETCH employer_cursor INTO v_emp_id,v_salary;
EXIT WHEN employer_cursor%NOTFOUND;


UPDATE employees
SET salary=v_salary+amount
WHERE emp_id=v_emp_id;

END LOOP;
CLOSE employer_cursor;

COMMIT;
end increase_salary;
/
show errors;

