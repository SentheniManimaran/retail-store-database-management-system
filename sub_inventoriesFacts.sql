DECLARE
    record_count        NUMBER;
    maxSeq              NUMBER;
    v_seq               NUMBER;
    v_warehouseID       NUMBER;
    v_productID         NUMBER;
    v_quantity          NUMBER;

    CURSOR PROD_WHS_FACTS IS
    SELECT W.warehouse_id, P.product_id, I.quantity
    FROM warehouses W, products P, inventories I, Product_Dimension PD, Warehouse_Dimension WD
    WHERE W.warehouse_id = I.warehouse_id AND
        I.product_id = P.product_id AND
        W.warehouse_id = WD.warehouseID AND 
        P.product_id = PD.productID;

BEGIN
    OPEN PROD_WHS_FACTS;
    
    LOOP
        FETCH PROD_WHS_FACTS INTO v_warehouseID, v_productID, v_quantity;
        EXIT WHEN PROD_WHS_FACTS%NOTFOUND;

        -- Select the last number of the index
        SELECT MAX(uniqueID) INTO maxSeq
        FROM Inventories_Facts;

        -- Check whether the record existed
        SELECT COUNT(*) INTO record_count
        FROM Inventories_Facts
        WHERE warehouseID = v_warehouseID AND
              productID = v_productID;
    
        IF record_count = 0 THEN
            maxSeq := maxSeq + 1;
            INSERT INTO Inventories_Facts VALUES(maxSeq, 
                                                 v_warehouseID,
                                                 v_productID,
                                                 v_quantity
            );

        ELSE
            UPDATE Inventories_Facts
            SET warehouseID = v_warehouseID,
                productID = v_productID,
                quantity = v_quantity
            WHERE warehouseID = v_warehouseID AND
                  productID = v_productID;
        END IF;
    END LOOP;
    CLOSE PROD_WHS_FACTS;  
END;
/