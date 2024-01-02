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

-- Admin Function to remove an item
CREATE OR REPLACE FUNCTION admin_remove_item(
    in_username VARCHAR(50),
    in_pass VARCHAR(50),
    in_product_name VARCHAR(100)
)
RETURNS INTEGER AS $$
BEGIN
    IF is_admin(in_username, in_pass) THEN
        DELETE FROM item
        WHERE product_name = in_product_name;

        -- Delete the item from all warehouses
        DELETE FROM inventory
        WHERE product_id = (SELECT product_id FROM item WHERE product_name = in_product_name);

        RETURN 1; -- Success
    ELSE
        RETURN 0; -- Not an admin
    END IF;
END;
$$ LANGUAGE plpgsql;

-- Admin Function to add one item to inventory
CREATE OR REPLACE FUNCTION add_one_to_inventory(
    in_username VARCHAR(50),
    in_pass VARCHAR(50),
    in_warehouse_id INT,
    in_product_id INT
)
RETURNS INTEGER AS $$
BEGIN
    IF is_admin(in_username, in_pass) THEN
        INSERT INTO inventory (warehouse_id, product_id, quantity)
        VALUES (in_warehouse_id, in_product_id, 1)
        ON CONFLICT (warehouse_id, product_id)
        DO UPDATE SET quantity = inventory.quantity + 1;
        
        RETURN 1; -- Success
    ELSE
        RETURN 0; -- Not an admin
    END IF;
END;
$$ LANGUAGE plpgsql;

-- Admin Function to remove one item from inventory
CREATE OR REPLACE FUNCTION remove_one_from_inventory(
    in_username VARCHAR(50),
    in_pass VARCHAR(50),
    in_warehouse_id INT,
    in_product_id INT
)
RETURNS INTEGER AS $$
BEGIN
    IF is_admin(in_username, in_pass) THEN
        UPDATE inventory
        SET quantity = GREATEST(quantity - 1, 0)
        WHERE warehouse_id = in_warehouse_id AND product_id = in_product_id;
        
        RETURN 1; -- Success
    ELSE
        RETURN 0; -- Not an admin
    END IF;
END;
$$ LANGUAGE plpgsql;

-- Admin Function to add an item in warehouse
CREATE OR REPLACE FUNCTION admin_add_item_in_warehouse(
    in_username VARCHAR(50),
    in_pass VARCHAR(50),
    in_product_name VARCHAR(100),
    in_warehouse_name VARCHAR(50)
)
RETURNS INTEGER AS $$
DECLARE
    product_id INT;
    warehouse_id INT;
BEGIN
    IF is_admin(in_username, in_pass) THEN
        SELECT product_id INTO product_id FROM item WHERE product_name = in_product_name;
        SELECT warehouse_id INTO warehouse_id FROM warehouse WHERE warehouse_name = in_warehouse_name;

        IF product_id IS NOT NULL AND warehouse_id IS NOT NULL THEN
            -- Add the item to inventory in the specified warehouse
            INSERT INTO inventory (quantity, warehouse_id, product_id)
            VALUES (1, warehouse_id, product_id)
            ON CONFLICT (warehouse_id, product_id)
            DO UPDATE SET quantity = inventory.quantity + 1;
            
            RETURN 1; -- Success
        ELSE
            RETURN 0; -- Failed (Product or warehouse not found)
        END IF;
    ELSE
        RETURN 0; -- Not an admin
    END IF;
END;
$$ LANGUAGE plpgsql;

-- Admin Function to remove an item from warehouse
CREATE OR REPLACE FUNCTION admin_remove_item_from_warehouse(
    in_username VARCHAR(50),
    in_pass VARCHAR(50),
    in_product_name VARCHAR(100),
    in_warehouse_name VARCHAR(50)
)
RETURNS INTEGER AS $$
DECLARE
    product_id INT;
    warehouse_id INT;
BEGIN
    IF is_admin(in_username, in_pass) THEN
        SELECT product_id INTO product_id FROM item WHERE product_name = in_product_name;
        SELECT warehouse_id INTO warehouse_id FROM warehouse WHERE warehouse_name = in_warehouse_name;

        IF product_id IS NOT NULL AND warehouse_id IS NOT NULL THEN
            -- Remove one item from inventory in the specified warehouse
            DELETE FROM inventory
            WHERE warehouse_id = warehouse_id AND product_id = product_id;
            
            RETURN 1; -- Success
        ELSE
            RETURN 0; -- Failed (Product or warehouse not found)
        END IF;
    ELSE
        RETURN 0; -- Not an admin
    END IF;
END;
$$ LANGUAGE plpgsql;
