INSERT INTO Customer_Dimension
SELECT CU.customer_id, CU.name, CU.address, CU.website, CU.credit_limit, CONCAT(CONCAT(C.first_name, ' '), C.last_name), C.email, C.phone 
FROM customers CU, contacts C
WHERE CU.customer_id = C.customer_id AND
      CU.customer_id BETWEEN 1 AND 200;