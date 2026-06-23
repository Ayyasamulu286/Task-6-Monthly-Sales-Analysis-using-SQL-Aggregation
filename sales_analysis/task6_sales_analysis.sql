-- ============================================================
-- TASK 6: Sales Trend Analysis Using Aggregations
-- Tool: SQLite (compatible with PostgreSQL/MySQL with minor edits)
-- Dataset: online_sales
-- ============================================================

-- STEP 1: Create the table
CREATE TABLE IF NOT EXISTS online_sales (
    order_id   INTEGER PRIMARY KEY,
    order_date TEXT,
    amount     REAL,
    product_id TEXT
);

-- ============================================================
-- QUERY 1: Monthly Revenue & Order Volume (Core Task)
-- Groups by year and month, sums revenue, counts distinct orders
-- ============================================================
SELECT 
    strftime('%Y', order_date)  AS year,
    strftime('%m', order_date)  AS month,
    SUM(amount)                 AS total_revenue,
    COUNT(DISTINCT order_id)    AS order_volume
FROM online_sales
GROUP BY year, month
ORDER BY year, month;

-- PostgreSQL equivalent:
-- SELECT EXTRACT(YEAR FROM order_date)  AS year,
--        EXTRACT(MONTH FROM order_date) AS month,
--        SUM(amount)                    AS total_revenue,
--        COUNT(DISTINCT order_id)       AS order_volume
-- FROM online_sales
-- GROUP BY year, month
-- ORDER BY year, month;

-- ============================================================
-- QUERY 2: Top 3 Months by Total Revenue
-- ============================================================
SELECT 
    strftime('%Y', order_date)  AS year,
    strftime('%m', order_date)  AS month,
    SUM(amount)                 AS total_revenue,
    COUNT(DISTINCT order_id)    AS order_volume
FROM online_sales
GROUP BY year, month
ORDER BY total_revenue DESC
LIMIT 3;

-- ============================================================
-- QUERY 3: Revenue by Product Per Month
-- ============================================================
SELECT 
    strftime('%Y-%m', order_date) AS year_month,
    product_id,
    SUM(amount)                   AS product_revenue,
    COUNT(DISTINCT order_id)      AS order_count
FROM online_sales
GROUP BY year_month, product_id
ORDER BY year_month, product_revenue DESC;

-- ============================================================
-- QUERY 4: Cumulative Revenue Over Time (Window Function)
-- ============================================================
SELECT 
    strftime('%Y-%m', order_date)                                     AS year_month,
    SUM(amount)                                                       AS monthly_revenue,
    SUM(SUM(amount)) OVER (ORDER BY strftime('%Y-%m', order_date))    AS cumulative_revenue
FROM online_sales
GROUP BY year_month
ORDER BY year_month;

-- ============================================================
-- QUERY 5: Handle NULLs safely in aggregates
-- COALESCE ensures NULL amounts are treated as 0
-- ============================================================
SELECT 
    strftime('%Y-%m', order_date) AS year_month,
    SUM(COALESCE(amount, 0))      AS total_revenue,
    COUNT(DISTINCT order_id)      AS order_volume
FROM online_sales
GROUP BY year_month
ORDER BY year_month;
