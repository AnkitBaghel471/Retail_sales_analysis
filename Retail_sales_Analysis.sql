-- CREATE DATABASE 
CREATE DATABASE Retailsales_analysis;

--CREATE TABLE
DROP TABLE IF EXISTS RetailSales;
CREATE TABLE RetailSales(
    transactions_id	int Primary key,
	sale_date date,	
	sale_time time,	
	customer_id	int,
	gender varchar(15),
	age int,
	category varchar(15),	
	quantiy	int,
	price_per_unit float,
	cogs float,
	total_sale float
    
);CREATE DATABASE Retailsales_analysi
select * from retailsales
limit 10;

SELECT 
    COUNT(*) 
FROM retailsales

-- Data Cleaning
SELECT * FROM retailsales
WHERE transactions_id IS NULL

SELECT * FROM retailsales
WHERE sale_date IS NULL

SELECT * FROM retailsales
WHERE sale_time IS NULL

SELECT * FROM retailsales
WHERE 
    transactions_id IS NULL
    OR
    sale_date IS NULL
    OR 
    sale_time IS NULL
    OR
    gender IS NULL
    OR
    category IS NULL
    OR
    quantiy IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;
    
-- 
DELETE FROM retail_sales
WHERE 
    transaction_id IS NULL
    OR
    sale_date IS NULL
    OR 
    sale_time IS NULL
    OR
    gender IS NULL
    OR
    category IS NULL
    OR
    quantity IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;
    
-- Data Exploration

-- How many sales we have?
SELECT COUNT(*) as total_sale FROM retailsales

-- How many uniuque customers we have ?

SELECT COUNT(DISTINCT customer_id) as total_sale FROM retailsales



SELECT DISTINCT category FROM retailsales


-- Data Analysis & Business Key Problems & Answers

-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

-- Solve the Questions-

-- Q.1 Write a Sql query to retrieve all columns for sales made on '2022-11-05'
select * from retailsales
where sale_date = '2022-11-05';

-- Q.2 Write a Sql query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in
-- the month of Nov-2022?
select 
  *
from retailsales
where 
    category = 'Clothing'
    And
	TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
	And
	quantiy >= 4
-- how many sum clothing category?
select category, sum(quantiy) from retailsales
where category = 'Clothing'
And
	TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
Group by 1

-- Q.3 Write a SQL query to calculate the total sales (total sales) for each category.
select 
  category, sum(total_sale)
from retailsales
group by category;

-- Q.4 Write a sql query to find the average age of customers who purchased items from the 'Beauty' category.
select 
  ROUND(Avg(age),2) as avg_age
from retailsales   
where category = 'Beauty'
    
-- Write a sql query to find the age 18 + and 50 below of customers who purchased items from the 'Beauty' category? 
select 
  *
from retailsales   
where category = 'Beauty'
and age BETWEEN 18 AND 49
order by age desc;

-- Q.5 Write a sql query to find all transactions where the total_sale is greater than 1000.
Select * from retailsales
where total_sale > 1000

-- Q.6 Write a Sql query to find the total number of transactions (transactions_id) made by each gender in each category?
select  
  gender,category, count(*) as total_trans
from retailsales
    group by gender,category
    order by 2;
	
-- Q.7 Write a sql query to calculate the average sale for each month. Find out best selling month in each year?
select 
  Extract(Year from sale_date) as year,
  Extract(Month from sale_date) as month,
  Avg(total_sale) as avg_sale
From retailsales
Group by year,month
order by year,month Asc;
-- best selling month in each year
select
  year,month,avg_sale
FROM 
(
SELECT
  Extract(year From sale_date) as year,
  Extract(Month From sale_date) as month,
  Avg(total_sale) as avg_sale,
  Rank()OVER(PARTITION BY EXTRACT (YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
from retailsales
group by year,month
) as t1
where rank = 1

-- Q.8 Write a Sql query to find the top 5 customers based on the highest total sales?
select 
  customer_id,
  sum(total_sale) as total_sales
FROM retailsales
Group by customer_id
order by total_sales desc
Limit 5;

-- Q.9 Write a Sql query to find the number of unique customers who purchased items for each category?
select 
  category,
  Count(DISTINCT customer_id) as count_unique_cust 
from retailsales 
group by category;


-- Q.10 Write a Sql query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening > 17)
WITH hourly_sale
AS
(
SELECT *,
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
FROM retailsales
)
SELECT 
    shift,
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift

-- End of project
      
















