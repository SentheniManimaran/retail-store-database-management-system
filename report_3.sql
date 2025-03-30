--  Markup for Products Sales on Weekend

CREATE OR REPLACE PROCEDURE Weekend(in_date in DATE, out_date in DATE) IS

    w_calendarDate     DATE;
    w_standardCost     NUMBER(9,2);
    w_listPrice        NUMBER(9,2);
    w_markup           NUMBER(9,2);
    w_total            NUMBER(8,2);
    w_productID        NUMBER;
    w_prodID           NUMBER;

  CURSOR weekend_cursor IS
    
    SELECT d.calendarDate,SUM(s.quantity) as soldTotal, p.productID, p.standardCost, 
            p.listPrice, ((listPrice-standardCost)/standardCost)*100 AS markup
    FROM Product_Dimension p, Sale_Facts s, Date_Dimension d
    WHERE p.productID = s.productID AND  d.dateKey = s.dateKey AND 
            d.calendarDate BETWEEN in_date AND out_date AND d.weekdayInd = 'N'
    GROUP BY d.calendarDate, p.productID, p.standardCost, p.listPrice
    ORDER BY d.calendarDate,soldTotal DESC;
      
BEGIN
    OPEN weekend_cursor;
        DBMS_OUTPUT.put_line (RPAD('__',133,'__'));
        DBMS_OUTPUT.put_line (LPAD('WEEKEND SALES INSPECTION BY PRODUCT WITH MARKUP',35));
        DBMS_OUTPUT.put_line (RPAD('_',133,'_'));
        DBMS_OUTPUT.put_line (LPAD('Date',30)||' '||LPAD('Total Quantity',22)||' '|| 
                            LPAD('ID',11) ||' '|| LPAD('Standard Cost',17) ||' '|| LPAD('List Price',13) 
                            ||' '|| LPAD('Markup Percentage(%)',23));
        DBMS_OUTPUT.put_line (RPAD('_',133,'_'));
    FETCH weekend_cursor INTO w_calendarDate, w_total, w_productID, w_standardCost, w_listPrice, w_markup;
    WHILE weekend_cursor%FOUND
    LOOP
        IF 
        w_prodID != w_productID THEN
            w_prodID := w_productID;
        END IF;
        DBMS_OUTPUT.put_line (RPAD(w_calendarDate,15)  ||' '|| RPAD(w_total,20) ||' '
                            || RPAD(w_productID,7)||' '|| RPAD(TO_CHAR(w_standardCost,'9000.99'),15) ||' '
                            ||RPAD(TO_CHAR(w_listPrice,'9000.99'),15) ||' '|| LPAD(TO_CHAR(w_markup,'900.99'),10));
        w_total := 0;
        FETCH weekend_cursor INTO w_calendarDate, w_total, w_productID, w_standardCost, w_listPrice, w_markup;
    END LOOP;
    
    DBMS_OUTPUT.put_line (RPAD('_',133,'_'));
    DBMS_OUTPUT.put_line ('TOTAL NUMBER OF PRODUCTS: '|| weekend_cursor%ROWCOUNT);
    DBMS_OUTPUT.put_line (RPAD('__',133,'__'));
    

    EXCEPTION
    WHEN no_data_found THEN
	DBMS_OUTPUT.PUT_LINE('No sales were recorded on this date range. Please enter another range.');       

END;
/