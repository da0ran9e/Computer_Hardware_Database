--change file permission if needed
--chmod +r categories.csv 
--chmod +r countries.csv 
--chmod +r items.txt
--chmod +r locations.csv 
--chmod +r warehouse.csv 
--chmod +r inventory.csv 

\COPY category(category_id, category_name) FROM 'categories.csv' CSV HEADER DELIMITER ',';
--COPY 4
\COPY country(country_id, region_id, country_name) FROM 'countries.csv' CSV HEADER DELIMITER ',';
--COPY 6
\COPY item(category_id, product_id, product_name, description, description_1, description_2, description_3, description_4, standard_cost, list_price) FROM 'item.txt' WITH DELIMITER E'\t'; 
--COPY 208
\COPY location(country_id, location_id, address, postal_code, city, state)FROM 'locations.csv' CSV HEADER DELIMITER ',';
--COPY 9
\COPY warehouse(location_id, warehouse_id, warehouse_name) FROM 'warehouse.csv' CSV HEADER DELIMITER ',';
--COPY 9
\COPY inventory(product_id, warehouse_id, quantity)FROM 'inventory.csv' CSV HEADER DELIMITER ','; 
--COPY 1112