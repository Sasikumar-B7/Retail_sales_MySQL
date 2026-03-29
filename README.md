## Retail Sales Analysis SQL Project

**Project Overview**

**Project Title: Retail Sales Analysis**

**Level: Beginner**

**Database:** p1_retail_db
This project aims to showcase essential SQL skills and techniques commonly used by data analysts to explore, clean, and analyze retail sales data. It includes creating a retail sales database, conducting exploratory data analysis (EDA), and solving key business problems using SQL queries. The project is well-suited for beginners who want to strengthen their foundation in SQL and data analysis.

## Objectives:
**Database Setup:** Design and populate a retail sales database using the provided dataset.

**Data Cleaning:** Detect and remove records containing missing or null values to ensure data quality.

**Exploratory Data Analysis (EDA):** Conduct initial analysis to understand patterns, trends, and structure of the dataset.

**Business Analysis:** Utilize SQL queries to answer key business questions and generate meaningful insights from the sales data.

##Project Structure
**Database Creation:**  The project starts by creating a database named p1_retail_db.
**Table Creation:** A table named retail_sales is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

/* Create database names sql_project_p1 */
create database sql_project_p1;

/* Creating a tables called retail_sales under sql_project_p1 database */
Drop table if exists retail_sales;
create table retail_sales (
	transactions_id int primary key,
    sale_date date,
    sale_time time,
	customer_id int,
	gender varchar(20),
	age int,
	category varchar(30),
	quantiy int, 
    price_per_unit float,
	cogs float,
	total_sale float
);

**Data Exploration & Cleaning**
**Record Count:** Calculate the total number of entries present in the dataset.
**Customer Count:** Determine the number of unique customers within the dataset.
**Category Count:** Identify the distinct product categories available in the data.
**Null Value Check:** Detect any missing or null values and remove incomplete records to maintain data quality.
select *
from retail_sales
where
	transactions_id	IS NULL
    OR sale_date IS NULL
	  OR sale_time IS NULL	
    OR customer_id	IS NULL
    OR gender	IS NULL
    OR age	IS NULL
    OR category IS NULL
    OR quantiy IS NULL
    OR price_per_unit IS NULL
    OR cogs	 IS NULL
    OR total_sale IS NULL;
    
DELETE FROM RETAIL_SALES
WHERE
	transactions_id	IS NULL
    OR sale_date IS NULL
  	OR sale_time IS NULL	
    OR customer_id	IS NULL
    OR gender	IS NULL
    OR age	IS NULL
    OR category IS NULL
    OR quantiy IS NULL
    OR price_per_unit IS NULL
    OR cogs	 IS NULL
    OR total_sale IS NULL;

**3. Data Analysis & Findings**
The following SQL queries were designed to address key business questions:

**1. Retrieve all sales records for transactions that occurred on 2022-11-05.**
   select *
     from retail_sales
     where
     sale_date = '2022-11-05';
**2. Fetch all transactions where the product category is 'Clothing' and the quantity sold exceeds 4 during November 2022.**
   SELECT * 
    FROM retail_sales
    WHERE category = 'Clothing'
    AND DATE_FORMAT(sale_date, '%Y-%m') = '2022-11'
    AND quantiy >= 4;
   
**3. Calculate the total sales (total_sale) for each product category.**
   select 
    category,
    sum(total_sale) as total_sales, 
    count(*) as total_orders
    from retail_sales
    group by category;
   
**4. Determine the average age of customers who purchased items from the 'Beauty' category.**
   select 
    round (avg(age), 2) as avg_age,
    category
    from retail_sales
    where category = 'Beauty';
   
**5. Identify all transactions where the total sales value exceeds 1000.**
    select *
      from retail_sales
      where total_sale > 1000;
   
**6. Compute the total number of transactions made by each gender within each product category.**
    select 
      count(transactions_id) as num_transactions,
      category
      from retail_sales
      group by category,
      gender;
    
**7. Analyze the average sales for each month and identify the best-performing month in each year.**
**-- Using Subquery**
select 
  month,
  avg_sales,
  rank() over(order by avg_sales desc) as rk
  from (
  select 
  avg(total_sale) as avg_sales,
  month(sale_date) as month
  from retail_sales
  group by month(sale_date)
  ) t;

**-- Without using subquery**
  select 
    avg(total_sale) as avg_sale,
    month(sale_date) as month,
    rank() over(order by avg(total_sale) desc) as rk
    from retail_sales
    group by month;
    
**8. Identify the top 5 customers based on the highest total purchase value.**
  select
    customer_id,
    sum(total_sale) as total_sales
    from retail_sales
    group by customer_id
    order by total_sales desc
    limit 5;
    
**9. Calculate the number of unique customers who made purchases in each category.**
  select
    count(Distinct customer_id) as customers,
    category
    from retail_sales
    group by category;
    
**10. Categorize transactions into time-based shifts (Morning: <12, Afternoon: 12–17, Evening: >17) and count the number of orders in each shift.**
  select *,
  CASE
	    when hour(sale_time) < 12 then 'Morning'
      when HOUR(sale_time) between 12 and 17 then 'Afternoon'
      Else 'Evening'
  END as shift
  from retail_sales;

**Findings**
**Customer Demographics:** The dataset represents customers across various age groups, with purchases distributed among categories such as Clothing and Beauty.
**High-Value Transactions:** A significant number of transactions exceeded a total sale value of 1000, indicating the presence of high-value purchases.
**Sales Trends:** Monthly analysis reveals fluctuations in sales, helping to identify peak and low-performing periods.
**Customer Insights: **The analysis highlights top-spending customers and identifies the most popular product categories.
Reports
**Sales Summary:** A comprehensive overview of total sales, customer demographics, and category-wise performance.
**Trend Analysis:** Insights into sales patterns across different months and time-based shifts.
**Customer Insights:** Detailed reports on top customers and the count of unique customers across categories.

**Conclusion**
This project provides a strong foundation in SQL for aspiring data analysts, covering key areas such as database creation, data cleaning, exploratory data analysis, and business-focused querying. The insights derived from this analysis can support informed decision-making by uncovering trends in sales performance, customer behavior, and product demand.
