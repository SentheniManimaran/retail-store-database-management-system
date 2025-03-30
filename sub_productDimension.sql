DECLARE
    record_count          NUMBER;
    v_productID           NUMBER;         
    v_productName         VARCHAR(50);
    v_category            VARCHAR(20);
    v_description         VARCHAR(80);
    v_standardCost        NUMBER(9,2);
    v_listPrice           NUMBER(9,2);

    CURSOR PROD_PRD IS
    SELECT P.product_id, P.product_name, CONCAT(CONCAT(C.category_id, ' '), C.category_name), P.description, P.standard_cost, P.list_price
    FROM products P, product_categories C
    WHERE P.category_id = C.category_id;

BEGIN
    OPEN PROD_PRD;

    LOOP
        FETCH PROD_PRD INTO v_productID, v_productName, v_category, v_description, v_standardCost, v_listPrice;
        EXIT WHEN PROD_PRD%NOTFOUND;

        -- Check whether the record existed
        SELECT COUNT(*) INTO record_count
        FROM Product_Dimension
        WHERE productID = v_productID;

        -- Add in if the record does not exist
        IF record_count = 0 THEN
            INSERT INTO Product_Dimension VALUES (v_productID, v_productName, v_category, v_description, v_standardCost, v_listPrice);
        
        -- Update the record if the record existed
        ELSE
            UPDATE Product_Dimension
            SET productID = v_productID, 
                productName = v_productName, 
                category = v_category, 
                description = v_description, 
                standardCost = v_standardCost, 
                listPrice = v_listPrice
            WHERE productID = v_productID;
        END IF;
    END LOOP;
END;
/