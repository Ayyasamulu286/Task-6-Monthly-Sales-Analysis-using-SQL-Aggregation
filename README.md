# Task 6 – Sales Trend Analysis Using Aggregations

## 📌 Objective
Analyze monthly revenue and order volume from an online sales dataset using SQL aggregations.

## 🛠️ Tools Used
- SQLite (compatible with PostgreSQL / MySQL)
- Python (pandas) for data loading

## 📁 Files

| File | Description |
|------|-------------|
| `task6_sales_analysis.sql` | All SQL queries for the analysis |
| `task6_outcome_report.html` | Full results table + interview Q&A |
| `Task6_online_sales_dataset.xlsx` | Raw dataset (20 orders, Jan–Jun 2025) |

## 📊 Key Results

| Month | Revenue (₹) | Orders |
|-------|-------------|--------|
| January 2025 | 1,500 | 3 |
| February 2025 | 1,800 | 3 |
| March 2025 | 2,800 | 4 |
| April 2025 | 2,750 | 3 |
| May 2025 | 2,650 | 3 |
| **June 2025** | **3,950** | **4** |

**Total Revenue: ₹15,450**  
**Top Month: June 2025**  
**Best Product: P102 (₹1,300 in June)**

## 🔍 SQL Concepts Used
- `GROUP BY` year and month
- `SUM()` for revenue aggregation
- `COUNT(DISTINCT order_id)` for order volume
- `ORDER BY` for sorting results
- `LIMIT` for top-N queries
- Window functions for cumulative revenue
- `COALESCE` for NULL handling

## 📈 SQL Queries Written

### Query 1 – Monthly Revenue & Order Volume
```sql
SELECT 
    strftime('%Y', order_date) AS year,
    strftime('%m', order_date) AS month,
    SUM(amount)                AS total_revenue,
    COUNT(DISTINCT order_id)   AS order_volume
FROM online_sales
GROUP BY year, month
ORDER BY year, month;
```

### Query 2 – Top 3 Months by Revenue
```sql
SELECT 
    strftime('%Y', order_date) AS year,
    strftime('%m', order_date) AS month,
    SUM(amount)                AS total_revenue,
    COUNT(DISTINCT order_id)   AS order_volume
FROM online_sales
GROUP BY year, month
ORDER BY total_revenue DESC
LIMIT 3;
```

### Query 3 – Revenue by Product Per Month
```sql
SELECT 
    strftime('%Y-%m', order_date) AS year_month,
    product_id,
    SUM(amount)                   AS product_revenue,
    COUNT(DISTINCT order_id)      AS order_count
FROM online_sales
GROUP BY year_month, product_id
ORDER BY year_month, product_revenue DESC;
```

### Query 4 – Cumulative Revenue (Window Function)
```sql
SELECT 
    strftime('%Y-%m', order_date)                                   AS year_month,
    SUM(amount)                                                     AS monthly_revenue,
    SUM(SUM(amount)) OVER (ORDER BY strftime('%Y-%m', order_date))  AS cumulative_revenue
FROM online_sales
GROUP BY year_month
ORDER BY year_month;
```

### Query 5 – NULL-Safe Aggregation
```sql
SELECT 
    strftime('%Y-%m', order_date) AS year_month,
    SUM(COALESCE(amount, 0))      AS total_revenue,
    COUNT(DISTINCT order_id)      AS order_volume
FROM online_sales
GROUP BY year_month
ORDER BY year_month;
```

## 💡 Key Insights
- Revenue shows a **consistent upward trend** from ₹1,500 (Jan) to ₹3,950 (Jun)
- **June 2025** is the highest revenue month with 4 orders
- **P102** is the best-performing product
- Total 6-month cumulative revenue: **₹15,450**

## 🎯 Outcome
Learned how to group data by time periods and analyze sales trends using SQL aggregate functions including `SUM()`, `COUNT(DISTINCT)`, `GROUP BY`, `ORDER BY`, `LIMIT`, and window functions.

---
*DataX Labs – Data Analyst Internship | Task 6*
