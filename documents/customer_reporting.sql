-- Customer Report  --
/*
 
*********** 
SQL Task 
*********** 
Purpose: 

-	This report consolidates key customer metrics and behaviors 

Highlights" 

1-	Gather essential fields such as names, ages, and transaction details. 
2-	Segments customer’s into categories (VIP, Regular, New) and age group 
3-	Aggregate customer-level metrics: 

		-	Total orders 
		-	Total sales 
		-	Total quantity purchased 
		-	Total products 
		-	Lifespan (in months) 

4.	Calculates valuable KPIs: 

		-	Recency (months since last order) 
		-	Average order value 
		-	Average monthly spend 


*********** 
*********** 
In analyzing big query the best approach is as follows: 

1st stem: Building the Base data (the CTE) 

Selecting all the required Data from the database, first prepare the base data */

WITH base_query AS ( 
/*------------------------------------------------------------------------------------- 
--------------------------------------------------------------------------------------- 
Base Query: Retrieves core columns from tables:  
--------------------------------------------------------------------------------------- 
----------------------------------------------------------------------------------------*/ 
SELECT  
f.order_number, 
f.product_key, 
f.order_date, 
f.sales_amount, 
f.quanity, 
f.customer_key AS customer_key, 
c.customer_number AS customer_number, 
CONCAT(c.first_name, ' ', c.last_name) AS customer_name, 
DATEDIFF(YEAR, c.birthdate, GETDATE()) AS age 
FROM gold.fact_sales f 
LEFT JOIN gold.dim_customers c 
ON f.customer_key = c.customer_key 
WHERE order_date IS NOT NULL 
) 
SELECT * 
FROM base_query 
 

 
 /*
the next step is to add aggregations on top of this result that is needed for the report: 

2nd stem: Adding Aggregations:  

 */
 WITH base_query AS ( 
/*------------------------------------------------------------------------------------- 
--------------------------------------------------------------------------------------- 
Adding Aggregations:   
--------------------------------------------------------------------------------------- 
----------------------------------------------------------------------------------------*/ 
SELECT  
f.order_number, 
f.product_key, 
f.order_date, 
f.sales_amount, 
f.quanity, 
f.customer_key AS customer_key, 
c.customer_number AS customer_number, 
CONCAT(c.first_name, ' ', c.last_name) AS customer_name, 
DATEDIFF(YEAR, c.birthdate, GETDATE()) AS age 
FROM gold.fact_sales f 
LEFT JOIN gold.dim_customers c 
ON f.customer_key = c.customer_key 
WHERE order_date IS NOT NULL 
) 
SELECT 
customer_key, 
customer_number, 
customer_name, 
age, 
COUNT(DISTINCT(order_number)) AS total_numbers, 
SUM(sales_amount) AS total_sales, 
SUM(quanity) AS total_quantity, 
COUNT(DISTINCT product_key) AS total_products, 
MAX(order_date) AS last_order_date, 
DATEDIFF(month, MIN(order_date), MAX(order_date)) AS lifespan 
FROM base_query 
GROUP BY  
	customer_key, 
	customer_number, 
	customer_name, 
	age 
/*
Then we will do the final transformation to include the aggregations that the report required: 

3rd stem: Adding Final Aggregations: 

 */
 WITH base_query AS ( 
/*---------------------------------------------------------------------------------------- 
------------------------------------------------------------------------------------------ 
Base Query: Retrieves core columns from tables:  
------------------------------------------------------------------------------------------ 
-----------------------------------------------------------------------------------------*/ 
SELECT  
f.order_number, 
f.product_key, 
f.order_date, 
f.sales_amount, 
f.quanity, 
f.customer_key AS customer_key, 
c.customer_number AS customer_number, 
CONCAT(c.first_name, ' ', c.last_name) AS customer_name, 
DATEDIFF(YEAR, c.birthdate, GETDATE()) AS age 
FROM gold.fact_sales  AS f 
LEFT JOIN gold.dim_customers c 
ON f.customer_key = c.customer_key 
WHERE order_date IS NOT NULL 
) 
, customer_aggrigation AS ( 
/*---------------------------------------------------------------------------------------- 
------------------------------------------------------------------------------------------ 
Customer Aggrigation: Summerizes key matrics at the customer level 
------------------------------------------------------------------------------------------ 
-----------------------------------------------------------------------------------------*/ 
SELECT 
customer_key, 
customer_number, 
customer_name, 
age, 
COUNT(DISTINCT(order_number)) AS total_orders, 
SUM(sales_amount) AS total_sales, 
SUM(quanity) AS total_quantity, 
COUNT(DISTINCT product_key) AS total_products, 
MAX(order_date) AS last_order_date, 
DATEDIFF(month, MIN(order_date), MAX(order_date)) AS lifespan 
FROM base_query 
GROUP BY  
	customer_key, 
	customer_number, 
	customer_name, 
	age 
) 
SELECT 
customer_key, 
customer_number, 
customer_name, 
age, 
CASE WHEN age < 20 THEN 'Under 20' 
	WHEN age BETWEEN 20 AND 29 THEN '20 - 29' 
	WHEN age BETWEEN 30 AND 39 THEN '30 - 39' 
	WHEN age BETWEEN 40 AND 49 THEN '40 - 49' 
	ELSE 'Above 50' 
