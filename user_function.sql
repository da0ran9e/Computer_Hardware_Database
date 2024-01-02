-- Function to register an account
CREATE OR REPLACE FUNCTION register_account(in_username VARCHAR(50), in_password VARCHAR(50), in_email VARCHAR(150), in_phone_number VARCHAR(20))
RETURNS INTEGER AS $$
DECLARE
    result INTEGER;
BEGIN
    -- Check if the email already exists
    IF EXISTS (SELECT 1 FROM account WHERE email = in_email) THEN
        -- email already exists, set result to 0
        result := 0;
    ELSE
        -- email doesn't exist, proceed with the insertion
        INSERT INTO account (user_name, password, email, phone_number)
        VALUES (in_username, in_password, in_email, in_phone_number);

        GET DIAGNOSTICS result = ROW_COUNT;
    END IF;

    RETURN result;
END;
$$ LANGUAGE plpgsql;
--SELECT register_account('user4', 'password4', 'user4@gmail.com','368-383-2839');

-- Function to add/change a phone_number to an account
CREATE OR REPLACE FUNCTION add_phone_number(in_email VARCHAR(150), in_phone_number VARCHAR(20))
RETURNS INTEGER AS $$
BEGIN
    UPDATE account
    SET phone_number = in_phone_number
    WHERE email = in_email;

    IF FOUND THEN
        RETURN 1; -- Success
    ELSE
        RETURN 0; -- Failed (User not found)
    END IF;
END;
$$ LANGUAGE plpgsql;
--SELECT add_phone_number('user1@gmail.com', '123-456-7890');

--DROP FUNCTION login_account(character varying,character varying)
-- Function to login
CREATE OR REPLACE FUNCTION login_account(in_email VARCHAR(150), in_password VARCHAR(50))
RETURNS INTEGER AS $$
DECLARE
    user_exists INTEGER;
BEGIN
    SELECT COUNT(*) INTO user_exists
    FROM account
    WHERE email = in_email AND password = in_password;

    RETURN user_exists;
END;
$$ LANGUAGE plpgsql;
--SELECT login_account('user1@gmail.com', 'password1');
--SELECT login_account('user1', 'password1');

--DROP FUNCTION change_password(character varying,character varying, character varying)
-- Function to change password
CREATE OR REPLACE FUNCTION change_password(in_email VARCHAR(150), in_old_password VARCHAR(50), in_new_password VARCHAR(50))
RETURNS INTEGER AS $$
DECLARE
    user_exists INTEGER;
BEGIN
    SELECT COUNT(*) INTO user_exists
    FROM account
    WHERE email = in_email AND password = in_old_password;

    IF user_exists > 0 THEN
        UPDATE account
        SET password = in_new_password
        WHERE email = in_email;
        
        RETURN 1; -- Success
    ELSE
        RETURN 0; -- Failed
    END IF;
END;
$$ LANGUAGE plpgsql;
--SELECT change_password('user1@gmail.com', 'password', 'password1');


--DROP FUNCTION IF EXISTS get_user_cart(character varying)
-- Function to get cart of a user
CREATE OR REPLACE FUNCTION get_user_cart(in_email VARCHAR(150))
RETURNS TABLE (product_id INT, product_name VARCHAR(100), quantity INT, standard_cost NUMERIC(6,2), total_list_price NUMERIC(12,2))
AS $$
BEGIN
    RETURN QUERY SELECT
        i.product_id, i.product_name, ci.quantity, i.standard_cost, ci.quantity*i.standard_cost AS total_list_price
    FROM
        account a
    JOIN
        cart c ON a.user_id = c.user_id
    JOIN
        cart_item ci ON c.cart_id = ci.cart_id
    JOIN
        item i ON ci.product_id = i.product_id
    WHERE
        a.email = in_email;
END;
$$ LANGUAGE plpgsql;
--SELECT * FROM get_user_cart('user3@gmail.com'); 

--DROP FUNCTION IF EXISTS add_item_to_cart(int, character varying)
-- Function to add an item to cart
CREATE OR REPLACE FUNCTION add_item_to_cart(in_product_id INT, in_quantity INT, in_email VARCHAR(150))
RETURNS INTEGER AS $$
DECLARE
    in_user_id INT;
    in_cart_id INT;
