-------------------------------------------------------------------------------------- 
-------------------------------------------------------------------------------------- 
-------------------------------------------------------------------------------------- 
================================Products Report=======================================
-------------------------------------------------------------------------------------- 
-------------------------------------------------------------------------------------- 
-------------------------------------------------------------------------------------- 

*/
-------------------------------------------------------------------------------------- 
---------------UPLOAD THE DATA AS VIEW: "gold.report_products"------------------
-------------------------------------------------------------------------------------- 
CREATE OR ALTER VIEW gold.report_products AS

WITH base_query AS
(
    /*
    1- Gather essential fields such as product name,
       category, subcategory, and cost.
    */
    SELECT 
        f.order_number,
        f.order_date,
        f.customer_key,
        f.sales_amount,
        f.quanity,
        p.product_key,
        p.product_name,
        p.category,
        p.subcategory,
        p.cost
    FROM gold.fact_sales AS f
    LEFT JOIN gold.dim_products AS p
        ON f.product_key = p.product_key
    WHERE f.order_date IS NOT NULL
),

product_agrigation AS
(
    /*
    2- Segment products by revenue to identify
       High-Performers, Mid-Range, or Low-Performers.
    */
    SELECT 
        product_key,
        product_name,
        category,
        subcategory,
        cost,

        MAX(order_date) AS last_sale_date,

        DATEDIFF(
            MONTH,
            MIN(order_date),
            MAX(order_date)
        ) AS lifespan,

        COUNT(DISTINCT order_number) AS total_orders,

        COUNT(DISTINCT customer_key) AS total_customers,

        SUM(sales_amount) AS total_sales,

        SUM(quanity) AS total_quantity,

        ROUND(
            CAST(SUM(sales_amount) AS FLOAT)
            / NULLIF(SUM(quanity), 0),
            1
        ) AS avg_selling_price

    FROM base_query

    GROUP BY 
        product_key,
        product_name,
        category,
        subcategory,
        cost
)

/*
3- FINAL QUERY:
   Combine all product results into one output
*/
SELECT
    product_key,
    product_name,
    category,
    subcategory,
    cost,
    last_sale_date,

    DATEDIFF(
        MONTH,
        last_sale_date,
        GETDATE()
    ) AS [recency in Month],

    CASE 
        WHEN total_sales > 50000 
            THEN 'High-Performers'

        WHEN total_sales >= 10000 
            THEN 'Mid-Range'

        ELSE 'Low-Performers'
    END AS product_segment,

    lifespan,
    avg_selling_price,
    total_customers,
    total_sales,
    total_quantity,

    -- Average Order Revenue (AOR)
    CASE 
        WHEN total_orders = 0 THEN 0
        ELSE total_sales / total_orders
    END AS avg_order_revenue,

    -- Average Monthly Revenue
    CASE 
        WHEN lifespan = 0 THEN total_sales
        ELSE total_sales / lifespan
    END AS avg_monthly_revenue

FROM product_agrigation;

-------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------THE END----------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------


*********** 
SQL Task 
*********** 
Purpose: 

-	This report consolidates key products metrics and behaviors 

Highlights" 

1-	Gather essential fields such as product name, category, subcategory, and cost.
2-	Segments products by revenue to identify High-Performers, Mid-Range, or Low-Performers.
3-	Aggregates product-level metrics: 

		-	Total orders 
		-	Total sales 
		-	total quantity sold 
		-	total customers (unique) 
		-	Lifespan (in months) 

4.	Calculates valuable KPIs: 

		-	Recency (months since last order) 
		-	average order revenue (AOR) 
		-	average monthly revenue 
