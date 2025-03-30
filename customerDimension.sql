CREATE TABLE Customer_Dimension(
    customerID      NUMBER         NOT NULL,
    customerName    VARCHAR(40)    NOT NULL,
    address         VARCHAR(50),
    website         VARCHAR(40),
    creditLimit    NUMBER(8, 2),
    PIC_name        VARCHAR(35)    NOT NULL,  
    email           VARCHAR(50)    NOT NULL,
    phone           VARCHAR(20),
    PRIMARY KEY(customerID)
);