BEGIN
    SELECT user_id INTO in_user_id FROM account WHERE email = in_email;
    SELECT cart_id INTO in_cart_id FROM cart WHERE user_id = in_user_id;

    IF in_user_id IS NOT NULL AND in_cart_id IS NOT NULL THEN
        -- Add the item to cart_item
        INSERT INTO cart_item (cart_id, product_id, quantity)
        VALUES (in_cart_id, in_product_id, in_quantity)
        ON CONFLICT (cart_id, product_id)
        DO UPDATE SET quantity = cart_item.quantity + in_quantity;

        RETURN 1; -- Success
    ELSE
        RETURN 0; -- Failed (User not found or cart not found)
    END IF;
END;
$$ LANGUAGE plpgsql;
--SELECT add_item_to_cart(69, 5, 'user3@gmail.com'); 

--DROP FUNCTION IF EXISTS remove_item_from_cart(int, character varying)
-- Function to remove an item from cart
CREATE OR REPLACE FUNCTION remove_item_from_cart(in_product_id INT, in_email VARCHAR(150))
RETURNS INTEGER AS $$
DECLARE
    in_user_id INT;
    in_cart_id INT;
BEGIN
    SELECT user_id INTO in_user_id FROM account WHERE email = in_email;
    SELECT cart_id INTO in_cart_id FROM cart WHERE user_id = in_user_id;

    IF in_cart_id IS NOT NULL AND in_product_id IS NOT NULL THEN
        -- Remove one item from cart_item
        UPDATE cart_item
        SET quantity = GREATEST(quantity - 1, 0)
        WHERE cart_id = in_cart_id AND product_id = in_product_id;

        -- Check if the quantity became zero, and delete the entry if so
        IF (
            SELECT quantity
            FROM cart_item
            WHERE cart_id = in_cart_id AND product_id = in_product_id
        ) = 0 THEN
            DELETE FROM cart_item
            WHERE cart_id = in_cart_id AND product_id = in_product_id;
        END IF;

        RETURN 1; -- Success
    ELSE
        RETURN 0; -- Failed (User or product not found)
    END IF;
END;
$$ LANGUAGE plpgsql;
--SELECT remove_item_from_cart(211, 'user3@gmail.com'); 

-- Function to update the quantity of an item in cart
CREATE OR REPLACE FUNCTION update_cart_item_quantity(in_cart_id INT, in_product_id INT, in_new_quantity INT)
RETURNS INTEGER AS $$
BEGIN
    UPDATE cart_item
    SET quantity = GREATEST(in_new_quantity, 0)
    WHERE cart_id = in_cart_id AND product_id = in_product_id;

    -- Check if the quantity became zero, and delete the entry if so
    IF in_new_quantity = 0 THEN
        DELETE FROM cart_item
        WHERE cart_id = in_cart_id AND product_id = in_product_id;
    END IF;

    RETURN 1; -- Success
EXCEPTION
    WHEN OTHERS THEN
        RETURN 0; -- Failed
END;
$$ LANGUAGE plpgsql;
--SELECT update_cart_item_quantity(3, 211, 3) AS result;


--DROP FUNCTION IF EXISTS create_order(character varying)
-- Function to create an order
CREATE OR REPLACE FUNCTION create_order(in_email VARCHAR(150))
RETURNS INTEGER AS $$
DECLARE
    in_user_id INT;
    in_cart_id INT;
    in_order_id INT;
BEGIN
    SELECT user_id INTO in_user_id FROM account WHERE email = in_email;
    SELECT cart_id INTO in_cart_id FROM cart WHERE user_id = in_user_id;

    IF in_cart_id IS NOT NULL THEN
        -- Create an order
        INSERT INTO orders (order_date, shipping_address, total_amount, status, payment_type, user_id)
        VALUES (CURRENT_DATE, '', 0.00, 'Pending', 'Credit', in_user_id)
        RETURNING order_id INTO in_order_id;

        RETURN in_order_id; -- Success
    ELSE
        RETURN 0; -- Failed (User or cart not found)
    END IF;
END;
$$ LANGUAGE plpgsql;
--SELECT create_order('user4@gmail.com');


