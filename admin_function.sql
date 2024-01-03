-- Function to check admin authentication
CREATE OR REPLACE FUNCTION is_admin(in_username VARCHAR(50), in_pass VARCHAR(50))
RETURNS BOOLEAN AS $$
BEGIN
    RETURN EXISTS (SELECT 1 FROM admin WHERE username = in_username AND pass = in_pass);
END;
$$ LANGUAGE plpgsql;
-- SELECT * FROM is_admin('admin1','password1');

-- Admin Function to add a new item
CREATE OR REPLACE FUNCTION admin_add_item(in_username VARCHAR(50), in_pass VARCHAR(50), in_product_id INT, 
										  in_product_name VARCHAR(100), in_description VARCHAR(150),
										  in_description_1 VARCHAR(150), in_description_2 VARCHAR(150), 
										  in_description_3 VARCHAR(150), in_description_4 VARCHAR(150), 
										  in_standard_cost NUMERIC(6,2), in_list_price NUMERIC(6,2), in_category_id INT)
RETURNS INTEGER AS $$
BEGIN
	IF is_admin(in_username, in_pass) THEN
    	INSERT INTO item (product_id, product_name, description, description_1, description_2, description_3, description_4, standard_cost, list_price, category_id)
    	VALUES (in_product_id, in_product_name, in_description, in_description_1, in_description_2, in_description_3, in_description_4, in_standard_cost, in_list_price, in_category_id);
	
    	RETURN 1; -- Success
	ELSE 
		RETURN 0; -- Not admin
	END IF;
END;
$$ LANGUAGE plpgsql;
--SELECT admin_add_item('admin1', 'password1', 1, 'Sample Item', 'Description', '', '', '', '', 50.00, 100.00, 1) AS result;


-- Admin Function to remove an item
CREATE OR REPLACE FUNCTION admin_remove_item(
    in_username VARCHAR(50),
    in_pass VARCHAR(50),
    in_product_id INT
)
RETURNS INTEGER AS $$
BEGIN
    IF is_admin(in_username, in_pass) THEN
        DELETE FROM item
        WHERE product_id = in_product_id;

        -- Delete the item from all warehouses
        DELETE FROM inventory
        WHERE product_id = in_product_id;

        RETURN 1; -- Success
    ELSE
        RETURN 0; -- Not an admin
    END IF;
END;
$$ LANGUAGE plpgsql;
--SELECT admin_remove_item('admin1', 'password1', 'Sample Item') AS result;


-- Admin Function to add item to inventory/warehouse
CREATE OR REPLACE FUNCTION add_item_to_inventory(
    in_username VARCHAR(50),
    in_pass VARCHAR(50),
    in_warehouse_id INT,
    in_product_id INT,
	in_quantity INT
)
RETURNS INTEGER AS $$
BEGIN
    IF is_admin(in_username, in_pass) THEN
        INSERT INTO inventory (warehouse_id, product_id, quantity)
        VALUES (in_warehouse_id, in_product_id, in_quantity)
        ON CONFLICT (warehouse_id, product_id)
        DO UPDATE SET quantity = inventory.quantity + in_quantity;
        
        RETURN 1; -- Success
    ELSE
        RETURN 0; -- Not an admin
    END IF;
END;
$$ LANGUAGE plpgsql;
--SELECT add_item_to_inventory('admin1', 'password1', 1, 1, 100) AS result;


-- Admin Function to remove item from inventory/warehouse
CREATE OR REPLACE FUNCTION remove_item_from_inventory(
    in_username VARCHAR(50),
    in_pass VARCHAR(50),
    in_warehouse_id INT,
    in_product_id INT,
	in_quantity INT
)
RETURNS INTEGER AS $$
BEGIN
    IF is_admin(in_username, in_pass) THEN
        UPDATE inventory
        SET quantity = GREATEST(quantity - in_quantity, 0)
        WHERE warehouse_id = in_warehouse_id AND product_id = in_product_id;
		
		IF quantity = 0 THEN
            -- Remove one item from inventory in the specified warehouse
            DELETE FROM inventory
            WHERE warehouse_id = warehouse_id AND product_id = product_id;
        
        RETURN 1; -- Success
    ELSE
        RETURN 0; -- Not an admin
    END IF;
END;
$$ LANGUAGE plpgsql;
--SELECT remove_item_from_inventory('admin1', 'password1', 1, 1, 1001) AS result;

