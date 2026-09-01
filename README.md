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



**[5️⃣ Customer Segmentation](documents/customer-segmentation. SQL):** `Data Segmentation, we use this to group the data based on a specific range. Helps to understand the correlation between two measures 
 #
			[measure] By [measure] 

				-	Total Products by Sale Range 
				-	Total Customers by Age 
