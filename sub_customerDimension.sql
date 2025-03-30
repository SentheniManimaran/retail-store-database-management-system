DECLARE
    record_count      NUMBER;
    v_customerID      NUMBER;        
    v_customerName    VARCHAR(40);   
    v_address         VARCHAR(50);
    v_website         VARCHAR(40);
    v_creditLimit     NUMBER(8, 2);
    v_PIC_name        VARCHAR(35);   
    v_email           VARCHAR(50);   
    v_phone           VARCHAR(20);

    CURSOR PROD_CUST IS
    SELECT CU.customer_id, CU.name, CU.address, CU.website, CU.credit_limit, CONCAT(CONCAT(C.first_name, ' '), C.last_name), C.email, C.phone 
    FROM customers CU, contacts C
    WHERE CU.customer_id = C.customer_id;

BEGIN
    OPEN PROD_CUST;

    LOOP
        FETCH PROD_CUST INTO v_customerID, v_customerName, v_address, v_website, v_creditLimit, v_PIC_name, v_email, v_phone;
        EXIT WHEN PROD_CUST%NOTFOUND;

        -- Check whether the record existed
        SELECT COUNT(*) INTO record_count
        FROM Customer_Dimension
        WHERE customerID = v_customerID;

        -- Add in if the record does not exist
        IF record_count = 0 THEN
            INSERT INTO Customer_Dimension VALUES (v_customerID, v_customerName, v_address, v_website, v_creditLimit, v_PIC_name, v_email, v_phone);
        
        -- Update the record if the record existed
        ELSE
            UPDATE Customer_Dimension
            SET customerID = v_customerID, 
                customerName = v_customerName,
                address = v_address, 
                website = v_website, 
                creditLimit = v_creditLimit, 
                PIC_name = v_PIC_name, 
                email = v_email, 
                phone = v_phone
            WHERE customerID = v_customerID;
        END IF;
    END LOOP;
END;
/