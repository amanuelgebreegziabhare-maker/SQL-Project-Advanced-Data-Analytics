--Change Over Time Analysis--

/*********** 
SQL Task 
*********** 
Analyze Sales Performance Over Time */
------------------------------------------------------------------------------------------- 

------------Trend by day----------------------- 

SELECT  
    order_date, 
    SUM(sales_amount) AS total_sales 
  FROM gold.fact_sales 
  GROUP BY order_date 
  ORDER BY total_sales 

this is the trend by day. To change or see the trend by year: 

----------Trend by Year ----------------------- 
 
SELECT  
    YEAR(order_date) AS order_year, 
    SUM(sales_amount) AS total_sales 
  FROM gold.fact_sales 
  WHERE YEAR(order_date) IS NOT NULL 
  GROUP BY YEAR(order_date)  
  ORDER BY order_year 

 ----Sales and Number of Customers Trend by Year ----------------------- 
 
SELECT  
    YEAR(order_date) AS order_year, 
    SUM(sales_amount) AS total_sales, 
    COUNT(DISTINCT customer_key) AS total_customers 
  FROM gold.fact_sales 
  WHERE YEAR(order_date) IS NOT NULL 
  GROUP BY YEAR(order_date)  
  ORDER BY order_year 

 

-----Sales and Number of Customers Trend by Month ----------------------- 
 
SELECT  
    MONTH(order_date) AS order_year, 
    SUM(sales_amount) AS total_sales, 
    COUNT(DISTINCT customer_key) AS total_customers 
  FROM gold.fact_sales 
  WHERE MONTH(order_date) IS NOT NULL 
  GROUP BY MONTH(order_date)  
  ORDER BY order_year 

-----Sales and Number of Customers Trend by Year and then by Month ------------------- 
 

SELECT  
    YEAR(order_date) AS order_year, 
    MONTH(order_date) AS order_Month, 
    SUM(sales_amount) AS total_sales, 
    COUNT(DISTINCT customer_key) AS total_customers 
  FROM gold.fact_sales 
  WHERE YEAR(order_date) IS NOT NULL AND MONTH(order_date) IS NOT NULL 
  GROUP BY YEAR(order_date),  MONTH(order_date)  
  ORDER BY YEAR(order_date), MONTH(order_date) 

 

 
