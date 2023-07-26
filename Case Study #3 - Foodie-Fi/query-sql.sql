/* --------------------
   Case Study Questions
   --------------------*/
-- Author: Duyen Le Huong
-- Date: 07/20/2023
-- Tool used: MySQL


#A. Customer Journey
    
SELECT 
    s.*, p.plan_name, p.price
FROM
    subscriptions s
        JOIN
    plans p ON s.plan_id = p.plan_id
WHERE
    customer_id IN (1 , 2, 11, 13, 15, 16, 18, 19);

#BRIEF
-- Customer 1: Signed up for a 7-day free trial on 01/08/2020. Automatically upgraded to the basic monthly plan on 08/08/2020.

-- Customer 2: Signed up for a 7-day free trial on 20/09/2020. Upgraded to the pro annual plan on 27/09/2020.

-- Customer 11: Signed up for a 7-day free trial on 19/11/2020. Cancelled the subscription on 26/11/2020.

-- Customer 13: Signed up for a 7-day free trial on 15/12/2020. Automatically upgraded to the basic monthly plan on 22/12/2020. Upgraded to the pro monthly plan on 29/03/2020.

-- Customer 15: Signed up for a 7-day free trial on 17/03/2020. Automatically upgraded to the basic monthly plan on 24/03/2020. Cancelled the subscription on 29/03/2020.

-- Customer 16: Signed up for a 7-day free trial on 31/05/2020. Automatically upgraded to the basic monthly plan on 07/06/2020. Upgraded to the pro annual plan on 21/10/2020.

-- Customer 18: Signed up for a 7-day free trial on 06/07/2020. Upgraded to the pro monthly plan on 13/07/2020.

-- Customer 19: Signed up for a 7-day free trial on 22/06/2020. Upgraded to the pro monthly plan on 29/06/2020. Upgraded to the pro annual plan on 29/08/2020.



#B. Data Analysis Questions

-- Q1.How many customers has Foodie-Fi ever had?
SELECT 
    COUNT(DISTINCT customer_id) AS no_customers
FROM
    subscriptions;

-- Q2. What is the monthly distribution of trial plan start_date values for our dataset - use the start of the month as the group by value?
SELECT 
    MONTH(s.start_date) AS plan_month, COUNT(*) AS dist_values
FROM
    plans p
        JOIN
    subscriptions s ON p.plan_id = s.plan_id
WHERE
    p.plan_id = 0
GROUP BY 1
ORDER BY 1;

-- Q3.  What plan start_date values occur after the year 2020 for our dataset? Show the breakdown by count of events for each plan_name?
SELECT 
    plan_name,
    YEAR(s.start_date) AS events_,
    COUNT(*) AS count_of_events
FROM
    subscriptions s
        JOIN
    plans p ON s.plan_id = p.plan_id
WHERE
    YEAR(s.start_date) > 2020
GROUP BY 2 , 1;

-- Q4. What is the customer count and percentage of customers who have churned rounded to 1 decimal place?
SELECT 
  SUM(CASE WHEN p.plan_name = 'churn' THEN 1 ELSE 0 END) AS no_churn,
  Round(100 * SUM(CASE WHEN p.plan_name = 'churn' THEN 1 ELSE 0 END),1) 
    / COUNT(DISTINCT s.customer_id) AS churn_pct
FROM subscriptions s
JOIN plans p 
  ON s.plan_id = p.plan_id;
  
-- Q5. How many customers have churned straight after their initial free trial - what percentage is this rounded to the nearest whole number?

