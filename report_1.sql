-- Discount by Product Category
CREATE OR REPLACE PROCEDURE Discount(in_category IN VARCHAR) IS

    d_productID      NUMBER;  
    d_standardCost   NUMBER(9,2);
    d_listPrice      NUMBER(9,2);
    d_difference     NUMBER(9,2);
    d_discount       NUMBER(9,2);

  CURSOR discount_cursor IS
    
    SELECT DISTINCT productID,standardCost, listPrice, listPrice-standardCost AS difference, 
                        ((listPrice-standardCost)/listPrice)*100 AS discount
    from Product_Dimension
    WHERE category = in_category
    GROUP BY productID, standardCost, listPrice
    ORDER BY productID;
      
BEGIN
    OPEN discount_cursor;
        DBMS_OUTPUT.put_line (RPAD('__',133,'__'));
        DBMS_OUTPUT.put_line ('DISCOUNT PERCENTAGE BY PRODUCT CATEGORY');
        DBMS_OUTPUT.put_line (RPAD('_',133,'_'));
        DBMS_OUTPUT.put_line (RPAD('ID',6) ||' '|| RPAD('Standard Cost($)',20) ||' '|| RPAD('List Price($)',15) 
                                ||' '|| RPAD('Discount Amount($)',20) ||' '|| RPAD('Discount Percentage(%)',25));
        DBMS_OUTPUT.put_line (RPAD('_',133,'_'));
    FETCH discount_cursor INTO d_productID, d_standardCost, d_listPrice, d_difference,d_discount;
    WHILE discount_cursor%FOUND
    LOOP
        DBMS_OUTPUT.put_line (RPAD(d_productID,6) ||' '|| RPAD(TO_CHAR(d_standardCost,'9000.99'),20) ||' '
                            || RPAD(TO_CHAR(d_listPrice,'9000.99'),15) ||' '|| RPAD(TO_CHAR(d_difference,'9000.99'),20) ||' '
                            || RPAD(TO_CHAR(d_discount,'900.99'),25));
        FETCH discount_cursor INTO d_productID, d_standardCost, d_listPrice, d_difference,d_discount;
    END LOOP;
    
    DBMS_OUTPUT.put_line (RPAD('_',133,'_'));
    DBMS_OUTPUT.put_line ('TOTAL NUMBER OF PRODUCTS: '|| discount_cursor%ROWCOUNT);
    DBMS_OUTPUT.put_line (RPAD('_',133,'_'));
    
    EXCEPTION
    WHEN no_data_found THEN
	DBMS_OUTPUT.PUT_LINE('The entered category does not exist. Please enter another category');       

END;
/