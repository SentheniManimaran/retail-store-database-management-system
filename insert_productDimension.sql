INSERT INTO Product_Dimension
SELECT P.product_id, P.product_name, CONCAT(CONCAT(C.category_id, ' '), C.category_name), P.description, P.standard_cost, P.list_price
FROM products P, product_categories C
WHERE P.category_id = C.category_id AND
      P.product_id BETWEEN 1 AND 200;