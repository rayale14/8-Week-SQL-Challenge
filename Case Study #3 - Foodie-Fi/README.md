# [8-Week SQL Challenge](https://github.com/rayale14/8-Week-SQL-Challenge) 
![Star Badge](https://img.shields.io/static/v1?label=%F0%9F%8C%9F&message=If%20Useful&style=style=flat&color=BC4E99)
[![View Main Folder](https://img.shields.io/badge/View-Main_Folder-971901?)](https://github.com/rayale14/8-Week-SQL-Challenge)
[![View Repositories](https://img.shields.io/badge/View-My_Repositories-blue?logo=GitHub)](https://github.com/rayale14?tab=repositories)
[![View My Profile](https://img.shields.io/badge/View-My_Profile-green?logo=GitHub)](https://github.com/rayale14)


# 🥑 Case Study #3 - Foodie-Fi
<p align="center">
<img src="https://github.com/ndleah/8-Week-SQL-Challenge/blob/main/IMG/org-3.png" width=40% height=40%>

## 📕 Table Of Contents
* 🛠️ [Business Task](#business-task)
* 📂 [Dataset](#dataset)
* 🧙‍♂️ [Case Study Questions](#case-study-questions)
* 🚀 [Solutions](#solutions)

## 🛠️ Business Task

Danny finds a few smart friends to launch his new startup Foodie-Fi in 2020 and started selling monthly and annual subscriptions, giving their customers unlimited on-demand access to exclusive food videos from around the world!

Danny created Foodie-Fi with a data driven mindset and wanted to ensure all future investment decisions and new features were decided using data. This case study focuses on using subscription style digital data to answer important business questions.

## 📂 Dataset
Danny has shared with you 2 key datasets for this case study:

### **```plan```**

<details>
<summary>
View table
</summary>

The plan table shows which plans customer can choose to join Foodie-Fi when they first sign up.

* **Trial:** can sign up to an initial 7 day free trial will automatically continue with the pro monthly subscription plan unless they cancel

* **Basic plan:** limited access and can only stream user videos
* **Pro plan** no watch time limits and video are downloadable with 2 subscription options: **monthly** and **annually**


| "plan_id" | "plan_name"     | "price" |
|-----------|-----------------|---------|
| 0         | "trial"         | 0.00    |
| 1         | "basic monthly" | 9.90    |
| 2         | "pro monthly"   | 19.90   |
| 3         | "pro annual"    | 199.00  |
| 4         | "churn"         | NULL    |


</details>


### **```subscriptions```**


<details>
<summary>
View table
</summary>

Customer subscriptions show the exact date where their specific ```plan_id``` starts.

If customers downgrade from a pro plan or cancel their subscription - the higher plan will remain in place until the period is over - the ```start_date``` in the ```subscriptions``` table will reflect the date that the actual plan changes.

In this part, I will display the first 20 rows of this dataset since the original one is super long:


| "customer_id" | "plan_id" | "start_date" |
|---------------|-----------|--------------|
| 1             | 0         | "2020-08-01" |
| 1             | 1         | "2020-08-08" |
| 2             | 0         | "2020-09-20" |
| 2             | 3         | "2020-09-27" |
| 3             | 0         | "2020-01-13" |
| 3             | 1         | "2020-01-20" |
| 4             | 0         | "2020-01-17" |
| 4             | 1         | "2020-01-24" |
| 4             | 4         | "2020-04-21" |
| 5             | 0         | "2020-08-03" |
| 5             | 1         | "2020-08-10" |
| 6             | 0         | "2020-12-23" |
| 6             | 1         | "2020-12-30" |
| 6             | 4         | "2021-02-26" |
| 7             | 0         | "2020-02-05" |
| 7             | 1         | "2020-02-12" |
| 7             | 2         | "2020-05-22" |
| 8             | 0         | "2020-06-11" |
| 8             | 1         | "2020-06-18" |
| 8             | 2         | "2020-08-03" |


</details>


## 🧙‍♂️ Case Study Questions

1. How many customers has Foodie-Fi ever had?
2. What is the monthly distribution of **```trial```** plan **```start_date```** values for our dataset - use the start of the month as the group by value
3. What plan **```start_date```** values occur after the year 2020 for our dataset? Show the breakdown by count of events for each **```plan_name```**
4. What is the customer count and percentage of customers who have churned rounded to 1 decimal place?
5. How many customers have churned straight after their initial free trial - what percentage is this rounded to the nearest whole number?
6. What is the number and percentage of customer plans after their initial free trial?
7. What is the customer count and percentage breakdown of all 5 **```plan_name```** values at **```2020-12-31```**?
8. How many customers have upgraded to an annual plan in 2020?
9. How many days on average does it take for a customer to an annual plan from the day they join Foodie-Fi?
10. Can you further breakdown this average value into 30 day periods (i.e. 0-30 days, 31-60 days etc)
11. How many customers downgraded from a pro monthly to a basic monthly plan in 2020?

## 🚀 Solutions

**Q1. How many customers has Foodie-Fi ever had?**
```SQL
SELECT 
    COUNT(DISTINCT customer_id) AS no_customers
FROM
    subscriptions;
```


| no_customers |
|-------------------|
| 1000              |


**Q2. What plan start_date values occur after the year 2020 for our dataset? Show the breakdown by count of events for each ```plan_name**

```SQL
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
```

plan_months | dist_values 
-------|-------
   1 |    88
   2 |    68
   3 |    94
   4 |    81
   5 |    88
   6 |    79
   7 |    89
   8 |    88
   9 |    87
  10 |    79
  11 |    75
  12 |    84



**Q3. What plan start_date values occur after the year 2020 for our dataset? Show the breakdown by count of events for each plan_name**
```SQL
SELECT 
    plan_name,
    YEAR(s.start_date) AS events,
    COUNT(*) AS count_of_events
FROM
    subscriptions s
        JOIN
    plans p ON s.plan_id = p.plan_id
WHERE
    YEAR(s.start_date) > 2020
GROUP BY 2 , 1;
```

plan_name |events| count_of_events 
--------|-------|-------
 churn | 2021|  71
 pro monthly |2021|   60
pro annual | 2021|   63
 basic monthly| 2021| 8
 

---

**Q4. What is the customer count and percentage of customers who have churned rounded to 1 decimal place?**
```SQL
SELECT 
  SUM(CASE WHEN p.plan_name = 'churn' THEN 1 ELSE 0 END) AS no_churn,
  Round(100 * SUM(CASE WHEN p.plan_name = 'churn' THEN 1 ELSE 0 END),1) 
    / COUNT(DISTINCT s.customer_id) AS churn_pct
FROM subscriptions s
JOIN plans p 
  ON s.plan_id = p.plan_id;
```

no_churn | churn_pct
-------------|-----------------
  307 |            30.7



**Q5. How many customers have churned straight after their initial free trial what percentage is this rounded to the nearest whole number?**
```SQL

```


**Q6. What is the number and percentage of customer plans after their initial free trial?**
```SQL

```


**Q7. What is the customer count and percentage breakdown of all 5 plan_name values at 2020-12-31?**
```SQL
```

**Q8. How many customers have upgraded to an annual plan in 2020?**
```SQL
```

**Q9. How many days on average does it take for a customer to an annual plan from the day they join Foodie-Fi?**
```SQL
```


**Q10. Can you further breakdown this average value into 30 day periods (i.e. 0-30 days, 31-60 days etc)**
```SQL
```


**Q11. How many customers downgraded from a pro monthly to a basic monthly plan in 2020?**

```SQL
```

---
<p>&copy; 2023 Duyen Huong Le</p>
