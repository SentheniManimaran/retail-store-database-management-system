CREATE TABLE Inventories_Facts(
    uniqueID        NUMBER          NOT NULL,
    warehouseID     NUMBER          NOT NULL,
    productID       NUMBER          NOT NULL,
    quantity        NUMBER(8, 2)    NOT NULL,
    PRIMARY KEY (uniqueID, warehouseID, productID),
    FOREIGN KEY (warehouseID) REFERENCES Warehouse_Dimension (warehouseID),
    FOREIGN KEY (productID) REFERENCES Product_Dimension (productID)
);
