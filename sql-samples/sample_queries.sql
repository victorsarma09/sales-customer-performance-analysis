-- Running Total of Sales

SELECT
    TO_CHAR(DATE_TRUNC('month', order_date), 'Mon') AS month,
    SUM(sales) AS monthly_sales,
    SUM(SUM(sales)) OVER (
        ORDER BY DATE_TRUNC('month', order_date)
    ) AS running_sales
FROM master_table
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY DATE_TRUNC('month', order_date);

-- Customer Revenue Ranking

SELECT
    customer_name,
    SUM(sales) AS total_sales,
    RANK() OVER(
        ORDER BY SUM(sales) DESC
    ) AS sales_rank
FROM master_table
GROUP BY customer_name
LIMIT 10;

-- Top Product per Category

SELECT *
FROM (
    SELECT
        category,
        product_name,
        SUM(sales) AS total_sales,
        RANK() OVER(
            PARTITION BY category
            ORDER BY SUM(sales) DESC
        ) AS rank
    FROM master_table
    GROUP BY category, product_name
) ranked_products
WHERE rank = 1;


