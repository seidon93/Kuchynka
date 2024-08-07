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

CREATE OR REPLACE VIEW v_percentage_grow AS
    WITH year_sales AS (
        SELECT SUM(p.price) AS total_revenue,
               YEAR(o.date) AS year_sale
        FROM orders o
        JOIN order_product op ON o.order_ID = op.order_ID
        JOIN products p ON p.ID = op.product_ID
        GROUP BY year_sale
    )
    SELECT current_year.year_sale                  AS year_sale,
    ROUND((((current_year.total_revenue - previous_year.total_revenue) /
    previous_year.total_revenue) * 100), 1 )       AS revenue_growth,
    '%'                                            AS measure
    FROM year_sales current_year
    JOIN year_sales previous_year ON current_year.year_sale = previous_year.year_sale + 1
    WHERE current_year.year_sale != 2024
    ORDER BY current_year.year_sale;


CREATE OR REPLACE VIEW v_product_sales AS
    SELECT
        c.name                AS category_name,
        SUM(op.nmb)           AS nmb_salles,
        'Ks'                  AS unit,
        p.product_name        AS product_name,
        SUM(p.price * op.nmb) AS total_price,
        'Kč'                  AS currency
    FROM category c
    JOIN products p ON c.Category_ID = p.category_ID
    JOIN order_product op ON p.ID = op.product_ID
    JOIN orders o ON op.order_ID = o.order_ID

    WHERE o.canceled IS NULL
    GROUP BY c.name,
             p.product_name
    ORDER BY total_price DESC;


CREATE OR REPLACE VIEW v_sales_period AS
    SELECT
        YEAR(o.date) AS year_sale,
        MONTH(o.date) AS month_sale,
        SUM(op.nmb) AS nmb_of_products
    FROM orders o
    JOIN order_product op ON o.order_id = op.order_id
    WHERE o.processed = 1
    GROUP BY YEAR(o.date),
             MONTH(o.date)
    ORDER BY YEAR(o.date),
             MONTH(o.date);


CREATE OR REPLACE VIEW v_customers AS
    SELECT
        adr.*,
        CASE cus.sex
            WHEN 'M' THEN 'Muž'
            WHEN 'F' THEN 'Žena'
            ELSE 'Ostatní'
        END AS sex,
        crat.rating,
        branch.city AS "Branch city"
    FROM address adr
    JOIN customers cus ON cus.ID = adr.ID
    JOIN customer_rating crat ON cus.ID = crat.Customer_ID
    JOIN branch ON crat.Branch_ID = branch.Branch_ID;

