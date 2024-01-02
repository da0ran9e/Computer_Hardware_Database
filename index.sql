-- Improve performance of login query
CREATE INDEX idx_account_email ON account(email);
--DROP INDEX IF EXISTS idx_account_email;

-- Improve performance of get_user_cart, add/remove_item_to_cart, create_order
CREATE INDEX idx_cart_user_id ON cart(user_id);
--DROP INDEX IF EXISTS idx_cart_user_id;

-- Improve performance of add/remove_item_to_cart
CREATE INDEX idx_cart_item_cart_product ON cart_item(cart_id, product_id);
--DROP INDEX IF EXISTS idx_cart_item_cart_product;

-- Improve performance of add/remove_item_to_order
CREATE INDEX idx_order_item_order_product ON order_item(order_id, product_id);
--DROP INDEX IF EXISTS idx_order_item_order_product;

-- Improve performance of item-related functions because category_id is in a lot of WHERE clause
CREATE INDEX idx_item_category_id ON item(category_id);
--DROP INDEX IF EXISTS idx_item_category_id;

-- Improve performance of add/remove_one_to_inventory
CREATE INDEX idx_inventory_warehouse_product ON inventory(warehouse_id, product_id);
--DROP INDEX IF EXISTS idx_inventory_warehouse_product;

-- Improve performance of admin_add/remove_item_in_warehouse
CREATE INDEX idx_warehouse_name ON warehouse(warehouse_name);
--DROP INDEX IF EXISTS idx_warehouse_name;



