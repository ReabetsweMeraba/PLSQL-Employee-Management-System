# PLSQL Employee Management System

This PL/SQL project demonstrates a simple yet functional employee management system. It performs essential operations like creating a table, inserting records, retrieving data using cursors, and organizing business logic using procedures and packages.

---

## 🧾 Features

- ✅ Create and drop the `employees` table dynamically
- ✅ Insert employee data (manual and via stored procedures)
- ✅ Display employee names using explicit cursors
- ✅ Calculate annual salary using a package (function + procedure)
- ✅ Update employee salaries
- ✅ Delete employee records
- ✅ Increase all employee salaries using cursors

---

## 📁 Structure

- `CREATE TABLE` block with exception-safe dropping
- `INSERT` block for initial seed data
- Cursor for displaying employee names
- Package `emp_pkg` with:
  - `get_annual_salary(emp_id)` function
  - `show_annual_salary(emp_id)` procedure
- Standalone procedures:
  - `Insert_employee`
  - `Update_Employee_information`
  - `Delete_employee_information`
  - `add_employee` (using cursor to reinsert data)
  - `increase_salary` (bulk salary update via cursor)

---

## 🚀 How to Run

1. Use an Oracle-compatible environment like:
   - Oracle SQL Developer
   - Oracle Live SQL
   - SQL*Plus

2. Copy and run the code blocks in order:
   - Table creation
   - Data insertion
   - Cursor block
   - Package spec + body
   - Procedures
   - Procedure calls

3. Use `SET SERVEROUTPUT ON;` to see `DBMS_OUTPUT.PUT_LINE` results.

---

## 🧪 Sample Execution

```sql
EXECUTE Insert_employee(4, 'Reabetswe', 40000);
BEGIN
  emp_pkg.show_annual_salary(2);
END;
