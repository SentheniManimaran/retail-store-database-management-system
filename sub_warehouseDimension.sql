DECLARE
    record_count          NUMBER;
    v_warehouseID         NUMBER;         
    v_warehouseName       VARCHAR(20); 
    v_address             VARCHAR(40);   
    v_postalCode          VARCHAR(10);
    v_country             VARCHAR(30);
    v_region              VARCHAR(20);
    v_city                VARCHAR(20);
    v_state               VARCHAR(18);

    CURSOR PROD_WHS IS
    SELECT W.warehouse_id, W.warehouse_name, L.address, L.postal_code, CONCAT(CONCAT(CONCAT(C.country_name, ' ('), C.country_id), ')'), R.region_name, L.city, L.state
    FROM warehouses W, locations L, countries C, regions R
    WHERE W.location_id = L.location_id AND
          L.country_id = C.country_id AND
          C.region_id = R.region_id;

BEGIN
    OPEN PROD_WHS;

    LOOP
        FETCH PROD_WHS INTO v_warehouseID, v_warehouseName, v_address, v_postalCode, v_country, v_region, v_city, v_state;
        EXIT WHEN PROD_WHS%NOTFOUND;

        -- Check whether the record existed
        SELECT COUNT(*) INTO record_count
        FROM Warehouse_Dimension
        WHERE warehouseID = v_warehouseID;

        -- Add in if the record does not exist
        IF record_count = 0 THEN
            INSERT INTO Warehouse_Dimension VALUES (v_warehouseID, v_warehouseName, v_address, v_postalCode, v_country, v_region, v_city, v_state);
        
        -- Update the record if the record existed
        ELSE
            UPDATE Warehouse_Dimension
            SET warehouseID = v_warehouseID, 
                warehouseName = v_warehouseName, 
                address = v_address, 
                postalCode = v_postalCode, 
                country = v_country, 
                region = v_region, 
                city = v_city, 
                state = v_state
            WHERE warehouseID = v_warehouseID;
        END IF;
    END LOOP;
END;
/