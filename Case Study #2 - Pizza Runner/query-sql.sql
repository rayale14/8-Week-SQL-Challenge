/* --------------------
   Table Transformation
   --------------------*/

-- data type check and data cleaning
-- update tables

--1. customer_order
/*
Cleaning customer_orders
- Identify records with null or 'null' values
- updating null or 'null' values to ''
- blanks '' are not null because it indicates the customer asked for no extras or exclusions
*/
--Blanks indicate that the customer requested no extras/exclusions for the pizza, whereas null values would be ambiguous on this.

--2. runner_orders
/*
- pickup time, distance, duration is of the wrong type
- records have nulls in these columns when the orders are cancelled
- convert text 'null' to null values
- units (km, minutes) need to be removed from distance and duration
*/

/* --------------------
   Case A: Pizza Metrics
   --------------------*/
-- Author: Duyen Le Huong
-- Date: 07/17/2023
-- Tool used: MySQL

-- Q1. How many pizzas were ordered?
SELECT 
    COUNT(order_id) AS no_pizzas
FROM
    customer_orders;

-- Q2. How many unique customer orders were made?
SELECT 
    COUNT(DISTINCT (order_id)) AS no_orders
FROM
    customer_orders;
    
-- Q3. How many successful orders were delivered by each runner?
SELECT 
    runner_id, COUNT(order_id) AS suc_orders
FROM
    runner_orders
WHERE
    cancellation NOT IN ('Restaurant Cancellation' , 'Customer Cancellation')
GROUP BY runner_id;

