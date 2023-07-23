# [8-Week SQL Challenge](https://github.com/rayale14/8-Week-SQL-Challenge) 
![Star Badge](https://img.shields.io/static/v1?label=%F0%9F%8C%9F&message=If%20Useful&style=style=flat&color=BC4E99)
[![View Main Folder](https://img.shields.io/badge/View-Main_Folder-971901?)](https://github.com/rayale14/8-Week-SQL-Challenge)
[![View Repositories](https://img.shields.io/badge/View-My_Repositories-blue?logo=GitHub)](https://github.com/rayale14?tab=repositories)
[![View My Profile](https://img.shields.io/badge/View-My_Profile-green?logo=GitHub)](https://github.com/rayale14)

# 🍜 Case Study #1 - Danny's Diner
<p align="center">
<img src="/IMG/org-1.png" width=40% height=40%>

## 📕 Table Of Contents
* 🛠️ [Business Task](#business-task)
* 📂 [Dataset](#dataset)
* 🧙‍♂️ [Case Study Questions](#case-study-questions)
* 🚀 [Solutions](#solutions)
  
---

## 🛠️ Business Task

> Danny wants to use the data to answer a few simple questions about his customers, especially about their visiting patterns, how much money they’ve spent and also which menu items are their favourite. Having this deeper connection with his customers will help him deliver a better and more personalised experience for his loyal customers.

 <br /> 

---

## 📂 Dataset
Danny has shared with you 3 key datasets for this case study:

### **```sales```**

<details>
<summary>
View table
</summary>

The sales table captures all ```customer_id``` level purchases with an corresponding ```order_date``` and ```product_id``` information for when and what menu items were ordered.

|customer_id|order_date|product_id|
|-----------|----------|----------|
|A          |2021-01-01|1         |
|A          |2021-01-01|2         |
|A          |2021-01-07|2         |
|A          |2021-01-10|3         |
|A          |2021-01-11|3         |
|A          |2021-01-11|3         |
|B          |2021-01-01|2         |
|B          |2021-01-02|2         |
|B          |2021-01-04|1         |
|B          |2021-01-11|1         |
|B          |2021-01-16|3         |
|B          |2021-02-01|3         |
|C          |2021-01-01|3         |
|C          |2021-01-01|3         |
|C          |2021-01-07|3         |

 </details>

### **```menu```**

<details>
<summary>
View table
</summary>

The menu table maps the ```product_id``` to the actual ```product_name``` and price of each menu item.

|product_id |product_name|price     |
|-----------|------------|----------|
|1          |sushi       |10        |
|2          |curry       |15        |
|3          |ramen       |12        |

</details>

### **```members```**

<details>
<summary>
View table
</summary>

The final members table captures the ```join_date``` when a ```customer_id``` joined the beta version of the Danny’s Diner loyalty program.

|customer_id|join_date |
|-----------|----------|
|A          |1/7/2021  |
|B          |1/9/2021  |

 </details>

## 🧙‍♂️ Case Study Questions
<p align="center">
<img src="https://giphy.com/gifs/season-13-the-simpsons-13x22-3orifdc6hhLcRDDCuc" width=80% height=80%>

1. What is the total amount each customer spent at the restaurant?
2. How many days has each customer visited the restaurant?
3. What was the first item from the menu purchased by each customer?
4. What is the most purchased item on the menu and how many times was it purchased by all customers?
5. Which item was the most popular for each customer?
6. Which item was purchased first by the customer after they became a member?
7. Which item was purchased just before the customer became a member?
8. What is the total items and amount spent for each member before they became a member?
9. If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?
10. In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - how many points do customer A and B have at the end of January?

 <br /> 

## 🚀 My Solutions

### **Q1. What is the total amount each customer spent at the restaurant?**
```sql
SELECT 
    customer_id, SUM(m.price) AS total_spend
FROM
    sales s
        JOIN
    menu m ON s.product_id = m.product_id
GROUP BY customer_id
ORDER BY total_spend;
```

| customer_id | total_spent |
| ----------- | ----------- |
| C           | 36          |
| B           | 74          |
| A           | 76          |

---

### **Q2. How many days has each customer visited the restaurant?**
```sql
SELECT 
    customer_id, COUNT(DISTINCT order_date) AS no_visited_days
FROM
    sales
GROUP BY customer_id
ORDER BY no_visited;
```

|customer_id|no_visited_days|
|-----------|---------------|
|C          |2              |
|A          |4              |
|B          |6              |


---

### **Q3. What was the first item from the menu purchased by each customer?**
```sql
select a.customer_id, m.product_name, a.order_date from
(
select customer_id, product_id, order_date, dense_rank() over(partition by customer_id order by order_date asc) as dr
from sales) a join menu m 
on m.product_id=a.product_id
where dr=1
group by 1,2;
```

**Result:**
| customer_id | product_name | order_date |
| ----------- | ------------ | ---------- |
| A           | sushi        | 2021-01-01 |
| A           | curry        | 2021-01-01 |
| B           | curry        | 2021-01-01 |
| C           | ramen        | 2021-01-01 |
---

### **Q4. What is the most purchased item on the menu and how many times was it purchased by all customers?**
```sql
SELECT 
    s.product_id, m.product_name, COUNT(s.order_date) AS most_purchased
FROM
    sales s
        JOIN
    menu m ON s.product_id = m.product_id
GROUP BY m.product_name
ORDER BY most_purchased DESC
LIMIT 1;
```

|product_id|product_name|most_purchased|
|----------|------------|--------------|
|3         |ramen       |8             |
---

### **Q5. Which item was the most popular for each customer?**
```sql
select customer_id, product_name, fre_purchased from(
select customer_id,product_id, count(*) as purchased_freq, dense_rank() over(partition by customer_id order by count(*) desc) dr
from sales
group by customer_id,product_id) a
join menu m on a.product_id=m.product_id
where dr=1
order by 1;
```

| customer_id | product_name | fre_purchased |
| ----------- | ------------ | ------------- |
| A           | ramen        | 3             |
| B           | sushi        | 2             |
| B           | curry        | 2             |
| B           | ramen        | 2             |
| C           | ramen        | 3             |
---

### **Q6. Which item was purchased first by the customer after they became a member?**
```sql
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
```

| customer_id | join_date    | order_date | purchase_name  |
| ----------- | ------------ | ---------- | -------------- |
| B           | 2021-01-11   | 2021-01-09 | sushi          |
| A           | 2021-01-07   | 2021-01-07 | curry          |

---

### **Q7. Which item was purchased just before the customer became a member?**
```sql
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
--NOTE: Use order_date DESC because we have to retrieve item purchased just before customer became a mem

```

| customer_id | order_date | join_date   | purchase_name |
| ----------- | ---------- | ----------- | ------------- |
| A           | 2021-01-01 | 2021-01-01  | sushi         |
| B           | 2021-01-04 | 2021-01-01  | sushi         |
| A           | 2021-01-01 | 2021-01-04  | curry         |

---

### **Q8. What is the total items and amount spent for each member before they became a member?**
```sql
SELECT 
    s.customer_id,
    COUNT(s.product_id) AS total_item_purch,
    SUM(m.price) AS total_spend
FROM
    sales s
        JOIN
    menu m ON s.product_id = m.product_id
        JOIN
    members mb ON mb.join_date > s.order_date
        AND mb.customer_id = s.customer_id
GROUP BY 1;
```

| customer_id | total_item_purch | total_spend |
| ----------- | ---------------- | ----------- |
| B           | 3                | 40          |
| A           | 2                | 25          |


---

### **Q9. If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?**
```sql
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
```

| customer_id | total_points |
| ----------- | ------------ |
| A           | 860          |
| B           | 940          |
| C           | 0            |

---

### **Q10. In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - how many points do customer A and B have at the end of January?**
```sql
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
```

| customer_id | total_points |
| ----------- | ------------ |
| B           | 940          |
| A           | 1370         |

---
<p>&copy; 2023 Duyen Le Huong</p>


