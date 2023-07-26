# [8-Week SQL Challenge](https://github.com/rayale14/8-Week-SQL-Challenge) 
![Star Badge](https://img.shields.io/static/v1?label=%F0%9F%8C%9F&message=If%20Useful&style=style=flat&color=BC4E99)
[![View Main Folder](https://img.shields.io/badge/View-Main_Folder-971901?)](https://github.com/rayale14/8-Week-SQL-Challenge)
[![View Repositories](https://img.shields.io/badge/View-My_Repositories-blue?logo=GitHub)](https://github.com/rayale14?tab=repositories)
[![View My Profile](https://img.shields.io/badge/View-My_Profile-green?logo=GitHub)](https://github.com/rayale14)



# 🌲 Case Study #7 - Balanced Tree Clothing Co.
<p align="center">
<img src="/IMG/org-7.png" width=40% height=40%>

## 📕 Table Of Contents
  - 🛠️ [Problem Statement](#problem-statement)
  - 📂 [Dataset](#dataset)
  - 🧙‍♂️ [Case Study Questions](#case-study-questions)
  -  🚀 [Solutions](#-solutions)

## 🛠️ Problem Statement

> Balanced Tree Clothing Company prides themselves on providing an optimised range of clothing and lifestyle wear for the modern adventurer!
> 
> Danny, the CEO of this trendy fashion company has asked you to assist the team’s merchandising teams analyse their sales performance and generate a basic financial report to share with the wider business.

## 📂 Dataset
For this case study there is a total of 4 datasets for this case study. However you will only need to utilise 2 main tables to solve all of the regular questions:

### **```Product Details```**

<details>
<summary>
View table
</summary>

`balanced_tree.product_details` includes all information about the entire range that Balanced Clothing sells in their store.

| "product_id" | "price" | "product_name"                     | "category_id" | "segment_id" | "style_id" | "category_name" | "segment_name" | "style_name"          |
|--------------|---------|------------------------------------|---------------|--------------|------------|-----------------|----------------|-----------------------|
| "c4a632"     | 13      | "Navy Oversized Jeans - Womens"    | 1             | 3            | 7          | "Womens"        | "Jeans"        | "Navy Oversized"      |
| "e83aa3"     | 32      | "Black Straight Jeans - Womens"    | 1             | 3            | 8          | "Womens"        | "Jeans"        | "Black Straight"      |
| "e31d39"     | 10      | "Cream Relaxed Jeans - Womens"     | 1             | 3            | 9          | "Womens"        | "Jeans"        | "Cream Relaxed"       |
| "d5e9a6"     | 23      | "Khaki Suit Jacket - Womens"       | 1             | 4            | 10         | "Womens"        | "Jacket"       | "Khaki Suit"          |
| "72f5d4"     | 19      | "Indigo Rain Jacket - Womens"      | 1             | 4            | 11         | "Womens"        | "Jacket"       | "Indigo Rain"         |
| "9ec847"     | 54      | "Grey Fashion Jacket - Womens"     | 1             | 4            | 12         | "Womens"        | "Jacket"       | "Grey Fashion"        |
| "5d267b"     | 40      | "White Tee Shirt - Mens"           | 2             | 5            | 13         | "Mens"          | "Shirt"        | "White Tee"           |
| "c8d436"     | 10      | "Teal Button Up Shirt - Mens"      | 2             | 5            | 14         | "Mens"          | "Shirt"        | "Teal Button Up"      |
| "2a2353"     | 57      | "Blue Polo Shirt - Mens"           | 2             | 5            | 15         | "Mens"          | "Shirt"        | "Blue Polo"           |
| "f084eb"     | 36      | "Navy Solid Socks - Mens"          | 2             | 6            | 16         | "Mens"          | "Socks"        | "Navy Solid"          |
| "b9a74d"     | 17      | "White Striped Socks - Mens"       | 2             | 6            | 17         | "Mens"          | "Socks"        | "White Striped"       |
| "2feb6b"     | 29      | "Pink Fluro Polkadot Socks - Mens" | 2             | 6            | 18         | "Mens"          | "Socks"        | "Pink Fluro Polkadot" |

</details>

### **```Product Sales```**

<details>
<summary>
View table
</summary>

`balanced_tree.sales` contains product level information for all the transactions made for Balanced Tree including quantity, price, percentage discount, member status, a transaction ID and also the transaction timestamp.

Below is the display of the first 10 rows in this dataset:


| "prod_id" | "qty" | "price" | "discount" | "member" | "txn_id" | "start_txn_time"           |
|-----------|-------|---------|------------|----------|----------|----------------------------|
| "c4a632"  | 4     | 13      | 17         | True     | "54f307" | "2021-02-13 01:59:43.296"  |
| "5d267b"  | 4     | 40      | 17         | True     | "54f307" | "2021-02-13 01:59:43.296"  |
| "b9a74d"  | 4     | 17      | 17         | True     | "54f307" | "2021-02-13 01:59:43.296"  |
| "2feb6b"  | 2     | 29      | 17         | True     | "54f307" | "2021-02-13 01:59:43.296"  |
| "c4a632"  | 5     | 13      | 21         | True     | "26cc98" | "2021-01-19 01:39:00.3456" |
| "e31d39"  | 2     | 10      | 21         | True     | "26cc98" | "2021-01-19 01:39:00.3456" |
| "72f5d4"  | 3     | 19      | 21         | True     | "26cc98" | "2021-01-19 01:39:00.3456" |
| "2a2353"  | 3     | 57      | 21         | True     | "26cc98" | "2021-01-19 01:39:00.3456" |
| "f084eb"  | 3     | 36      | 21         | True     | "26cc98" | "2021-01-19 01:39:00.3456" |
| "c4a632"  | 1     | 13      | 21         | False    | "ef648d" | "2021-01-27 02:18:17.1648" |

</details>


## 🧙‍♂️ Case Study Questions
<p align="center">


### **A. High Level Sales Analysis**

1. What was the total quantity sold for all products?
2. What is the total generated revenue for all products before discounts?
3. What was the total discount amount for all products?


### **B. Transaction Analysis**

1. How many unique transactions were there?
2. What is the average unique products purchased in each transaction?
3. What are the 25th, 50th and 75th percentile values for the revenue per transaction?
4. What is the average discount value per transaction?
5. What is the percentage split of all transactions for members vs non-members?
6. What is the average revenue for member transactions and non-member transactions?

### **C. Product Analysis**

1. What are the top 3 products by total revenue before discount?
2. What is the total quantity, revenue and discount for each segment?
3. What is the top selling product for each segment?
4. What is the total quantity, revenue and discount for each category?
5. What is the top selling product for each category?
6. What is the percentage split of revenue by product for each segment?
7. What is the percentage split of revenue by segment for each category?
8. What is the percentage split of total revenue by category?
9. What is the total transaction “penetration” for each product?
10. What is the most common combination of at least 1 quantity of any 3 products in a 1 single transaction?


## 🚀 Solutions
### **A. High Level Sales Analysis**

<details>
<summary>
View solutions
</summary>

**Q1. What was the total quantity sold for all products?**
```sql
```


```sql
```


**Q2. What is the total generated revenue for all products before discounts?**
```sql
```




```sql
```



**Q3. What was the total discount amount for all products?**
```sql
```

</details>

---

### **B. Transaction Analysis**

<details>
<summary>
View solutions
</summary>

**Q1. How many unique transactions were there?**

```sql
```





**Q2. What is the average unique products purchased in each transaction?**
```sql
```


**Q3. What are the 25th, 50th and 75th percentile values for the revenue per transaction?**
```sql
```

**Q4. What is the average discount value per transaction?**
```sql
```


**Q5. What is the percentage split of all transactions for members vs non-members?**
```sql
```




**Q6. What is the average revenue for member transactions and non-member transactions?**
```sql
```



</details>

---

### **C. Product Analysis**

<details>
<summary>
View solutions
</summary>

**Q1. What are the top 3 products by total revenue before discount?**
```sql
```




**Q2. What is the total quantity, revenue and discount for each segment?**
```sql
```


**Q3. What is the top selling product for each segment?**
```sql
```



**Q4. What is the total quantity, revenue and discount for each category?**
```sql
```



**Q5. What is the top selling product for each category?**
```sql
```



**Q6. What is the percentage split of revenue by product for each segment?**
```sql
```



**Q7. What is the percentage split of revenue by segment for each category?**
```sql
```


**Q8. What is the percentage split of total revenue by category?**
```sql
```



**Q9. What is the total transaction “penetration” for each product?**
```sql
```


**Q10.  What is the most common combination of at least 1 quantity of any 3 products in a 1 single transaction?**
```sql

```



</details>

---
<p>&copy; 2023 Duyen Huong Le</p>
