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
describe retail_sales;
select * from retail_sales;

/* To check if there are any null in any one of the columns */
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
    
-- Data Exploration
-- Q1: How many sales we have ?
select count(*) as total_sales from retail_sales;

-- Q2: How many unique customers we have ?
select count(Distinct customer_id) as total_customer from retail_sales;

-- Q3: How many unique categories we have ?
select count(Distinct category) as total_category from retail_sales;

-- Q4: List distinct categories in the retail_sales data
select distinct(category) from retail_sales;

-- Data Analysis and Business Key problems
-- 1. Write a SQL query to retrieve all columns for sales made on '2022-11-05:
select * from retail_sales
where sale_date = '2022-11-05';

/* 2: Write a SQL query to retrieve all transactions where the category is 'Clothing' 
and the quantity sold is more than 4 in the month of Nov-2022 */
SELECT * 
FROM retail_sales
WHERE category = 'Clothing'
AND DATE_FORMAT(sale_date, '%Y-%m') = '2022-11'
AND quantiy >= 4;

/* Write a SQL query to calculate the total sales (total_sale) for each category */
select 
category,
sum(total_sale) as total_sales, 
count(*) as total_orders
from retail_sales
group by category;

/* Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category */
select 
round (avg(age), 2) as avg_age,
category
from retail_sales
where category = 'Beauty';

/* Write a SQL query to find all transactions where the total_sale is greater than 1000 */
select *
from retail_sales
where total_sale > 1000;

/* Write a SQL query to find the total number of transactions (transaction_id) 
made by each gender in each category */
select 
count(transactions_id) as num_transactions,
category
from retail_sales
group by category,
gender;

/* Write a SQL query to calculate the average sale for each month. 
Find out best selling month in each year */
-- Using Subquery
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

-- Without using subquery
select 
avg(total_sale) as avg_sale,
month(sale_date) as month,
rank() over(order by avg(total_sale) desc) as rk
from retail_sales
group by month;

/* Write a SQL query to find the top 5 customers based on the highest total sales */
select
customer_id,
sum(total_sale) as total_sales
from retail_sales
group by customer_id
order by total_sales desc
limit 5;

/* Write a SQL query to find the number of unique customers 
who purchased items from each category */
select
count(Distinct customer_id) as customers,
category
from retail_sales
group by category;

/* Write a SQL query to create each shift and 
number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17) */

select *,

CASE
	when hour(sale_time) < 12 then 'Morning'
    when HOUR(sale_time) between 12 and 17 then 'Afternoon'
    Else 'Evening'
END
as shift
from retail_sales;






