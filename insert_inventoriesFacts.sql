DROP SEQUENCE inventories_seq;
CREATE SEQUENCE inventories_seq 
START WITH 90001
INCREMENT BY 1;

INSERT INTO Inventories_Facts
SELECT inventories_seq.nextval, W.warehouse_id, P.product_id, I.quantity
FROM warehouses W, products P, inventories I, Product_Dimension PD, Warehouse_Dimension WD
WHERE W.warehouse_id = I.warehouse_id AND
      I.product_id = P.product_id AND
      W.warehouse_id = WD.warehouseID AND 
      P.product_id = PD.productID;