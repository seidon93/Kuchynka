CREATE OR REPLACE VIEW v_category_sales AS
    SELECT c.name                        AS category_name,
           SUM(op.nmb)                   AS nmb_salles,
           'Ks'                          AS unit,
           SUM((p.price * op.nmb))       AS total_price,
           'Kč'                          AS currency
    FROM category c
    JOIN products p ON c.Category_ID = p.category_ID
    JOIN kuchynka.order_product op ON p.ID = op.product_ID
    JOIN kuchynka.orders o ON op.order_ID = o.order_ID

    WHERE o.canceled IS NULL
    GROUP BY c.name
    ORDER BY total_price DESC;

