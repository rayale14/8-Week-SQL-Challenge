# [8-Week SQL Challenge](https://github.com/rayale14/8-Week-SQL-Challenge) 
![Star Badge](https://img.shields.io/static/v1?label=%F0%9F%8C%9F&message=If%20Useful&style=style=flat&color=BC4E99)
[![View Main Folder](https://img.shields.io/badge/View-Main_Folder-971901?)](https://github.com/rayale14/8-Week-SQL-Challenge)
[![View Repositories](https://img.shields.io/badge/View-My_Repositories-blue?logo=GitHub)](https://github.com/rayale14?tab=repositories)
[![View My Profile](https://img.shields.io/badge/View-My_Profile-green?logo=GitHub)](https://github.com/rayale14)


# 🍕 Case Study #2 - Pizza Runner
<p align="center">
<img src="https://github.com/ndleah/8-Week-SQL-Challenge/blob/main/IMG/org-2.png" width=40% height=40%>

## 📕 Table Of Contents
  - 🛠️ [Business Task](#business-task)
  - 📂 [Dataset](#dataset)
  - 🚀 [Solutions](#-solutions)

---

## 🛠️ Business Task

> Danny was scrolling through his Instagram feed when something really caught his eye - “80s Retro Styling and Pizza Is The Future!”
> 
> Danny was sold on the idea, but he knew that pizza alone was not going to help him get seed funding to expand his new Pizza Empire - so he had one more genius idea to combine with it - he was going to Uberize it - and so **Pizza Runner** was launched!
> 
> Danny started by recruiting “runners” to deliver fresh pizza from Pizza Runner Headquarters (otherwise known as Danny’s house) and also maxed out his credit card to pay freelance developers to build a mobile app to accept orders from customers.

---

## 📂 Dataset
Danny has shared with you 6 key datasets for this case study:

### **```runners```**
<details>
<summary>
View table
</summary>

The runners table shows the **```registration_date```** for each new runner.


|runner_id|registration_date|
|---------|-----------------|
|1        |1/1/2021         |
|2        |1/3/2021         |
|3        |1/8/2021         |
|4        |1/15/2021        |

</details>


### **```customer_orders```**

<details>
<summary>
View table
</summary>

Customer pizza orders are captured in the **```customer_orders```** table with 1 row for each individual pizza that is part of the order.

|order_id|customer_id|pizza_id|exclusions|extras|order_time        |
|--------|---------|--------|----------|------|------------------|
|1  |101      |1       |          |      |44197.75349537037 |
|2  |101      |1       |          |      |44197.79226851852 |
|3  |102      |1       |          |      |44198.9940162037  |
|3  |102      |2       |          |*null* |44198.9940162037  |
|4  |103      |1       |4         |      |44200.558171296296|
|4  |103      |1       |4         |      |44200.558171296296|
|4  |103      |2       |4         |      |44200.558171296296|
|5  |104      |1       |null      |1     |44204.87533564815 |
|6  |101      |2       |null      |null  |44204.877233796295|
|7  |105      |2       |null      |1     |44204.88922453704 |
|8  |102      |1       |null      |null  |44205.99621527778 |
|9  |103      |1       |4         |1, 5  |44206.47429398148 |
|10 |104      |1       |null      |null  |44207.77417824074 |
|10 |104      |1       |2, 6      |1, 4  |44207.77417824074 |

</details>

### **```runner_orders```**

<details>
<summary>
View table
</summary>

After each orders are received through the system - they are assigned to a runner - however not all orders are fully completed and can be cancelled by the restaurant or the customer.

The **```pickup_time```** is the timestamp at which the runner arrives at the Pizza Runner headquarters to pick up the freshly cooked pizzas. 

The **```distance```** and **```duration```** fields are related to how far and long the runner had to travel to deliver the order to the respective customer.



|order_id|runner_id|pickup_time|distance  |duration|cancellation      |
|--------|---------|-----------|----------|--------|------------------|
|1       |1        |1/1/2021 18:15|20km      |32 minutes|                  |
|2       |1        |1/1/2021 19:10|20km      |27 minutes|                  |
|3       |1        |1/3/2021 0:12|13.4km    |20 mins |*null*             |
|4       |2        |1/4/2021 13:53|23.4      |40      |*null*             |
|5       |3        |1/8/2021 21:10|10        |15      |*null*             |
|6       |3        |null       |null      |null    |Restaurant Cancellation|
|7       |2        |1/8/2020 21:30|25km      |25mins  |null              |
|8       |2        |1/10/2020 0:15|23.4 km   |15 minute|null              |
|9       |2        |null       |null      |null    |Customer Cancellation|
|10      |1        |1/11/2020 18:50|10km      |10minutes|null              |

</details>

### **```pizza_names```**

<details>
<summary>
View table
</summary>

|pizza_id|pizza_name|
|--------|----------|
|1       |Meat Lovers|
|2       |Vegetarian|

</details>

### **```pizza_recipes```**

<details>
<summary>
View table
</summary>

Each **```pizza_id```** has a standard set of **```toppings```** which are used as part of the pizza recipe.


|pizza_id|toppings |
|--------|---------|
|1       |1, 2, 3, 4, 5, 6, 8, 10| 
|2       |4, 6, 7, 9, 11, 12| 

</details>

### **```pizza_toppings```**

<details>
<summary>
View table
</summary>

This table contains all of the **```topping_name```** values with their corresponding **```topping_id```** value.


|topping_id|topping_name|
|----------|------------|
|1         |Bacon       | 
|2         |BBQ Sauce   | 
|3         |Beef        |  
|4         |Cheese      |  
|5         |Chicken     |     
|6         |Mushrooms   |  
|7         |Onions      |     
|8         |Pepperoni   | 
|9         |Peppers     |   
|10        |Salami      | 
|11        |Tomatoes    | 
|12        |Tomato Sauce|

</details>

---

## 🚀 Solutions

<details>
<summary> 
Pizza Metrics
</summary>

### **Q1. How many pizzas were ordered?**
```sql
SELECT 
    COUNT(order_id) AS no_pizzas
FROM
    customer_orders;
```
|no_pizzas  |
|-----------|
|14         |

### **Q2. How many unique customer orders were made?**
```sql
SELECT 
    COUNT(DISTINCT (order_id)) AS no_orders
FROM
    customer_orders;
```
|no_order   |
|-----------|
|10         |


### **Q3. How many successful orders were delivered by each runner?**
```sql
SELECT 
    runner_id, COUNT(order_id) AS suc_orders
FROM
    runner_orders
WHERE
    cancellation NOT IN ('Restaurant Cancellation', 'Customer Cancellation')
GROUP BY runner_id;
```

| runner_id | suc_orders        |
|-----------|-------------------|
| 1         | 4                 |
| 2         | 3                 |
| 3         | 1                 |


### **Q4. How many of each type of pizza was delivered?**
```SQL
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
```
|pizza_id| pizza_name | delivered_pizzas |
|--------|------------|------------------|
|2       | Vegetarian | 3                |
|1       | Meatlovers | 9                |


### **Q5. How many Vegetarian and Meatlovers were ordered by each customer?**
```SQL
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
```

| customer_id | meat_lovers | vegetarian |
|-------------|-------------|------------|
| 101         | 2           | 1          |
| 102         | 2           | 1          |
| 103         | 3           | 1          |
| 104         | 3           | 0          |
| 105         | 0           | 1          |

### **Q6. What was the maximum number of pizzas delivered in a single order?**
```SQL
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
 ``` 

| max_count |
|-----------|
| 3         |


### **Q7. For each customer, how many delivered pizzas had at least 1 change and how many had no changes?**
```SQL
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
```

| customer_id | no_changes | changes   |
|-------------|------------|-----------|
| 101         | 0          | 2         |
| 102         | 0          | 3         |
| 103         | 3          | 3         |
| 104         | 1          | 3         |
| 105         | 0          | 1         |


### **Q8. How many pizzas were delivered that had both exclusions and extras?**
```SQL
SELECT 
  SUM(CASE WHEN exclusions != '' AND extras != '' THEN 1 ELSE 0 END) AS change_both
FROM customer_orders co
JOIN runner_orders ro 
  ON co.order_id = ro.order_id
WHERE ro.cancellation IS NULL OR ro.cancellation NOT IN ('Restaurant Cancellation', 'Customer Cancellation');
```  

| change_both |
|-------------|
| 1           |


### **Q9. What was the total volume of pizzas ordered for each hour of the day?**
```SQL
SELECT 
    HOUR(order_time) as hour_of_day, COUNT(pizza_id) as no_pizzas
FROM
    customer_orders
GROUP BY 1
ORDER BY 1;
```

| hour_of_day | no_pizza    |
|-------------|-------------|
| 11          | 1           |
| 13          | 3           |
| 18          | 3           |
| 19          | 1           |
| 21          | 3           |
| 23          | 3           |

### **Q10. What was the volume of orders for each day of the week?**
```SQL
SELECT 
    DAYNAME(order_time) AS day_of_week, COUNT(pizza_id)
FROM
    customer_orders
GROUP BY 1
ORDER BY 1;
```

| day_of_week | no_pizza    |
|-------------|-------------|
| Friday      | 1           |
| Saturday    | 5           |
| Thursday    | 3           |
| Wednesday   | 5           |

</details>

<details>
<summary>
Runner and Customer Experience
</summary>

### **Q1. How many runners signed up for each 1 week period? (i.e. week starts 2021-01-01)**
```SQL
SELECT 
    WEEK(registration_date) as weeks, COUNT(runner_id) as signups
FROM
    runners
GROUP BY 1;
```

| week | signups |
|------|---------|
| 0    | 1       |
| 1    | 2       |
| 2    | 1       |

### **Q2. What was the average time in minutes it took for each runner to arrive at the Pizza Runner HQ to pickup the order?**
```SQL
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
```
| runner_id | average_tine        |
|-----------|---------------------|
| 1         | 14                  |
| 2         | 20                  |
| 3         | 10                  |

### **Q3. Is there any relationship between the number of pizzas and how long the order takes to prepare?**
```SQL
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
```

| no_order_pizza     | average_time    |
|--------------------|-----------------|
| 1                  | 12              |
| 2                  | 18              |
| 3                  | 29              |
 
# Finding: If more data points were available, we could plot the data on a graph and analyze the trend to identify the relationship between pizzas and avg time  more clearly. Nonetheless, from the given data, we can only conclude that there is a positive correlation between the number of pizzas ordered and the average preparation time. More pizza, more average preparing time.

### **Q4. What was the average distance travelled for each runner?**
```SQL
SELECT 
    co.customer_id, ROUND(AVG(ro.distance), 1) AS avg_distance
FROM
    runner_orders ro
        JOIN
    customer_orders co ON ro.order_id = co.order_id
GROUP BY 1;
```

| customer_id | avg_distance |
|-------------|--------------|
| 101         | 13.3         |
| 102         | 16.7         |
| 103         | 17.5         |
| 104         | 10           |
| 105         | 25           |

### **Q5. What was the difference between the longest and shortest delivery times for all orders?**
```SQL
SELECT
  MAX(duration) - MIN(duration) AS difference
FROM runner_orders;
```

| difference |
|------------|
| 30         |

### **Q6. What was the average speed for each runner for each delivery and do you notice any trend for these values?**
```SQL
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
```

| runner_id | order_id  | distance  | duration | no_pizzas | avg_speed |
|---------- |-----------|-----------|----------|-----------|-----------|
| 1         | 1         | 20        | 32       | 1         | 37.5      |
| 1         | 2         | 20        | 27       | 1         | 44.4      |
| 1         | 3         | 13.4      | 20       | 2         | 40.2      |
| 1         | 10        | 10        | 10       | 2         | 60        |
| 2         | 4         | 23.4      | 40       | 3         | 35.1      |
| 2         | 7         | 25        | 25       | 1         | 60        |
| 2         | 8         | 23.4      | 15       | 1         | 93.6      |
| 3         | 5         | 10        | 15       | 1         | 40        |

**Finding:**
- #NOTE: DURATION(MINUTE)
- Runners had an average speed from 35.1 km/h to 44.4km/h,
>*there is no clear trend that the number of pizzas affects the delivery speed of an order.*
  

### **Q7. What is the successful delivery percentage for each runner?**
```sql
SELECT 
    runner_id,
    COUNT(order_id) AS total_orders,
    COUNT(pickup_time) AS suc_deliveries,
    100 * COUNT(pickup_time) / COUNT(order_id) AS suc_pct
FROM
    runner_orders
GROUP BY 1;
```

| runner_id | total_orders | suc_deliveries| suc_pct          |
|-----------|--------------|---------------|------------------|
| 1         | 4            | 4             | 100              |
| 2         | 4            | 3             | 75               |
| 3         | 2            | 1             | 50               |


</details>

<details>
<summary>
Ingredient Optimisation
</summary>

### Data cleaning
**1. Because we cannot match directly toppings_name and topping_id so we have to  create a new temporary table #toppingsBreak to separate toppings into multiple rows**
```TSQL
DROP TABLE IF EXISTS toppingsBreak;
CREATE TEMPORARY TABLE toppingsBreak AS
SELECT 
  pizza_id,
  TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(toppings, ',', n), ',', -1)) AS topping_id,
  pt.topping_name
FROM pizza_recipes pr
CROSS JOIN (
  SELECT 1 AS n UNION SELECT 2 UNION SELECT 3 UNION SELECT 4
) AS numbers
JOIN pizza_toppings pt
  ON TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(toppings, ',', n), ',', -1)) = pt.topping_id
WHERE n <= 1 + (LENGTH(toppings) - LENGTH(REPLACE(toppings, ',', '')));

SELECT 
    *
FROM
    toppingsBreak;
```
  
| pizza_id | topping_id | topping_name  |
|----------|------------|---------------|
| 1        | 1          | Bacon         |
| 1        | 2          | BBQ Sauce     |
| 1        | 3          | Beef          |
| 1        | 4          | Cheese        |
| 1        | 5          | Chicken       |
| 1        | 6          | Mushrooms     |
| 1        | 8          | Pepperoni     |
| 1        | 10         | Salami        |
| 2        | 4          | Cheese        |
| 2        | 6          | Mushrooms     |
| 2        | 7          | Onions        |
| 2        | 9          | Peppers       |
| 2        | 11         | Tomatoes      |
| 2        | 12         | Tomato Sauce  |
| 3        | 1          | Bacon         |
| 3        | 2          | BBQ Sauce     |
| 3        | 3          | Beef          |
| 3        | 4          | Cheese        |
| 3        | 5          | Chicken       |
| 3        | 6          | Mushrooms     |
| 3        | 7          | Onions        |
| 3        | 8          | Pepperoni     |
| 3        | 9          | Peppers       |
| 3        | 10         | Salami        |
| 3        | 11         | Tomatoes      |
| 3        | 12         | Tomato Sauce  |


**2. Create a new temporary table extrasBreak to separate extras into multiple rows**
```SQL
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
```
  
| order_id  | extra_id  |
|-----------|-----------|
| 1         |           |
| 2         |           |
| 3         |           |
| 3         |           |
| 4         |           |
| 4         |           |
| 5         |  1         |
| 6         | 1         |
| 7         |           |
| 8        |        |
| 9        |  5         |
| 9        | 1         |
| 10        |         |
| 10        |  4         |
| 10        | 1         |


**3. Create a new temporary table exclusionBreak to separate exclusions into multiple rows**
```TSQL
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
```
  
| order_id  | exclusion_id  |
|-----------|---------------|
| 1         |               |
| 2         |               |
| 3         |               |
| 3         |               |
| 4         | 4             |
| 4         | 4             |
| 4         | 4             |
| 5         |               |
| 6         |               |
| 7        |               |
| 8        |               |
| 9        | 4             |
| 10        |               |
| 10        | 2             |
| 10        | 6             |

---
### Q1. What are the standard ingredients for each pizza?
```TSQL
SELECT 
    p.pizza_name, GROUP_CONCAT(topping_name, ',') AS ingredients
FROM
    toppingsBreak t
        JOIN
    pizza_names p ON t.pizza_id = p.pizza_id
GROUP BY p.pizza_name;
```
  
| pizza_name | ingredients                                                            |
|------------|------------------------------------------------------------------------|
| Meatlovers | Bacon, BBQ Sauce, Beef, Cheese, Chicken, Mushrooms, Pepperoni, Salami  |
| Vegetarian | Cheese, Mushrooms, Onions, Peppers, Tomatoes, Tomato Sauce             |

---
### Q2. What was the most commonly added extra?
```TSQL
SELECT 
    pt.topping_name, COUNT(extra_id) AS no_extras
FROM
    pizza_toppings pt
        JOIN
    extrasbreak e ON e.extra_id = pt.topping_id
GROUP BY 1
ORDER BY 2 DESC;
```
  
| topping_name | extra_count  |
|--------------|--------------|
| Bacon        | 4            |
| Cheese       | 1            |
| Chicken      | 1            |

The most commonly added extra was Bacon.

---
### Q3. What was the most common exclusion?
```TSQL
SELECT 
    pt.topping_name, COUNT(exclusions_id) AS no_exclusions
FROM
    pizza_toppings pt
        JOIN
    exclusionsbreak e ON e.exclusions_id = pt.topping_id
GROUP BY 1
ORDER BY 2 DESC;
```
  
| topping_name | exclusion_count  |
|--------------|------------------|
| Cheese       | 4                |
| Mushrooms    | 1                |
| BBQ Sauce    | 1                |

The most common exclusion was Cheese.

---
### Q4.Generate an order item for each record in the ```customers_orders``` table in the format of one of the following
* ```Meat Lovers```
* ```Meat Lovers - Exclude Beef```
* ```Meat Lovers - Extra Bacon```
* ```Meat Lovers - Exclude Cheese, Bacon - Extra Mushroom, Peppers```

To solve this question:
* Create 3 CTEs: ```extras_cte```, ```exclusions_cte```, and ```union_cte``` combining two tables
* Use the ```union_cte``` to LEFT JOIN with the ```customer_orders_temp``` and JOIN with the ```pizza_name```
* Use the ```CONCAT_WS``` with ```STRING_AGG``` to get the result

```TSQL
WITH cteExtras AS (
  SELECT 
    e.record_id,
    'Extra ' + STRING_AGG(t.topping_name, ', ') AS record_options
  FROM #extrasBreak e
  JOIN pizza_toppings t
    ON e.extra_id = t.topping_id
  GROUP BY e.record_id
), 
cteExclusions AS (
  SELECT 
    e.record_id,
    'Exclusion ' + STRING_AGG(t.topping_name, ', ') AS record_options
  FROM #exclusionsBreak e
  JOIN pizza_toppings t
    ON e.exclusion_id = t.topping_id
  GROUP BY e.record_id
), 
cteUnion AS (
  SELECT * FROM cteExtras
  UNION
  SELECT * FROM cteExclusions
)

SELECT 
  c.record_id,
  c.order_id,
  c.customer_id,
  c.pizza_id,
  c.order_time,
  CONCAT_WS(' - ', p.pizza_name, STRING_AGG(u.record_options, ' - ')) AS pizza_info
FROM #customer_orders_temp c
LEFT JOIN cteUnion u
  ON c.record_id = u.record_id
JOIN pizza_names p
  ON c.pizza_id = p.pizza_id
GROUP BY
  c.record_id, 
  c.order_id,
  c.customer_id,
  c.pizza_id,
  c.order_time,
  p.pizza_name
ORDER BY record_id;
```

**Table ```cteExtra```**
| record_id | record_options        |
|-----------|-----------------------|
| 8         | Extra Bacon           |
| 10        | Extra Bacon           |
| 12        | Extra Bacon, Chicken  |
| 14        | Extra Bacon, Cheese   |

**Table ```cteExclusion```**
| record_id | record_options                 |
|-----------|--------------------------------|
| 5         | Exclusion Cheese               |
| 6         | Exclusion Cheese               |
| 7         | Exclusion Cheese               |
| 12        | Exclusion Cheese               |
| 14        | Exclusion BBQ Sauce, Mushrooms |

**Table ```cteUnion```**
| record_id | record_options                  |
|-----------|---------------------------------|
| 5         | Exclusion Cheese                |
| 6         | Exclusion Cheese                |
| 7         | Exclusion Cheese                |
| 8         | Extra Bacon                     |
| 10        | Extra Bacon                     |
| 12        | Exclusion Cheese                |
| 12        | Extra Bacon, Chicken            |
| 14        | Exclusion BBQ Sauce, Mushrooms  |
| 14        | Extra Bacon, Cheese             |

**Result**
  
| record_id | order_id | customer_id | pizza_id | order_time              | pizza_info                                                        |
|-----------|----------|-------------|----------|-------------------------|-------------------------------------------------------------------|
| 1         | 1        | 101         | 1        | 2020-01-01 18:05:02.000 | Meatlovers                                                        |
| 2         | 2        | 101         | 1        | 2020-01-01 19:00:52.000 | Meatlovers                                                        |
| 3         | 3        | 102         | 1        | 2020-01-02 23:51:23.000 | Meatlovers                                                        |
| 4         | 3        | 102         | 2        | 2020-01-02 23:51:23.000 | Vegetarian                                                        |
| 5         | 4        | 103         | 1        | 2020-01-04 13:23:46.000 | Meatlovers - Exclusion Cheese                                     |
| 6         | 4        | 103         | 1        | 2020-01-04 13:23:46.000 | Meatlovers - Exclusion Cheese                                     |
| 7         | 4        | 103         | 2        | 2020-01-04 13:23:46.000 | Vegetarian - Exclusion Cheese                                     |
| 8         | 5        | 104         | 1        | 2020-01-08 21:00:29.000 | Meatlovers - Extra Bacon                                          |
| 9         | 6        | 101         | 2        | 2020-01-08 21:03:13.000 | Vegetarian                                                        |
| 10        | 7        | 105         | 2        | 2020-01-08 21:20:29.000 | Vegetarian - Extra Bacon                                          |
| 11        | 8        | 102         | 1        | 2020-01-09 23:54:33.000 | Meatlovers                                                        |
| 12        | 9        | 103         | 1        | 2020-01-10 11:22:59.000 | Meatlovers - Exclusion Cheese - Extra Bacon, Chicken              |
| 13        | 10       | 104         | 1        | 2020-01-11 18:34:49.000 | Meatlovers                                                        |
| 14        | 10       | 104         | 1        | 2020-01-11 18:34:49.000 | Meatlovers - Exclusion BBQ Sauce, Mushrooms - Extra Bacon, Cheese |

---
### Q5. Generate an alphabetically ordered comma separated ingredient list for each pizza order from the ```customer_orders``` table and add a 2x in front of any relevant ingredients.
* For example: ```"Meat Lovers: 2xBacon, Beef, ... , Salami"```

To solve this question:
* Create a CTE in which each line displays an ingredient for an ordered pizza (add '2x' for extras and remove exclusions as well)
* Use ```CONCAT``` and ```STRING_AGG``` to get the result

```TSQL
WITH ingredients AS (
  SELECT 
    c.*,
    p.pizza_name,

    -- Add '2x' in front of topping_names if their topping_id appear in the #extrasBreak table
    CASE WHEN t.topping_id IN (
          SELECT extra_id 
          FROM #extrasBreak e 
          WHERE e.record_id = c.record_id)
      THEN '2x' + t.topping_name
      ELSE t.topping_name
    END AS topping

  FROM #customer_orders_temp c
  JOIN #toppingsBreak t
    ON t.pizza_id = c.pizza_id
  JOIN pizza_names p
    ON p.pizza_id = c.pizza_id

  -- Exclude toppings if their topping_id appear in the #exclusionBreak table
  WHERE t.topping_id NOT IN (
      SELECT exclusion_id 
      FROM #exclusionsBreak e 
      WHERE c.record_id = e.record_id)
)

SELECT 
  record_id,
  order_id,
  customer_id,
  pizza_id,
  order_time,
  CONCAT(pizza_name + ': ', STRING_AGG(topping, ', ')) AS ingredients_list
FROM ingredients
GROUP BY 
  record_id, 
  record_id,
  order_id,
  customer_id,
  pizza_id,
  order_time,
  pizza_name
ORDER BY record_id;
```
  
| record_id | order_id | customer_id | pizza_id | order_time              | ingredients_list                                                                     |
|-----------|----------|-------------|----------|-------------------------|--------------------------------------------------------------------------------------|
| 1         | 1        | 101         | 1        | 2020-01-01 18:05:02.000 | Meatlovers: Bacon, BBQ Sauce, Beef, Chicken, Mushrooms, Pepperoni, Salami, Cheese    |
| 2         | 2        | 101         | 1        | 2020-01-01 19:00:52.000 | Meatlovers: Cheese, Salami, Pepperoni, Mushrooms, Chicken, Beef, BBQ Sauce, Bacon    |
| 3         | 3        | 102         | 1        | 2020-01-02 23:51:23.000 | Meatlovers: Bacon, BBQ Sauce, Beef, Chicken, Mushrooms, Pepperoni, Salami, Cheese    |
| 4         | 3        | 102         | 2        | 2020-01-02 23:51:23.000 | Vegetarian: Mushrooms, Onions, Peppers, Tomatoes, Tomato Sauce, Cheese               |
| 5         | 4        | 103         | 1        | 2020-01-04 13:23:46.000 | Meatlovers: Salami, Pepperoni, Mushrooms, Chicken, Beef, BBQ Sauce, Bacon            |
| 6         | 4        | 103         | 1        | 2020-01-04 13:23:46.000 | Meatlovers: Bacon, BBQ Sauce, Beef, Chicken, Mushrooms, Pepperoni, Salami            |
| 7         | 4        | 103         | 2        | 2020-01-04 13:23:46.000 | Vegetarian: Mushrooms, Tomato Sauce, Tomatoes, Peppers, Onions                       |
| 8         | 5        | 104         | 1        | 2020-01-08 21:00:29.000 | Meatlovers: Cheese, Salami, Pepperoni, Mushrooms, Chicken, Beef, BBQ Sauce, 2xBacon  |
| 9         | 6        | 101         | 2        | 2020-01-08 21:03:13.000 | Vegetarian: Mushrooms, Onions, Peppers, Tomatoes, Tomato Sauce, Cheese               |
| 10        | 7        | 105         | 2        | 2020-01-08 21:20:29.000 | Vegetarian: Cheese, Tomato Sauce, Tomatoes, Peppers, Onions, Mushrooms               |
| 11        | 8        | 102         | 1        | 2020-01-09 23:54:33.000 | Meatlovers: Cheese, Salami, Mushrooms, Pepperoni, Bacon, BBQ Sauce, Beef, Chicken    |
| 12        | 9        | 103         | 1        | 2020-01-10 11:22:59.000 | Meatlovers: 2xChicken, Beef, BBQ Sauce, 2xBacon, Pepperoni, Mushrooms, Salami        |
| 13        | 10       | 104         | 1        | 2020-01-11 18:34:49.000 | Meatlovers: Salami, Cheese, Mushrooms, Pepperoni, Bacon, BBQ Sauce, Beef, Chicken    |
| 14        | 10       | 104         | 1        | 2020-01-11 18:34:49.000 | Meatlovers: Chicken, Beef, 2xBacon, Pepperoni, 2xCheese, Salami                      |

---
### Q6. What is the total quantity of each ingredient used in all delivered pizzas sorted by most frequent first?
To solve this question:
* Create a CTE to record the number of times each ingredient was used
  * if extra ingredient, add 2 
  * if excluded ingredient, add 0
  * no extras or no exclusions, add 1
```TSQL
WITH frequentIngredients AS (
  SELECT 
    c.record_id,
    t.topping_name,
    CASE
      -- if extra ingredient, add 2
      WHEN t.topping_id IN (
          SELECT extra_id 
          FROM #extrasBreak e
          WHERE e.record_id = c.record_id) 
      THEN 2
      -- if excluded ingredient, add 0
      WHEN t.topping_id IN (
          SELECT exclusion_id 
          FROM #exclusionsBreak e 
          WHERE c.record_id = e.record_id)
      THEN 0
      -- no extras, no exclusions, add 1
      ELSE 1
    END AS times_used
  FROM #customer_orders_temp c
  JOIN #toppingsBreak t
    ON t.pizza_id = c.pizza_id
  JOIN pizza_names p
    ON p.pizza_id = c.pizza_id
)

SELECT 
  topping_name,
  SUM(times_used) AS times_used 
FROM frequentIngredients
GROUP BY topping_name
ORDER BY times_used DESC;
```
  
| topping_name | times_used  |
|--------------|-------------|
| Bacon        | 13          |
| Mushrooms    | 13          |
| Cheese       | 11          |
| Chicken      | 11          |
| Pepperoni    | 10          |
| Salami       | 10          |
| Beef         | 10          |
| BBQ Sauce    | 9           |
| Peppers      | 4           |
| Onions       | 4           |
| Tomato Sauce | 4           |
| Tomatoes     | 4           |
  


</details>

---
<p>&copy; 2023 Duyen Le Huong <p>
