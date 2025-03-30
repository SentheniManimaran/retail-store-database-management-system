CREATE TABLE Warehouse_Dimension(
    warehouseID         NUMBER          NOT NULL,
    warehouseName       VARCHAR(20)     NOT NULL,
    address             VARCHAR(40)     NOT NULL,
    postalCode          VARCHAR(10),
    country             VARCHAR(30),
    region              VARCHAR(20),
    city                VARCHAR(20),
    state               VARCHAR(18),
    PRIMARY KEY(warehouseID)
);