select* from orders;
-- find the top 10 highest revenue generating products
select product_id, round(sum(sale_price), 3) as sales
from orders
group by product_id
order by sales
desc limit 10;
 
 -- top 5 highest selling orders in each region
WITH product_sales AS (
    SELECT
        region,
        product_id,
        ROUND(SUM(sale_price), 3) AS sales
    FROM orders
    GROUP BY region, product_id
),
ranked AS (
    SELECT
        region,
        product_id,
        sales,
        ROW_NUMBER() OVER (
            PARTITION BY region
            ORDER BY sales DESC
        ) AS rank_in_region
    FROM product_sales
)
SELECT region, product_id, sales
FROM ranked
WHERE rank_in_region <= 5
ORDER BY region, sales DESC;
-- find month vs month growth comparison for sales for 2022 vs 2023
SELECT
    MONTH(order_date) AS order_month,
    ROUND(SUM(CASE WHEN YEAR(order_date) = 2022 THEN sale_price ELSE 0 END), 2) AS sales_2022,
    ROUND(SUM(CASE WHEN YEAR(order_date) = 2023 THEN sale_price ELSE 0 END), 2) AS sales_2023
FROM orders
WHERE order_date >= '2022-01-01'
  AND order_date <  '2024-01-01'
GROUP BY MONTH(order_date)
ORDER BY order_month;

-- which sub category has highest growth by profit in 2023 compared to 2023
WITH yearly_profit AS (
    SELECT
        sub_category,
        SUM(CASE WHEN YEAR(order_date) = 2022 THEN profit ELSE 0 END) AS profit_2022,
        SUM(CASE WHEN YEAR(order_date) = 2023 THEN profit ELSE 0 END) AS profit_2023
    FROM orders
    WHERE order_date >= '2022-01-01'
      AND order_date <  '2024-01-01'
    GROUP BY sub_category
)
SELECT
    sub_category,
    ROUND(profit_2022, 2) AS profit_2022,
    ROUND(profit_2023, 2) AS profit_2023,
    ROUND(profit_2023 - profit_2022, 2) AS profit_growth
FROM yearly_profit
ORDER BY profit_growth DESC
LIMIT 1;