-- Q4. How many of each type of pizza was delivered? (I supposed that they're delivered successfully)
SELECT 
    co.pizza_id,
    pn.pizza_name,
    COUNT(co.pizza_id) AS delivered_pizzas
FROM
    customer_orders co
        JOIN
    pizza_names pn ON co.pizza_id = pn.pizza_id
        JOIN
    runner_orders ro ON ro.order_id = co.order_id
WHERE
    ro.cancellation NOT IN ('Restaurant Cancellation' , 'Customer Cancellation')
GROUP BY 1
ORDER BY 2 DESC;

-- Q5. How many Vegetarian and Meatlovers were ordered by each customer?
SELECT 
    co.customer_id,
    pn.pizza_name,
    COUNT(ro.order_id) AS no_orders
FROM
    customer_orders co
        JOIN
    pizza_names pn ON co.pizza_id = pn.pizza_id
        JOIN
    runner_orders ro ON co.order_id = ro.order_id
GROUP BY 1 , 2
ORDER BY 1 , 2;

---
SELECT 
    customer_id,
    SUM(CASE
        WHEN pizza_id = 1 THEN 1
        ELSE 0
    END) AS Meat_Lovers,
    SUM(CASE
        WHEN pizza_id = 2 THEN 1
        ELSE 0
    END) AS Vegeterian
FROM
    customer_orders
GROUP BY 1
ORDER BY 1;

-- Q6. What was the maximum number of pizzas delivered in a single order?
SELECT 
    MAX(order_count) AS max_count
FROM
    (SELECT 
        order_id, COUNT(pizza_id) AS order_count
    FROM
        customer_orders co
    GROUP BY order_id) mc
        JOIN
    runner_orders ro ON ro.order_id = mc.order_id
WHERE
    cancellation NOT IN ('Restaurant Cancellation' , 'Customer Cancellation');
    
-- Q7. For each customer, how many delivered pizzas had at least 1 change and how many had no changes?
SELECT 
    customer_id,
    SUM(CASE
        WHEN exclusions OR extras IS NULL THEN 1
        ELSE 0
    END) AS no_change,
    SUM(CASE
        WHEN exclusions OR extras IS NOT NULL THEN 1
        ELSE 0
    END) changes
FROM
    customer_orders co
        JOIN
    runner_orders ro ON ro.order_id = co.order_id
WHERE
    cancellation NOT IN ('Restaurant Cancellation' , 'Customer Cancellation')
GROUP BY 1;

-- Q8.How many pizzas were delivered that had both exclusions and extras?
SELECT 
  SUM(CASE WHEN exclusions != '' AND extras != '' THEN 1 ELSE 0 END) AS change_both
FROM customer_orders co
JOIN runner_orders ro 
  ON co.order_id = ro.order_id
WHERE ro.cancellation IS NULL OR ro.cancellation NOT IN ('Restaurant Cancellation', 'Customer Cancellation');

-- Q9. What was the total volume of pizzas ordered for each hour of the day?
SELECT 
    HOUR(order_time) as hour_of_day, COUNT(pizza_id) as no_pizzas
FROM
    customer_orders
GROUP BY 1
ORDER BY 1;

-- Q10. What was the volume of orders for each day of the week?
SELECT 
    DAYNAME(order_time) AS day_of_week, COUNT(pizza_id) as no_pizza
FROM
    customer_orders
GROUP BY 1
ORDER BY 1;

/* --------------------
   Case Runner and Customer Experience.
   --------------------*/
-- Author: Duyen Le Huong
-- Date: 07/17/2023
-- Tool used: MySQL

set sql_mode='';
use pizza_runner;

-- Q1.How many runners signed up for each 1 week period? (i.e. week starts 2021-01-01)
SELECT 
    WEEK(registration_date), COUNT(runner_id)
FROM
    runners
GROUP BY 1;

-- Q2.What was the average time in minutes it took for each runner to arrive at the Pizza Runner HQ to pickup the order?

WITH runners_pickup AS (
  SELECT
    ro.runner_id,
    co.order_id, 
    co.order_time, 
    ro.pickup_time, 
    TIMESTAMPDIFF(MINUTE, co.order_time, ro.pickup_time) AS pickup_minutes
  FROM customer_orders co
  JOIN runner_orders ro
    ON co.order_id = ro.order_id
WHERE ro.cancellation NOT IN ('Restaurant Cancellation' , 'Customer Cancellation')
  GROUP BY 1,2,3,4)
  
SELECT 
  runner_id,
  ROUND(AVG(pickup_minutes)) AS average_time
FROM runners_pickup
GROUP BY 1;

-- Q3.Is there any relationship between the number of pizzas and how long the order takes to prepare?
WITH runners_pickup AS (
  SELECT
    ro.runner_id,
    co.order_id, 
    co.order_time, 
    ro.pickup_time, 
    TIMESTAMPDIFF(MINUTE, co.order_time, ro.pickup_time) AS pickup_minutes,
    count(pizza_id) as no_orderd_pizza	
  FROM customer_orders co
  JOIN runner_orders ro
    ON co.order_id = ro.order_id
WHERE ro.cancellation NOT IN ('Restaurant Cancellation' , 'Customer Cancellation')
  GROUP BY 1,2,3,4)
  
SELECT 
  no_orderd_pizza,
  ROUND(AVG(pickup_minutes)) AS average_time
FROM runners_pickup
GROUP BY 1;

# interpret: 
# If more data points were available, we could plot the data on a graph and analyze the trend to identify the relationship between pizzas and avg time  more clearly. 
# Nonetheless, from the given data, we can conclude that there is a positive correlation between the number of pizzas ordered and the average preparation time. More pizza, more average prepraring time

-- Q4.What was the average distance travelled for each customer?
SELECT 
    co.customer_id, ROUND(AVG(ro.distance), 1) AS avg_distance
FROM
    runner_orders ro
        JOIN
    customer_orders co ON ro.order_id = co.order_id
GROUP BY 1;

-- Q5.What was the difference between the longest and shortest delivery times for all orders?
SELECT 
    MAX(duration) - MIN(duration) AS time_difference
FROM
    runner_orders;

-- Q6.What was the average speed for each runner for each delivery and do you notice any trend for these values?
SELECT 
    ro.runner_id,
    ro.order_id,
    ro.distance,
    ro.duration,
    COUNT(co.pizza_id) AS no_pizzas,
    ROUND(AVG(60 * ro.distance / ro.duration), 1) AS avg_speed
FROM
    customer_orders co
        JOIN
    runner_orders ro ON co.order_id = ro.order_id
WHERE
    ro.cancellation NOT IN ('Restaurant Cancellation' , 'Customer Cancellation')
GROUP BY 1 , 2 , 3 , 4
ORDER BY 1 , 2 , 6;
 #NOTE: DURATION(MINUTTE)
#finding: Runners had the average speed from 35.1 km/h to 44.4km/h,
# there is no clear trend that the number of pizzas affects the delivery speed of an order.

-- Q7.What is the successful delivery percentage for each runner?
SELECT 
    runner_id,
    COUNT(order_id) AS total_orders,
    COUNT(pickup_time) AS suc_deliveries,
    100 * COUNT(pickup_time) / COUNT(order_id) AS suc_pct
FROM
    runner_orders
GROUP BY 1;

/* --------------------
   Case C: Ingredient Optimisation
   --------------------*/
-- Author: Duyen Le Huong
-- Date: 07/18/2023
-- Tool used: MySQL

set sql_mode='';
use pizza_runner;

# because we cannot match directly toppings and topping_id so we have to create a table
# Data cleaning: Create a new temporary table #toppingsBreak to separate toppings into multiple rows

DROP TABLE IF EXISTS toppingsBreak;
CREATE TEMPORARY TABLE toppingsBreak AS
SELECT 
  pizza_id,
  TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(toppings, ',', n), ',', -1)) AS topping_id,
  pt.topping_name
