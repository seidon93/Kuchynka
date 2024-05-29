CREATE TEMPORARY TABLE IF NOT EXISTS order_products AS (
    SELECT
        p.ID,
        p.product_name,
        p.price,
        p.in_stock,
        c.name AS category,
        o.*
    FROM products p
    JOIN category c ON c.category_ID = p.category_ID
    JOIN order_product op ON p.ID = op.product_ID
    JOIN orders o ON op.order_ID = o.order_ID
);


SELECT *
FROM order_products;


