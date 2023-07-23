/* --------------------
   Case Study Questions
   --------------------*/
-- Author: Duyen Le Huong
-- Date: 07/17/2023
-- Tool used: MySQL

-- 1. What is the total amount each customer spent at the restaurant?
-- 2. How many days has each customer visited the restaurant?
-- 3. What was the first item from the menu purchased by each customer?
-- 4. What is the most purchased item on the menu and how many times was it purchased by all customers?
-- 5. Which item was the most popular for each customer?
-- 6. Which item was purchased first by the customer after they became a member?
-- 7. Which item was purchased just before the customer became a member?
-- 8. What are the total items and amount spent for each member before they became a member?
-- 9.  If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?
-- 10. In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - how many points do customer A and B have at the end of January?

-- 1. What is the total amount each customer spent at the restaurant?
-- Q1. What is the total amount each customer spent at the restaurant?

use dannys_diner;
SELECT 
    customer_id, SUM(m.price) AS total_spend
FROM
    sales s
        JOIN
    menu m ON s.product_id = m.product_id
GROUP BY customer_id
ORDER BY total_spend;

-- Q2. How many days has each customer visited the restaurant?
SELECT 
    customer_id, COUNT(DISTINCT order_date) AS no_visited_days
FROM
    sales
GROUP BY customer_id
ORDER BY no_visited_days;

-- Q3. What was the first item from the menu purchased by each customer?
select a.customer_id, m.product_name, a.order_date from
(
select customer_id, product_id, order_date, dense_rank() over(partition by customer_id order by order_date asc) as dr
from sales) a join menu m 
on m.product_id=a.product_id
where dr=1
group by 1,2;

-- Q4. What is the most purchased item on the menu and how many times was it purchased by all customers?
SELECT 
    s.product_id, m.product_name, COUNT(s.order_date) AS most_purchased
FROM
    sales s
        JOIN
    menu m ON s.product_id = m.product_id
GROUP BY m.product_name
ORDER BY most_purchased DESC
LIMIT 1;

-- Q5. Which item was the most popular for each customer?
select customer_id, product_name, fre_purchased from(
select customer_id,product_id, count(*) as fre_purchased, dense_rank() over(partition by customer_id order by count(*) desc) dr
from sales
group by customer_id,product_id) a
join menu m on a.product_id=m.product_id
where dr=1
order by 1;

-- Q6.Which item was purchased first by the customer after they became a member?
with dsrank as (
select s.customer_id, s.product_id, s.order_date, mb.join_date,
dense_rank() over(partition by customer_id order by order_date) dr
from sales s join members mb 
on s.customer_id=mb.customer_id 
and mb.join_date<=s.order_date)

select dsr.customer_id, dsr.order_date, dsr.join_date, m.product_name 
from dsrank dsr
join menu m 
on m.product_id=dsr.product_id
where dr=1;

-- Q7.Which item was purchased just before the customer became a member?
with dsrank as (
select s.customer_id, s.product_id, s.order_date, mb.join_date,
dense_rank() over(partition by customer_id order by order_date DESC) dr
from sales s join members mb 
on s.customer_id=mb.customer_id 
and mb.join_date>s.order_date)

select dsr.customer_id, dsr.order_date, dsr.join_date, m.product_name 
from dsrank dsr
join menu m 
on m.product_id=dsr.product_id
where dr=1;

#NOTE: Use order_date DESC because we have to retrieve item purchased just before customer became a mem

-- Q8. What is the total items and amount spent for each member before they became a member?
SELECT 
    s.customer_id,
    COUNT(s.product_id) AS total_item_purchased,
    SUM(m.price) AS total_spend
FROM
    sales s
        JOIN
    menu m ON s.product_id = m.product_id
        JOIN
    members mb ON mb.join_date > s.order_date
        AND mb.customer_id = s.customer_id
GROUP BY 1;

-- Q9.If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?

with customer_point as
(
select s.customer_id, m.product_name, m.price,
case when s.customer_id in (select customer_id from members) and m.product_name="Sushi" then m.price*20
	 when s.customer_id in (select customer_id from members) and m.product_name!="Sushi"then m.price*10 
     else 0 end as points
from sales s join menu m on s.product_id=m.product_id)

select customer_id, sum(points) as total_points
from customer_point 
group by 1;

-- Q10. In the first week after a customer joins the program (including their join date) they earn 2x points on all items,
-- not just sushi - how many points do customer A and B have at the end of January?
with customer_point as
(
select s.customer_id, s.order_date, mb.join_date,
case when s.order_date between mb.join_date and DATE_add(mb.join_date, INTERVAL 1 WEEK) then m.price*20
	when m.product_name="Sushi" then m.price*20
    else m.price*10 
	end as points
from sales s join menu m on s.product_id=m.product_id
join members mb on s.customer_id=mb.customer_id
)
select customer_id, sum(points) as total_points
from customer_point
where order_date<=last_day("2021-01-31")
group by 1;

-- BONUS QUESTIONS
-- JOIN ALL THE THINGS

Drop table if exists report;
CREATE TABLE report (
    Customer_id VARCHAR(1),
    order_date DATE,
    product_id INTEGER,
    price INTEGER,
    member VARCHAR(1)
);
INSERT INTO report
(customer_id, order_date, product_id, price, member)
VALUES
("A",2001-01-01,"curry",15,"N"),
("A",2001-01-01,"curry",10,"N"),
("A",2001-01-01,"curry",15,"Y"),
("A",2001-01-01,"curry",12,"Y"),
("A",2001-01-01,"curry",12,"Y"),
("A",2001-01-01,"curry",12,"Y"),
("A",2001-01-01,"curry",15,"N"),
("A",2001-01-01,"curry",15,"N"),
("A",2001-01-01,"curry",10,"N"),
("A",2001-01-01,"curry",12,"Y"),
("A",2001-01-01,"curry",12,"Y"),
("A",2001-01-01,"curry",12,"Y"),
("A",2001-01-01,"curry",12,"N"),
("A",2001-01-01,"curry",12,"N"),
("A",2001-01-01,"curry",12,"N");