FROM pizza_recipes pr
CROSS JOIN (
  SELECT 1 AS n UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6
  UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10 UNION SELECT 11 UNION SELECT 12
) AS numbers
JOIN pizza_toppings pt
  ON TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(toppings, ',', n), ',', -1)) = pt.topping_id
WHERE n <= 1 + (LENGTH(toppings) - LENGTH(REPLACE(toppings, ',', '')));

SELECT 
    *
FROM
    toppingsBreak;

-- Q1. What are the standard ingredients for each pizza?
SELECT 
    p.pizza_name, GROUP_CONCAT(topping_name, ',') AS ingredients
FROM
    toppingsBreak t
        JOIN
    pizza_names p ON t.pizza_id = p.pizza_id
GROUP BY p.pizza_name;

-- Q2. What was the most commonly added extra?
-- Create a new temporary table extrasBreak to separate extras into multiple rows
DROP TABLE IF EXISTS extrasBreak;
CREATE TEMPORARY TABLE extrasBreak AS
SELECT 
  co.order_id,
  CASE WHEN LENGTH(co.extras) - LENGTH(REPLACE(co.extras, ',', '')) > 0
    THEN TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(co.extras, ',', n), ',', -1))
    ELSE co.extras
  END AS extra_id
FROM customer_orders co
CROSS JOIN (
  SELECT 1 AS n UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 -- Tiếp tục với số lần tách tối đa
) AS numbers
WHERE n <= 1 + (LENGTH(co.extras) - LENGTH(REPLACE(co.extras, ',', '')));

SELECT *
FROM extrasBreak;
--
SELECT 
    pt.topping_name, COUNT(extra_id) AS no_extras
FROM
    pizza_toppings pt
        JOIN
    extrasbreak e ON e.extra_id = pt.topping_id
GROUP BY 1
ORDER BY 2 DESC;


-- Q3. What was the most common exclusion?
-- Create a new temporary table exclusionBreak to separate exclusions into multiple rows
DROP TABLE IF EXISTS exclusionsBreak;
CREATE TEMPORARY TABLE exclusionsBreak AS
SELECT 
  co.order_id,
  CASE WHEN LENGTH(co.exclusions) - LENGTH(REPLACE(co.exclusions, ',', '')) > 0
    THEN TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(co.exclusions, ',', n), ',', -1))
    ELSE co.exclusions
  END AS exclusions_id
FROM customer_orders co
CROSS JOIN (
  SELECT 1 AS n UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 -- Tiếp tục với số lần tách tối đa
) AS numbers
WHERE n <= 1 + (LENGTH(co.exclusions) - LENGTH(REPLACE(co.exclusions, ',', '')));
SELECT *
FROM exclusionsbreak;
--
SELECT 
    pt.topping_name, COUNT(exclusions_id) AS no_exclusions
FROM
    pizza_toppings pt
        JOIN
    exclusionsbreak e ON e.exclusions_id = pt.topping_id
GROUP BY 1
ORDER BY 2 DESC;

----




