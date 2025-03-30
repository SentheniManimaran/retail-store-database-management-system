INSERT INTO Employee_Dimension
SELECT employee_id, CONCAT(CONCAT(first_name, ' '), last_name), email, phone, job_title, hire_date, manager_id
FROM employees
WHERE employee_id BETWEEN 1 AND 70;