

CREATE TABLE Product_Dimension(
    productID           NUMBER          NOT NULL,
    productName         VARCHAR(50)     NOT NULL,
    category            VARCHAR(20)     NOT NULL,
    description         VARCHAR(80),
    standardCost        NUMBER(9,2),
    listPrice           NUMBER(9,2),
    PRIMARY KEY(productID)
);