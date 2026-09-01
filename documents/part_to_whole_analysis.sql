*********** 
SQL Task 
*********** 
-   Which categories contribute the most to the overall Sales? 

------------------------------------------------------------------------------ 

WITH part_over_all AS ( 
SELECT  
      p.category AS category, 
      SUM(sales_amount) AS total_sales 
       
  FROM gold.fact_sales f 
  LEFT JOIN gold.dim_products as p 
  on f.product_key = p.product_key 
  GROUP BY category 
  ) 
  SELECT  
    category, 
    total_sales, 
    SUM(total_sales)  OVER() AS overall_sales, 
    CONCAT(ROUND(CAST(total_sales AS FLOAT)/ SUM(total_sales)  OVER() * 100, 2), '%') AS percentage_of_total 
  FROM part_over_all 
  ORDER BY total_sales DESC 
   

----------------------------------------------------------- 

--------------------------------------------------------------------------------------------
