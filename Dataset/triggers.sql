-- Create a function to be used in the trigger
CREATE OR REPLACE FUNCTION create_cart_for_new_account()
RETURNS TRIGGER AS $$
BEGIN
    -- Insert a new record into the cart table when a new account is created
    INSERT INTO cart (user_id) VALUES (NEW.user_id);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create a trigger that calls the function when a new account is inserted
CREATE TRIGGER create_cart_trigger
AFTER INSERT ON account
FOR EACH ROW
EXECUTE FUNCTION create_cart_for_new_account();

-- Function to update total_amount in orders
CREATE OR REPLACE FUNCTION update_order_total_amount()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE orders
    SET total_amount = (
        SELECT COALESCE(SUM(i.list_price * oi.quantity), 0)
        FROM order_item oi
        JOIN item i ON oi.product_id = i.product_id
        WHERE oi.order_id = NEW.order_id
    )
    WHERE orders.order_id = NEW.order_id;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger to call the update_order_total_amount function
CREATE TRIGGER orders_item_after_insert
AFTER INSERT
ON order_item
FOR EACH ROW
EXECUTE FUNCTION update_order_total_amount();
