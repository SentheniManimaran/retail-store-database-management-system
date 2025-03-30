DECLARE
    record_count        NUMBER;
    maxSeq              NUMBER;
    V_seq               NUMBER;
    V_dateKey           NUMBER;
    V_order_date        DATE;
    V_order_id          NUMBER; 
    V_customer_id       NUMBER; 
    V_employee_id       NUMBER;  
    V_product_id        NUMBER;
    V_quantity          NUMBER(8, 2);
    V_unit_price        NUMBER(8, 2);
    V_lineTotal         NUMBER(8, 2);

    CURSOR PROD_SALE_FACTS IS
    SELECT DISTINCT * FROM(
        SELECT D.dateKey, O.order_date, O.order_id, C.customer_id, E.employee_id, P.product_id, OI.quantity, OI.unit_price, (OI.quantity * OI.unit_price) AS lineTotal
        FROM Date_Dimension D, orders O, customers C, employees E, order_items OI, products P, inventories I, Product_Dimension PD, Employee_Dimension ED, Customer_Dimension CD
        WHERE D.calendarDate = O.order_date AND
            C.customer_id = O.customer_id AND
            E.employee_id = O.salesman_id AND
            O.order_id = OI.order_id AND
            P.product_id = OI.product_id AND 
            P.product_id = I.product_id AND
            P.product_id = PD.productID AND
            C.customer_id = CD.customerID AND 
            E.employee_id = ED.employeeID
    );

BEGIN
    OPEN PROD_SALE_FACTS;
    
    LOOP
        FETCH PROD_SALE_FACTS INTO V_dateKey, V_order_date, V_order_id, V_customer_id, V_employee_id, V_product_id, V_quantity, V_unit_price, V_lineTotal;
        EXIT WHEN PROD_SALE_FACTS%NOTFOUND;

        -- Select the last number of the index
        SELECT MAX(uniqueID) INTO maxSeq
        FROM Sale_Facts;

        -- Check whether the record existed
        SELECT COUNT(*) INTO record_count
        FROM Sale_Facts
        WHERE dateKey = V_dateKey AND
            productID = V_product_id AND
            customerID = V_customer_id AND
            employeeID = V_employee_id;
    
        IF record_count = 0 THEN
            maxSeq := maxSeq + 1;
            INSERT INTO Sale_Facts VALUES(maxSeq, 
                                          V_dateKey, 
                                          V_order_date, 
                                          V_order_id, 
                                          V_customer_id, 
                                          V_employee_id, 
                                          V_product_id, 
                                          V_quantity, 
                                          V_unit_price, 
                                          V_lineTotal
            );

        ELSE
            UPDATE Sale_Facts
            SET dateKey = V_dateKey, 
                orderDate = V_order_date, 
                orderID = V_order_id, 
                customerID = V_customer_id, 
                employeeID = V_employee_id, 
                productID = V_product_id, 
                quantity = V_quantity, 
                unitPrice = V_unit_price, 
                lineTotal = V_lineTotal
            WHERE dateKey = V_dateKey AND
                productID = V_product_id AND
                customerID = V_customer_id AND
                employeeID = V_employee_id;
        END IF;
    END LOOP;
    CLOSE PROD_SALE_FACTS;  
END;
/
