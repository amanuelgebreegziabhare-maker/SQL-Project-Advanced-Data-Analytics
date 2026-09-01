--Performance Analysis--
/*
*********** 
SQL Task 
*********** 
-   analyze the yearly performance of products by comparing each product’s sales to both average sales performance and the previous year’s sales 

 
 */
----------------------------------------------------------------------------------------------------------------------------------------- 

WITH yearly_product_sales AS ( 
SELECT   
       YEAR(s.order_date) AS order_year, 
       p.product_name AS product_name, 
       SUM(s.sales_amount) AS current_sales 
FROM gold.fact_sales AS s 
LEFT JOIN gold.dim_products AS p 
ON s.product_key = p.product_key 
WHERE YEAR(s.order_date) IS NOT NULL 
GROUP BY YEAR(s.order_date),  p.product_name 
 
) 
SELECT  
    order_year, 
    product_name, 
    current_sales, 
    AVG(current_sales) OVER(PARTITION BY product_name) AS avg_sales, 
    current_sales -  AVG(current_sales) OVER(PARTITION BY product_name) AS avg_sales, 
    CASE WHEN current_sales -  AVG(current_sales) OVER(PARTITION BY product_name) < 0 THEN 'Below Avg' 
         WHEN current_sales -  AVG(current_sales) OVER(PARTITION BY product_name) > 0 THEN 'Above Avg' 
         ELSE 'Avg' 
    END AS avg_change, 
    -- Yeaar Over Year Performance -- 
    LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) AS py_sales, 
    current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) AS diff_py, 
     CASE WHEN current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) < 0 THEN 'Decrease' 
         WHEN current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) > 0 THEN 'Increase' 
         ELSE 'No Change' 
    END AS py_change 
FROM yearly_product_sales  
ORDER BY product_name, order_year 