-- Function to add an item to order and delete from cart
CREATE OR REPLACE FUNCTION add_item_to_order(in_product_id INT, in_order_id INT, in_warehouse_id INT)
RETURNS INTEGER AS $$
DECLARE
    existing_quantity INT;
    in_cart_id INT;
BEGIN
    -- Get the cart_id for the user
    SELECT c.cart_id INTO in_cart_id
    FROM cart c
    JOIN account a ON c.user_id = a.user_id
    JOIN orders o ON a.user_id = o.user_id
    WHERE o.order_id = in_order_id;

    -- Check if the item is already in the order_item
    SELECT quantity INTO existing_quantity
    FROM order_item
    WHERE order_id = in_order_id AND product_id = in_product_id;

    IF existing_quantity IS NOT NULL THEN
        -- Increment the quantity by 1 if the item is already in orders_item
        UPDATE order_item
        SET quantity = existing_quantity + 1
        WHERE order_id = in_order_id AND product_id = in_product_id;

        RETURN 1; -- Success
    ELSE
        -- Check if the item is in the user's cart
        SELECT quantity INTO existing_quantity
        FROM cart_item
        WHERE cart_id = in_cart_id AND product_id = in_product_id;

        IF existing_quantity IS NOT NULL THEN
            -- Add the item to order_item from the user's cart
            INSERT INTO order_item (quantity, order_id, warehouse_id, product_id)
            VALUES (existing_quantity, in_order_id, in_warehouse_id, in_product_id);

            -- Delete the item from the user's cart
            DELETE FROM cart_item
            WHERE cart_id = in_cart_id AND product_id = in_product_id;

            RETURN 1; -- Success
        ELSE
            RETURN 0; -- Failed (Product not found in cart or order_item)
        END IF;
    END IF;
END;
$$ LANGUAGE plpgsql;
-- SELECT add_item_to_order(211, 2, 9) AS result;


-- Function to remove an item from order by one
CREATE OR REPLACE FUNCTION remove_item_from_order(in_product_id INT, in_order_id INT)
RETURNS INTEGER AS $$
DECLARE
    existing_quantity INT;
BEGIN
    -- Check if the item is in the order_item
    SELECT quantity INTO existing_quantity
    FROM order_item
    WHERE order_id = in_order_id AND product_id = in_product_id;

    IF existing_quantity IS NOT NULL THEN
        -- Subtract the quantity by 1
        UPDATE order_item
        SET quantity = GREATEST(existing_quantity - 1, 0)
        WHERE order_id = in_order_id AND product_id = in_product_id;

        -- If quantity becomes zero, delete the item from order_item
        IF existing_quantity - 1 = 0 THEN
            DELETE FROM order_item
            WHERE order_id = in_order_id AND product_id = in_product_id;
        END IF;

        RETURN 1; -- Success
    ELSE
        RETURN 0; -- Failed (Product not found in order_item)
    END IF;
END;
$$ LANGUAGE plpgsql;
-- SELECT remove_item_from_order(211, 2) AS result;

--DROP FUNCTION IF EXISTS get_order_info(INT)
-- Function to get information about an order including order_items
CREATE OR REPLACE FUNCTION get_order_info(in_order_id INT)
RETURNS TABLE (
    order_id INT,
    order_date DATE,
    shipping_address VARCHAR(255),
    total_amount NUMERIC(12,2),
    status VARCHAR(50),
    payment_type VARCHAR(50),
    user_id INT,
    product_id INT,
    product_name VARCHAR(100),
	standard_cost NUMERIC(6,2),
    quantity INT,
	total_list_price NUMERIC(12,2),
    warehouse_id INT
)
AS $$
BEGIN
    RETURN QUERY
    SELECT
        o.order_id,
        o.order_date,
        o.shipping_address,
        o.total_amount,
        o.status,
        o.payment_type,
        o.user_id,
        oi.product_id,
        i.product_name,
		i.standard_cost,
        oi.quantity,
		(i.standard_cost*oi.quantity) AS total_list_price,
        oi.warehouse_id
    FROM
        orders o
    LEFT JOIN
        order_item oi ON o.order_id = oi.order_id
    LEFT JOIN
        item i ON oi.product_id = i.product_id
    WHERE
        o.order_id = in_order_id;
END;
$$ LANGUAGE plpgsql;
--SELECT * FROM get_order_info(2);
