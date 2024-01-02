
-- Function to get the first 10 items list for UI
CREATE OR REPLACE FUNCTION get_first_10_items()
RETURNS TABLE (
    product_id INT, product_name VARCHAR(100), category_name VARCHAR(50),
    concatenated_description TEXT, -- each description can be 150 characters
    standard_cost NUMERIC(6,2), list_price NUMERIC(6,2)
)
AS $$
BEGIN
    RETURN QUERY
    SELECT
        i.product_id,
        i.product_name,
		c.category_name,
        CONCAT(i.description, ' ', i.description_1, ' ', i.description_2, ' ', i.description_3, ' ', i.description_4) AS concatenated_description,
        i.standard_cost, i.list_price
    FROM
        item i
    INNER JOIN
        category c ON i.category_id = c.category_id
    ORDER BY
        i.product_id
    LIMIT 10;

    RETURN;
END;
$$ LANGUAGE plpgsql;
--SELECT * FROM get_first_10_items();

-- Function to get the all items
CREATE OR REPLACE FUNCTION get_items()
RETURNS TABLE (
    product_id INT, product_name VARCHAR(100), category_name VARCHAR(50),
    concatenated_description TEXT, -- each description can be 150 characters
    standard_cost NUMERIC(6,2), list_price NUMERIC(6,2)
)
AS $$
BEGIN
    RETURN QUERY
    SELECT
        i.product_id,
        i.product_name,
		c.category_name,
        CONCAT(i.description, ' ', i.description_1, ' ', i.description_2, ' ', i.description_3, ' ', i.description_4) AS concatenated_description,
        i.standard_cost, i.list_price
    FROM
        item i
    INNER JOIN
        category c ON i.category_id = c.category_id
    ORDER BY
        i.product_id;

    RETURN;
END;
$$ LANGUAGE plpgsql;
--SELECT * FROM get_items();

-- Function to filter by category
CREATE OR REPLACE FUNCTION get_items_by_category(in_category_name VARCHAR(50))
RETURNS TABLE (
    product_id INT,
    product_name VARCHAR(100),
    category_name VARCHAR(50),
    concatenated_description TEXT,
    standard_cost NUMERIC(6,2),
    list_price NUMERIC(6,2)
)
AS $$
BEGIN
    RETURN QUERY
    SELECT
        i.product_id,
        i.product_name,
        c.category_name,
        CONCAT(i.description, ' ', i.description_1, ' ', i.description_2, ' ', i.description_3, ' ', i.description_4) AS concatenated_description,
        i.standard_cost,
        i.list_price
    FROM
        item i
    INNER JOIN
        category c ON i.category_id = c.category_id
    WHERE
        c.category_name = in_category_name
    ORDER BY
        i.product_id;
END;
$$ LANGUAGE plpgsql;
-- SELECT * FROM get_items_by_category('CPU');

-- Function to filter items by country
CREATE OR REPLACE FUNCTION filter_items_by_country(in_country_id VARCHAR(2))
RETURNS TABLE (
    product_id INT,
    product_name VARCHAR(100),
    category_name VARCHAR(50),
    concatenated_description TEXT,
    standard_cost NUMERIC(6,2),
    list_price NUMERIC(6,2)
)
AS $$
BEGIN
    RETURN QUERY
    SELECT
        i.product_id,
        i.product_name,
        c.category_name,
        CONCAT(i.description, ' ', i.description_1, ' ', i.description_2, ' ', i.description_3, ' ', i.description_4) AS concatenated_description,
        i.standard_cost,
        i.list_price
    FROM
        item i
    INNER JOIN
        category c ON i.category_id = c.category_id
    INNER JOIN
        inventory inv ON i.product_id = inv.product_id
    INNER JOIN
        warehouse w ON inv.warehouse_id = w.warehouse_id
    INNER JOIN
        location l ON w.location_id = l.location_id
    WHERE
        l.country_id = in_country_id;
END;
$$ LANGUAGE plpgsql;
-- SELECT * FROM filter_items_by_country('US');


