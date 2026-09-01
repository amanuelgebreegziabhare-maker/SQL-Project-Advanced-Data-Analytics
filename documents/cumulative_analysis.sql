
 --Cumulative Analysis  --
 /*

*********** 
SQL Task 
*********** 
-   Calculate total sales by month 
-   and thr rummimg total sales over time 
*/
------------------------------------------------------------------------------------------- 

----Running total sales Trend by Month -----------------------
 
SELECT  
    order_date, 
    total_sales, 
    -- WINDOW FUNCTION  
    -- (default window fram 'between unbounded proceeding and current row) 
    SUM(total_sales) OVER(PARTITION BY order_date ORDER BY order_date) AS running_totol_sales 
    FROM 
    ( 
    SELECT DATETRUNC(MONTH, order_date)   AS order_date, 
        SUM(sales_amount) AS total_sales 
    FROM gold.fact_sales 
    WHERE DATETRUNC(MONTH, order_date)IS NOT NULL 
    GROUP BY DATETRUNC(MONTH, order_date) 
    ) AS monthly_sales_sale 

 

----you can easily change the granularity by YEAR - Running total sales Trend by Month -- 
 
SELECT  
    order_date, 
    total_sales, 
    -- WINDOW FUNCTION  
    -- (default window frame 'between unbounded proceeding and current row) 
    SUM(total_sales) OVER(PARTITION BY order_date ORDER BY order_date) AS running_totol_sales 
    FROM 
    ( 
    SELECT DATETRUNC(YEAR, order_date)   AS order_date, 
        SUM(sales_amount) AS total_sales 
    FROM gold.fact_sales 
    WHERE DATETRUNC(YEAR, order_date)IS NOT NULL 
    GROUP BY DATETRUNC(YEAR, order_date) 
    ) AS yearly_sales_sale 

 



----Adding the Moving Average to the current sales Trend by Month --------------------- 
----Running total sales Trend by Month ----------------------- 
 

SELECT   
    order_date,  
    total_sales,  
    -- WINDOW FUNCTION   
    -- (default window frame 'between unbounded proceeding and current row)  
    SUM(total_sales) OVER(PARTITION BY order_date ORDER BY order_date) AS 		running_totol_sales , 
    AVG(avg_price) OVER(ORDER BY order_date) AS moving_average_price 
    FROM  
    (  
    SELECT DATETRUNC(YEAR, order_date)   AS order_date,  
        SUM(sales_amount) AS total_sales, 
        AVG(price) AS avg_price 
    FROM gold.fact_sales  
    WHERE DATETRUNC(YEAR, order_date)IS NOT NULL  
    GROUP BY DATETRUNC(YEAR, order_date)  
    ) AS yearly_sales_sale 
