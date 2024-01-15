-- Improve performance of login query, get_user_cart, etc.
CREATE INDEX idx_account_email ON account(email);
--DROP INDEX IF EXISTS idx_account_email;

-- Improve performance of updating item quantity in cart
CREATE INDEX idx_cart_user_id ON cart(user_id);
--DROP INDEX IF EXISTS idx_cart_user_id;

-- Improve performance of updating item quantity in cart
CREATE INDEX idx_order_item_order_product ON order_item(order_id, product_id);
--DROP INDEX IF EXISTS idx_order_item_order_product;

-- Improve performance of admin updating item in inventory
CREATE INDEX idx_inventory_warehouse_product ON inventory(warehouse_id, product_id);
--DROP INDEX IF EXISTS idx_inventory_warehouse_product;