END age_group, 
CASE WHEN lifespan >= 12 AND total_sales > 5000 THEN 'VIP'  
    WHEN  lifespan >= 12 AND total_sales <= 5000 THEN 'REGULAR'  
    ELSE 'NEW'  
END customer_segment, 
last_order_date, 
DATEDIFF(month, last_order_date, GETDATE()) AS recency, 
total_orders, 
total_sales, 
total_quantity, 
total_products, 
lifespan, 
--compute average order value (AVO) 
CASE WHEN total_orders = 0 THEN 0 
	ELSE total_sales / total_orders  
END AS avg_order_value, 
--Compute Average Monthly Spent 
CASE WHEN lifespan = 0 THEN total_sales 
	ELSE total_sales / lifespan 
END AS avg_monthly_spend 
FROM customer_aggrigation 

 /*

Final step: collect all the data and put it as 'VIEW' 
-------------------------------------------------------------------------------------- 
-------------------------------------------------------------------------------------- 
-------------------------------------------------------------------------------------- 
UPLOAD THE DATA AS VIEW: "gold.report_customers"
-------------------------------------------------------------------------------------- 
-------------------------------------------------------------------------------------- 
-------------------------------------------------------------------------------------- 

*/

CREATE VIEW gold.report_customers AS  
 
WITH base_query AS ( 
/*------------------------------------------------------------------------------------- 
-------------------------------------------------------------------------------------- 
Base Query: Retrieves core columns from tables:  
-------------------------------------------------------------------------------------- 
-------------------------------------------------------------------------------------*/ 
SELECT  
f.order_number, 
f.product_key, 
f.order_date, 
f.sales_amount, 
f.quanity, 
f.customer_key AS customer_key, 
c.customer_number AS customer_number, 
CONCAT(c.first_name, ' ', c.last_name) AS customer_name, 
DATEDIFF(YEAR, c.birthdate, GETDATE()) AS age 
FROM gold.fact_sales  AS f 
LEFT JOIN gold.dim_customers c 
ON f.customer_key = c.customer_key 
WHERE order_date IS NOT NULL 
) 
, customer_aggrigation AS ( 
/*---------------------------------------------------------------------------------------- 
------------------------------------------------------------------------------------------ 
Customer Aggrigation: Summerizes key matrics at the customer level 
------------------------------------------------------------------------------------------ 
-----------------------------------------------------------------------------------------*/ 
SELECT 
customer_key, 
customer_number, 
customer_name, 
age, 
COUNT(DISTINCT(order_number)) AS total_orders, 
SUM(sales_amount) AS total_sales, 
SUM(quanity) AS total_quantity, 
COUNT(DISTINCT product_key) AS total_products, 
MAX(order_date) AS last_order_date, 
DATEDIFF(month, MIN(order_date), MAX(order_date)) AS lifespan 
FROM base_query 
GROUP BY  
	customer_key, 
	customer_number, 
	customer_name, 
	age 
) 
SELECT 
customer_key, 
customer_number, 
customer_name, 
age, 
----------------------------------------------------------------------------------------- 
--Segments customer’s into categories (VIP, Regular, New) and age group 
----------------------------------------------------------------------------------------- 
CASE WHEN age < 20 THEN 'Under 20' 
	WHEN age BETWEEN 20 AND 29 THEN '20 - 29' 
	WHEN age BETWEEN 30 AND 39 THEN '30 - 39' 
	WHEN age BETWEEN 40 AND 49 THEN '40 - 49' 
	ELSE 'Above 50' 
END age_group, 
CASE WHEN lifespan >= 12 AND total_sales > 5000 THEN 'VIP'  
    WHEN  lifespan >= 12 AND total_sales <= 5000 THEN 'REGULAR'  
    ELSE 'NEW'  
END customer_segment, 
last_order_date, 
----------------------------------------------------------------------------------------- 
--Calculates valuable KPIs: Recency (months since last order) 
----------------------------------------------------------------------------------------- 
DATEDIFF(month, last_order_date, GETDATE()) AS recency, 
/*----------------------------------------------------------------------------------------- 
Aggregate customer-level metrics: 
		-	Total orders 
		-	Total sales 
		-	Total quantity purchased 
		-	Total products 
		-	Lifespan (in months) 
----------------------------------------------------------------------------------------- 
*/
total_orders, 
total_sales, 
total_quantity, 
total_products, 
lifespan, 
----------------------------------------------------------------------------------------- 
--Calculates valuable KPIs: compute average order value (AVO) 
----------------------------------------------------------------------------------------- 
CASE WHEN total_orders = 0 THEN 0 
	ELSE total_sales / total_orders  
END AS avg_order_value, 
----------------------------------------------------------------------------------------- 
--Calculates valuable KPIs: Compute Average Monthly Spent 
----------------------------------------------------------------------------------------- 
CASE WHEN lifespan = 0 THEN total_sales 
	ELSE total_sales / lifespan 
END AS avg_monthly_spend 
FROM customer_aggrigation 

----------------------------------------------------------------------------------------- 

----------------------------------------------------------------------------------------- 

 
