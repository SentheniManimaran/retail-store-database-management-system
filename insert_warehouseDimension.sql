INSERT INTO Warehouse_Dimension
SELECT W.warehouse_id, W.warehouse_name, L.address, L.postal_code, CONCAT(CONCAT(CONCAT(C.country_name, ' ('), C.country_id), ')'), R.region_name, L.city, L.state
FROM warehouses W, locations L, countries C, regions R
WHERE W.location_id = L.location_id AND
      L.country_id = C.country_id AND
      C.region_id = R.region_id AND
      W.warehouse_id BETWEEN 1 AND 5;