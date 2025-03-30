-- Sales by Cred Limit
CREATE OR REPLACE PROCEDURE CredLim(in_date in DATE, out_date in DATE) IS

    c_calendarDate     DATE;
    c_customerID       NUMBER;
    c_customerName     VARCHAR(40);
    c_creditLimit      NUMBER(8, 2);
    c_quantity         NUMBER(8, 2);
    c_productID        NUMBER;
    c_revenue          NUMBER;
    c_custID           NUMBER;

  CURSOR cred_cursor IS
    
    SELECT d.calendarDate, c.customerID, c.customerName, c.creditLimit, SUM(s.lineTotal) AS revenue 
    FROM Customer_Dimension c, Sale_Facts s, Date_Dimension d
    WHERE c.customerID = s.customerID AND  d.dateKey = s.dateKey AND d.calendarDate BETWEEN in_date AND out_date
    GROUP BY d.calendarDate, c.customerID, c.customerName, c.creditLimit
    ORDER BY revenue DESC;
      
BEGIN
    OPEN cred_cursor;
        DBMS_OUTPUT.put_line (RPAD('__',133,'__'));
        DBMS_OUTPUT.put_line (LPAD('CREDIT LIMIT INSPECTION',35));
        DBMS_OUTPUT.put_line (RPAD('_',133,'_'));
        DBMS_OUTPUT.put_line (RPAD('Date',15)||' '|| RPAD('ID',6) ||' '|| RPAD('Customer Name',37) ||' '
                            || RPAD('Credit Limit',15) ||' '|| RPAD('Total Revenue',25));
        DBMS_OUTPUT.put_line (RPAD('_',133,'_'));
    FETCH cred_cursor INTO c_calendarDate, c_customerID, c_customerName, c_creditLimit, c_revenue;
    WHILE cred_cursor%FOUND
    LOOP
        IF 
        c_custID != c_customerID THEN
            c_custID := c_customerID;
        END IF;
        DBMS_OUTPUT.put_line (RPAD(c_calendarDate,15) ||' '|| RPAD(c_customerID,6) ||' '
                || RPAD(c_customerName,35) ||' '|| RPAD(TO_CHAR(c_creditLimit,'9999999999'),15) ||' '|| RPAD(TO_CHAR(c_revenue,'9999999999.99'),25));
        c_revenue := 0;
        FETCH cred_cursor INTO c_calendarDate, c_customerID, c_customerName, c_creditLimit, c_revenue;
    END LOOP;
    
    DBMS_OUTPUT.put_line (RPAD('_',133,'_'));
    DBMS_OUTPUT.put_line ('TOTAL NUMBER OF CUSTOMERS: '|| cred_cursor%ROWCOUNT);
    DBMS_OUTPUT.put_line (RPAD('_',133,'_'));
    

    EXCEPTION
    WHEN no_data_found THEN
	DBMS_OUTPUT.PUT_LINE('No sales were recorded on this date range. Please enter another range.');       

END;
/