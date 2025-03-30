CREATE TABLE Sale_Facts(
    uniqueID        NUMBER          NOT NULL,
    dateKey         NUMBER          NOT NULL,
    orderDate       DATE            NOT NULL,
    orderID         NUMBER          NOT NULL,
    customerID      NUMBER          NOT NULL, 
    employeeID      NUMBER          NOT NULL,
    productID       NUMBER          NOT NULL,
    quantity        NUMBER(8, 2)    NOT NULL,
    unitPrice       NUMBER(8, 2)    NOT NULL,
    lineTotal       NUMBER(8, 2)    NOT NULL,
    PRIMARY KEY (uniqueID, dateKey, productID, customerID, employeeID),
    FOREIGN KEY (dateKey) REFERENCES Date_Dimension (dateKey),
    FOREIGN KEY (productID) REFERENCES Product_Dimension (productID),
    FOREIGN KEY (customerID) REFERENCES Customer_Dimension (customerID),
    FOREIGN KEY (employeeID) REFERENCES Employee_Dimension (employeeID)
);
