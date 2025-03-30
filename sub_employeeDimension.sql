DECLARE
    record_count      NUMBER;
    v_employeeID      NUMBER;         
    v_employeeName    VARCHAR(40); 
    v_email           VARCHAR(30);    
    v_phone           VARCHAR(20);    
    v_jobTitle        VARCHAR(35);    
    v_hireDate        DATE;           
    v_managerID       NUMBER;

    CURSOR PROD_EMP IS
    SELECT employee_id, CONCAT(CONCAT(first_name, ' '), last_name), email, phone, job_title, hire_date, manager_id
    FROM employees;

BEGIN
    OPEN PROD_EMP;

    LOOP
        FETCH PROD_EMP INTO v_employeeID, v_employeeName, v_email, v_phone, v_jobTitle, v_hireDate, v_managerID;
        EXIT WHEN PROD_EMP%NOTFOUND;

        -- Check whether the record existed
        SELECT COUNT(*) INTO record_count
        FROM Employee_Dimension
        WHERE employeeID = v_employeeID;

        -- Add in if the record does not exist
        IF record_count = 0 THEN
            INSERT INTO Employee_Dimension VALUES (v_employeeID, v_employeeName, v_email, v_phone, v_jobTitle, v_hireDate, v_managerID);
        
        -- Update the record if the record existed
        ELSE
            UPDATE Employee_Dimension
            SET employeeID = v_employeeID, 
                employeeName = v_employeeName, 
                email = v_email, 
                phone = v_phone, 
                jobTitle = v_jobTitle, 
                hireDate = v_hireDate, 
                managerID = v_managerID
            WHERE employeeID = v_employeeID;
        END IF;
    END LOOP;
END;
/