



Select * from pizza_sales;

-- Total Revenue
Select round(Cast(SUM(total_price) as NUMERIC),2) as Total_Revenue
from pizza_sales;

-- Average Order Value

Select round(Cast(SUM(total_price)/COUNT(DISTINCT(order_id)) as NUMERIC),2) as Average_order_value
from pizza_sales;

-- Total pizzas Sold

Select SUM(quantity) as Total_pizzas_sold
from pizza_sales;

-- Total Orders

Select COUNT(DISTINCT order_id) as total_orders
from pizza_sales;

-- Average Pizzas per Order

Select round(Cast(SUM(quantity) as NUMERIC)/Cast(COUNT(DISTINCT(order_id)) as NUMERIC),2) as avg_pizza_order
from pizza_sales;

-- Hourly trend of avg pizzas sold
SELECT CAST(EXTRACT(HOUR FROM order_time) AS INT) AS hour_int,
	SUM(quantity)/COUNT(DISTINCT order_date) as pizza_sold_per_hour
FROM pizza_sales
group by hour_int
order by hour_int;

-- Hourly trend of total pizzas sold
SELECT CAST(EXTRACT(HOUR FROM order_time) AS INT) AS hour_int,
	SUM(quantity) as total_pizza_sold
FROM pizza_sales
group by hour_int
order by hour_int;

-- Weekly Trend of orders

Select EXTRACT(WEEK from order_date) as week_number,
EXTRACT(YEAR from order_date) as Year_num,
COUNT(DISTINCT order_id)
from pizza_sales
group by Year_num,week_number
order by Year_num,week_number;

-- % of Sales by Pizza Category

SELECT pizza_category,
ROUND(CAST(SUM(total_price) * 100.0 as NUMERIC) / CAST(total_sum as NUMERIC), 2) AS percentage_contribution
FROM pizza_sales,
(SELECT SUM(total_price) AS total_sum FROM pizza_sales) AS p
GROUP BY pizza_category, total_sum;

-- % of Sales by Pizza Size

SELECT pizza_size,
ROUND(CAST(COUNT(pizza_size) * 100.0 as NUMERIC) / CAST(total_pizza_sold as NUMERIC), 2) AS percentage_contribution
FROM pizza_sales,
(SELECT COUNT(pizza_size) AS total_pizza_sold FROM pizza_sales) AS q
GROUP BY pizza_size, total_pizza_sold
ORDER BY pizza_size;

-- Total Pizzas Sold by Pizza Category


Select pizza_category, sum(quantity) 
from pizza_sales
group by pizza_category
order by pizza_category;

-- Top 5 Pizzas by Revenue

WITH pizza_revenue AS (
    SELECT pizza_name,
           SUM(total_price) AS total_revenue
    FROM pizza_sales
    GROUP BY pizza_name
)

SELECT *
FROM pizza_revenue
ORDER BY total_revenue DESC
LIMIT 5;

-- Bottom 5 Pizzas by Revenue

WITH pizza_revenue AS (
    SELECT pizza_name,
           SUM(total_price) AS total_revenue
    FROM pizza_sales
    GROUP BY pizza_name
)

SELECT *
FROM pizza_revenue
ORDER BY total_revenue ASC
LIMIT 5;

-- Top 5 Pizzas by Quantity

WITH pizza_count AS (
    SELECT pizza_name,
           COUNT(quantity) AS total_count
    FROM pizza_sales
    GROUP BY pizza_name
)

SELECT *
FROM pizza_count
ORDER BY total_count DESC
LIMIT 5;

-- Bottom 5 Pizzas by Quantity
WITH pizza_count AS (
    SELECT pizza_name,
           COUNT(quantity) AS total_count
    FROM pizza_sales
    GROUP BY pizza_name
)

SELECT *
FROM pizza_count
ORDER BY total_count ASC
LIMIT 5;

-- Top 5 Pizzas by Total Orders

WITH orders_count AS (
    SELECT pizza_name,
           COUNT(DISTINCT order_id) AS total_count
    FROM pizza_sales
    GROUP BY pizza_name
)

SELECT *
FROM orders_count
ORDER BY total_count DESC
LIMIT 5;

-- Bottom 5 Pizzas by Total Orders

WITH orders_count AS (
    SELECT pizza_name,
           COUNT(DISTINCT order_id) AS total_count
    FROM pizza_sales
    GROUP BY pizza_name
)

SELECT *
FROM orders_count
ORDER BY total_count ASC
LIMIT 5;


