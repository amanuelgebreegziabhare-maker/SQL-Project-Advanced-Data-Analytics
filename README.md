# 📈 SQL Project – Advanced Data Analytics
# 📌 Overview
This project demonstrates advanced business analytics using SQL Server.
The project goes beyond descriptive analytics and applies advanced SQL techniques including:
-  Window Functions,
-  CTEs,
-  Customer Segmentation,
-  Running Totals,
-  Trend Analysis, and
-  Business Reporting.

# 🎯 Objectives
Transform transactional data into advanced business insights using SQL.
Key analytical areas include:
-  Trend Analysis
-  Performance Analysis
-  Segmentation
-  Customer Reporting
-  Product Reporting
-  Window Functions

# 📚 Analysis Topics
The data analytics that will be covered here wiill include: 
-  Change-Over-Time trends
-  Cumulative Analysis
-  Performance Analysis
-  Part-to-Whole Analysis
-  Data Segmentation
-  Report

  
**[1️⃣ Change Over Time Analysis](documents/change_tver_time_analysis.sql):** Analyze how a measure evolves over time. Helps track trends and identify seasonality in your data:  
#
        Σ[Measure] by [Date Dimension] 
        
        -    Total Sales by Year, 
        -    Average Cost by Month, and 
        -    Track business growth across: Days, Months, Years


**[2️⃣ Cumulative Analysis](documents/cumulative_analysis.sql):** Aggregating the data progressively over time. Helps to understand whether our business is growing or declining over time:
#      
        Σ[Cumulative Measure] by [Date Dimension]  
 
            -   Running Total Sales by year 
            -   Moving Average of Sales by month 


**[3️⃣ Performance Analysis](documents/performance_analysis.sql):** ` Comparing the current value with the targeted value 
 Helps to measure Success and compare performance     
 #
	      Current[measure] - Target[measure] 

            -    Current sales – average sales
            -    Current year sale - previous year sale – yoy analysis
            -    Current sale – lowest sale 


**[4️⃣ Part-to-Whole Analysis](documents/part_to_whole_analysis.sql):** ` we use this to see the proportionality of a part relative to another        

Analyzes how an individual part is performing compared to the overall, allowing us to understand which category has the greatest impact on the Business 
 #
 			([measure]  / Total[measure]) * 100 By [measure] 

				-	sales / total sales * 100 By Category 
				-	Quantity / total quantity * 100 BY Category  



**[5️⃣ Customer Segmentation](documents/customer-segmentation.SQL):** `Data Segmentation, we use this to group the data based on a specific range. Helps to understand the correlation between two measures 
 #
			[measure] By [measure] 

				-	Total Products by Sale Range 
				-	Total Customers by Age 


**[6️⃣ Customer Reporting](documents/customer_reporting.sql):** `:

Purpose: 

-	This report consolidates key customer metrics and behaviors 

Highlights:

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


**[7️⃣ Product Reporting](documents/product_reporting.sql):** `: 

Purpose: 

	-	This report consolidates key product metrics and behaviors. 

Highlights: 

	1.	Gathers essential fields such as product name, category, subcategory, and cost. 
	2.	Segments products by revenue to identify High-Performers, Mid-Range, or Low-Performers. 
	3.	Aggregates product-level metrics: 
		-	total orders 
		-	total sales 
		-	total quantity sold 
		-	total customers (unique) 
		-	lifespan (in months) 
	4.	Calculates valuable KPIs: 
		-	recency (months since last sale) 
		-	average order revenue (AOR) 
		-	average monthly revenue 

## 🛠 SQL Techniques Demonstrated

🔹 **Window Functions**
- `SUM() OVER()`
- `AVG() OVER()`
- `ROW_NUMBER()`
- `RANK()`
- `DENSE_RANK()`

🔹 **Common Table Expressions (CTEs)**
- Recursive and non-recursive CTEs
- Multi-step analytical queries

🔹 **📈 Trend Analysis**
- Year-over-Year (YoY) Analysis
- Month-over-Month (MoM) Analysis
- Growth Rate Calculations
- Time-Series Analytics

🔹 **📊 Running Totals & Moving Averages**
- Cumulative Sales Analysis
- Rolling Averages
- Progressive Performance Tracking

🔹 **🎯 Performance Analysis**
- Actual vs Target Comparisons
- Benchmark Analysis
- Best/Worst Performance Identification

🔹 **🧩 Customer Segmentation**
- Customer Classification
- Behavioral Analysis
- Revenue-Based Segmentation

🔹 **🛒 Product Analytics**
- Product Performance Evaluation
- Top/Bottom Product Analysis
- Category-Level Insights

🔹 **🥧 Part-to-Whole Analysis**
- Percentage Contribution Calculations
- Category Share Analysis
- Market Distribution Insights

🔹 **⚡ Advanced Aggregations**
- Conditional Aggregations
- Group-Based Analytics
- Multi-Level Summaries

🔹 **🔄 CASE Expressions**
- Dynamic Categorization
- Business Rule Implementation
- Data Transformation Logic

🔹 **📅 Date & Time Functions**
- Year, Month, Quarter Analysis
- Time-Based Grouping
- Period Comparisons

🔹 **📋 Business Reporting**
- Executive Dashboards
- KPI Reporting
- Customer & Product Reports


## 🏁 Conclusion

This project demonstrates how SQL can be leveraged beyond basic querying to deliver meaningful business insights and support data-driven decision-making. Through the application of advanced analytical techniques such as Window Functions, CTEs, Trend Analysis, Customer Segmentation, Performance Benchmarking, and Business Reporting, raw transactional data is transformed into actionable intelligence. 【1-a16c50】

The analyses throughout this project showcase the ability to:
- 📊 Monitor business performance over time
- 📈 Identify trends and growth opportunities
- 🎯 Evaluate product and customer performance
- 🧩 Segment data for deeper business understanding
- 📋 Build reporting-ready datasets for stakeholders

By combining analytical thinking with advanced SQL development practices, this project highlights the role of SQL as a powerful tool for modern data analytics, business intelligence, and performance reporting. It serves as a practical demonstration of real-world analytical workflows that can be applied across sales, customer, product, and operational datasets. 【1-a16c50】

⭐ If you found this project helpful, feel free to explore the queries, adapt the techniques to your own datasets, and connect with me for feedback or collaboration.
