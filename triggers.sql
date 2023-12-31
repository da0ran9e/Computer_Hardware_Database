-- Auto create a cart when an account is registered
CREATE OR REPLACE FUNCTION create_cart_for_new_account()
RETURNS TRIGGER AS $$
BEGIN
    -- Insert a new record into the cart table when a new account is created
    INSERT INTO cart (user_id) VALUES (NEW.user_id);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create a trigger
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
        SELECT COALESCE(SUM(i.standard_cost * oi.quantity), 0)
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

-- Trigger to update quantity in inventory when item is added, removed, or quantity is updated in order_item
CREATE OR REPLACE FUNCTION update_inventory_quantity()
RETURNS TRIGGER AS $$
BEGIN
    -- Check if the trigger is activated for an INSERT operation (item added to order_item)
    IF TG_OP = 'INSERT' THEN
        UPDATE inventory
        SET quantity = quantity - NEW.quantity
        WHERE product_id = NEW.product_id AND warehouse_id = NEW.warehouse_id;

    -- Check if the trigger is activated for a DELETE operation (item removed from order_item)
    ELSIF TG_OP = 'DELETE' THEN
        UPDATE inventory
        SET quantity = quantity + OLD.quantity
        WHERE product_id = OLD.product_id AND warehouse_id = OLD.warehouse_id;

    -- Check if the trigger is activated for an UPDATE operation (quantity updated in order_item)
    ELSIF TG_OP = 'UPDATE' THEN
        UPDATE inventory
        SET quantity = quantity + OLD.quantity - NEW.quantity
        WHERE product_id = OLD.product_id AND warehouse_id = OLD.warehouse_id;
    END IF;

    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

-- Create trigger to call the function on INSERT, DELETE, or UPDATE operations on order_item
CREATE TRIGGER update_inventory_trigger
AFTER INSERT OR DELETE OR UPDATE ON order_item
FOR EACH ROW
EXECUTE FUNCTION update_inventory_quantity();


