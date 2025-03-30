CREATE TABLE Employee_Dimension(
    employeeID      NUMBER         NOT NULL,
    employeeName    VARCHAR(40)    NOT NULL,
    email           VARCHAR(30)    NOT NULL,
    phone           VARCHAR(20)    NOT NULL,
    jobTitle        VARCHAR(35)    NOT NULL,
    hireDate        DATE           NOT NULL,
    managerID       NUMBER,
    PRIMARY KEY(employeeID)
);
