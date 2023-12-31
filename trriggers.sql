-- Create function create cart to be used in the trigger
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


-- Trigger to update total_amount after a change in orders_item
CREATE OR REPLACE FUNCTION update_total_amount()
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

CREATE TRIGGER update_total_amount_trigger
AFTER INSERT OR UPDATE OF quantity ON order_item
FOR EACH ROW
EXECUTE FUNCTION update_total_amount();
-- Drop the old trigger
--DROP TRIGGER IF EXISTS update_total_amount_trigger ON order_item;