-- Function to filter items by price range
CREATE OR REPLACE FUNCTION filter_items_by_price_range(
    in_min_price NUMERIC(6,2),
    in_max_price NUMERIC(6,2)
)
RETURNS TABLE (
    product_id INT,
    product_name VARCHAR(100),
    category_name VARCHAR(50),
    concatenated_description TEXT,
    standard_cost NUMERIC(6,2),
    list_price NUMERIC(6,2)
)
AS $$
BEGIN
    RETURN QUERY
    SELECT
        i.product_id,
        i.product_name,
        c.category_name,
        CONCAT(i.description, ' ', i.description_1, ' ', i.description_2, ' ', i.description_3, ' ', i.description_4) AS concatenated_description,
        i.standard_cost,
        i.list_price
    FROM
        item i
    INNER JOIN
        category c ON i.category_id = c.category_id
    INNER JOIN
        inventory inv ON i.product_id = inv.product_id
    WHERE
        i.standard_cost BETWEEN in_min_price AND in_max_price;
END;
$$ LANGUAGE plpgsql;
-- SELECT * FROM filter_items_by_price_range(10.00, 50.00);


--DROP FUNCTION IF EXISTS get_an_item_info(INT)
-- Function to get information of an item
CREATE OR REPLACE FUNCTION get_an_item_info(in_product_id INT)
RETURNS TABLE (product_id INT, product_name VARCHAR(100), category_name VARCHAR(50), description VARCHAR(150), 
			   description_1 VARCHAR(150), description_2 VARCHAR(150), description_3 VARCHAR(150), 
			   description_4 VARCHAR(150), standard_cost NUMERIC(6,2),list_price NUMERIC(6,2))
AS $$
BEGIN
    RETURN QUERY SELECT
		i.product_id,
        i.product_name,
        c.category_name,
        i.description,
        i.description_1,
        i.description_2,
        i.description_3,
        i.description_4,
		i.standard_cost,
        i.list_price
    FROM item i
    JOIN category c ON i.category_id = c.category_id
    WHERE i.product_id = in_product_id;
END;
$$ LANGUAGE plpgsql;
--SELECT * FROM get_an_item_info(2); 

-- Function to get the available item number
CREATE OR REPLACE FUNCTION get_available_item_count(in_product_id INT)
RETURNS INTEGER AS $$
DECLARE
    available_count INTEGER;
BEGIN
    SELECT SUM(quantity) INTO available_count
    FROM inventory i
    WHERE i.product_id = in_product_id;

    RETURN COALESCE(available_count, 0);
END;
$$ LANGUAGE plpgsql;
--SELECT get_available_item_count(211); 
--DROP FUNCTION IF EXISTS get_available_item_count(VARCHAR(50));

-- Function to get the item price
CREATE OR REPLACE FUNCTION get_item_price(in_product_id INT)
RETURNS NUMERIC(6,2) AS $$
BEGIN
    RETURN (SELECT standard_cost FROM item WHERE product_id = in_product_id);
END;
$$ LANGUAGE plpgsql;
--SELECT get_item_price(2); 

--DROP FUNCTION IF EXISTS get_warehouse_info(INT);
-- Function to get information of the warehouse, including location
CREATE OR REPLACE FUNCTION get_warehouse_info(in_product_id INT)
RETURNS TABLE (
    product_id INT, quantity INT, warehouse_name VARCHAR(50),warehouse_id INT, location_id INT,
    address VARCHAR(150),
    postal_code VARCHAR(20),
    city VARCHAR(50),
    state VARCHAR(50),
    country_name VARCHAR(50)
) AS $$
BEGIN
    RETURN QUERY
    SELECT
        i.product_id, i.quantity,
		w.warehouse_name, w.warehouse_id, w.location_id,
        l.address, l.postal_code, l.city, l.state,
        c.country_name
    FROM
        inventory i
    JOIN
        warehouse w ON i.warehouse_id = w.warehouse_id
    JOIN
        item it ON i.product_id = it.product_id
    JOIN
        location l ON w.location_id = l.location_id
    JOIN
        country c ON l.country_id = c.country_id
    WHERE
        it.product_id = in_product_id;
END;
$$ LANGUAGE plpgsql;
--SELECT * FROM get_warehouse_info(211);
