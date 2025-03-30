DROP SEQUENCE sales_seq;
CREATE SEQUENCE sales_seq 
START WITH 80001
INCREMENT BY 1;

DECLARE
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
    
    INSERT INTO Sale_Facts VALUES(sales_seq.nextval, 
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

    END LOOP;
    CLOSE PROD_SALE_FACTS;  
END;
/
