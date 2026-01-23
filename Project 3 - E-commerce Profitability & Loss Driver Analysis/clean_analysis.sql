--CREATING TABLES

--CREATING Analysis TABLE

DROP TABLE IF EXISTS analysis;

CREATE TABLE analysis (
    order_id INTEGER,
    product_id INTEGER,
	customer_id INTEGER,
	quantity INTEGER,
	cost_price FLOAT,
    item_price FLOAT,
    discount_amount NUMERIC,
	discount_pct NUMERIC,
	shipping_fee NUMERIC,
	shipping_fee_allocated NUMERIC,
    product_revenue NUMERIC,
    product_cost NUMERIC,
	base_margin NUMERIC,
	base_margin_pct NUMERIC,
	final_margin NUMERIC,
	final_margin_pct NUMERIC,
	order_date DATE,
    order_status TEXT,
	category TEXT,
    margin_flag TEXT,
    loss_driver TEXT
    
);

-- Verification

SELECT * FROM analysis;

-- Performing Data Validation.

-- Data integrity

-- 1. Are there duplicate order_id values at the order Line grain?

SELECT
    order_id,
    product_id,
    COUNT(*) AS row_count
FROM analysis
GROUP BY order_id, product_id
HAVING COUNT(*) > 1;

-- 2. Do any orders contain zero items?

SELECT
    order_id,
    SUM(quantity) AS total_quantity
FROM analysis
GROUP BY order_id
HAVING SUM(quantity) = 0;

-- 3. Are there negative revenues or costs?

SELECT
    order_id,
    SUM(product_revenue) AS total_revenue,
    SUM(product_cost) AS total_cost
FROM analysis
GROUP BY order_id
HAVING SUM(product_revenue) < 0
    OR SUM(product_cost) < 0;

-- 4. Does total revenue equal item revenue + shipping(excluding returns) ?

SELECT
    SUM(product_revenue) + SUM(shipping_fee_allocated)
        - SUM(product_revenue + shipping_fee_allocated) AS revenue_diff
FROM analysis
WHERE order_status != 'Returned';


-- 5. Does cost aggregate linearly across groupings?

WITH
line_level AS (
    SELECT SUM(product_cost) AS line_level_cost
    FROM analysis
),
order_level AS (
    SELECT SUM(order_cost) AS order_level_cost
    FROM (
        SELECT order_id, SUM(product_cost) AS order_cost
        FROM analysis
        GROUP BY order_id
    ) t
)
SELECT
    line_level_cost,
    order_level_cost,
    line_level_cost - order_level_cost AS difference
FROM line_level, order_level;


-- 6. Are negative margins fully explained by loss_driver?

SELECT
    order_id,
    final_margin,
    final_margin_pct,
    loss_driver
FROM analysis
WHERE final_margin < 0
  AND (
        loss_driver IS NULL
        OR loss_driver = 'Normal'
      );


-- Business Logic Validation

-- 7. Are discount-driven losses associated with high discounts?

SELECT
    order_id,
    final_margin,
    discount_pct,
    loss_driver
FROM analysis
WHERE final_margin < 0
  AND loss_driver = 'Discount-Driven'
  AND discount_pct < 0.30;

-- 8. Are return-driven losses associated with returned orders?

SELECT
	order_id,
	order_status
FROM analysis
WHERE loss_driver = 'Return-Driven' AND order_status <> 'Returned';


-- Executive KPIs

-- 9. What is total revenue (excluding returns)?

SELECT 
	SUM(product_revenue + shipping_fee_allocated) AS total_revenue
FROM analysis
WHERE order_status <> 'Returned';


-- 10, What is profit margin (excluding anomalies) ?

SELECT
    SUM(final_margin)
        / NULLIF(SUM(product_revenue + shipping_fee_allocated), 0)
        AS profit_margin
FROM analysis
WHERE order_status <> 'Returned'
  AND margin_flag IN ('Healthy', 'Low Margin');

-- 11. What is return rate?

SELECT
    (CAST(COUNT(DISTINCT CASE WHEN order_status = 'Returned' THEN order_id END) AS FLOAT))
    /
    COUNT(DISTINCT order_id) * 100 AS return_rate
FROM analysis;

-- 12. What % of orders are discount-driven losses?

SELECT
	CAST(COUNT(DISTINCT CASE WHEN loss_driver = 'Discount-Driven' THEN order_id END) AS FLOAT)
	/
	COUNT(DISTINCT order_id) * 100 AS Discount_driven_orders_percentage
FROM analysis;


-- 13. What % of revenue is at low or negative margin?

SELECT
	SUM(
		CASE
			WHEN margin_flag IN ('Low Margin', 'Negative Margin')
			THEN product_revenue + shipping_fee_allocated
			ELSE 0 
		END
	)
	/
	SUM(product_revenue + shipping_fee_allocated) * 100 AS Revenue_percentage
From analysis
WHERE order_status <> 'Returned';


-- Final Move of coding [ OFFICIALIZATION THINGS THAT'S MATTER ]

-- What are Official Numbers

-- Total Revenue ( excluding returns )

SELECT 
	SUM(product_revenue + shipping_fee_allocated) AS total_revenue
FROM analysis
WHERE order_status <> 'Returned';

-- Total profit (final_margin)

SELECT 
    SUM(final_margin) AS total_profit
FROM analysis
WHERE order_status <> 'Returned'
  AND margin_flag IN ('Healthy', 'Low Margin');

-- Return Rate

SELECT
    ((CAST(COUNT(DISTINCT CASE WHEN order_status = 'Returned' THEN order_id END) AS FLOAT))
    /
    COUNT(DISTINCT order_id) * 100) AS return_rate
FROM analysis;

-- % of orders with loss

with loss_orders AS(
	SELECT
		DISTINCT order_id
		FROM analysis
		WHERE final_margin < 0
)
SELECT
	(COUNT(*) * 1.0
	/
	(SELECT COUNT(DISTINCT order_id) FROM analysis))
	* 100 AS pct_orders_with_loss
FROM loss_orders;


-- % revenue at low/negative margin
	
SELECT
	SUM(
		CASE
			WHEN margin_flag IN ('Low Margin', 'Negative Margin')
			THEN product_revenue + shipping_fee_allocated
			ELSE 0 
		END
	)
	/
	SUM(product_revenue + shipping_fee_allocated) * 100 AS Revenue_percentage
From analysis
WHERE order_status <> 'Returned';


-- Loss by Loss_driver

SELECT
	loss_driver,
	SUM(final_margin) AS total_loss
FROM analysis
WHERE final_margin < 0
GROUP BY loss_driver
ORDER BY total_loss;

-- What runs you without you ?

-- vw_kpi_overview

CREATE VIEW vw_kpi_overview AS
SELECT
	SUM(product_revenue + shipping_fee_allocated) AS total_revenue,
	SUM(final_margin) AS total_profit,
	SUM(final_margin) * 1.0 
	/ SUM(product_revenue + shipping_fee_allocated) AS profit_margin_pct
FROM analysis
WHERE order_status <> 'Returned';

SELECT * FROM vw_kpi_overview;


-- vw_loss_overview

CREATE VIEW vw_loss_overview AS
WITH loss_orders AS (
    SELECT DISTINCT order_id
    FROM analysis
    WHERE final_margin < 0
)
SELECT
    COUNT(*) * 1.0
        / (SELECT COUNT(DISTINCT order_id) FROM analysis)
        * 100 AS pct_orders_with_loss
FROM loss_orders;

SELECT * FROM vw_loss_overview;

-- vw_loss_by_driver

DROP VIEW IF EXISTS vw_loss_by_driver;

CREATE VIEW vw_loss_by_driver AS
SELECT
    DATE_TRUNC('week', order_date) AS week,
    loss_driver,
    SUM(final_margin) AS total_loss
FROM analysis
WHERE final_margin < 0
GROUP BY week, loss_driver;


SELECT * FROM vw_loss_by_driver;

-- vw_category_performance

CREATE VIEW vw_category_performance AS
SELECT
    category,
    AVG(final_margin_pct) AS avg_margin_pct,
    AVG(CASE WHEN final_margin < 0 THEN 1.0 ELSE 0.0 END) AS loss_rate,
    COUNT(DISTINCT order_id) AS order_count,
    SUM(final_margin) AS total_margin
FROM analysis
WHERE order_status <> 'Returned'
GROUP BY category;

SELECT * FROM vw_category_performance;


-- vw_margin_trend_monthly

CREATE VIEW vw_margin_trend_monthly AS
SELECT
    DATE_TRUNC('month', order_date) AS month,
    AVG(final_margin_pct) AS avg_margin_pct,
    SUM(final_margin) AS total_margin
FROM analysis
WHERE order_status <> 'Returned'
GROUP BY month
ORDER BY month;

SELECT * FROM vw_margin_trend_monthly;

-- vw_loss_trend__weekly

CREATE VIEW vw_loss_trend_weekly AS
SELECT
    DATE_TRUNC('week', order_date) AS week,
    COALESCE(loss_driver, 'Unclassified') AS loss_driver,
    SUM(final_margin) AS total_loss
FROM analysis
WHERE final_margin < 0
  AND order_status <> 'Returned'
GROUP BY
    DATE_TRUNC('week', order_date),
    COALESCE(loss_driver, 'Unclassified')
ORDER BY week;



SELECT * FROM vw_loss_trend_weekly;

-- vw_loss_orders

CREATE VIEW vw_loss_orders AS
SELECT
    order_id,
    product_id,
    order_date,
    category,
    loss_driver,
    final_margin
FROM analysis
WHERE final_margin < 0;

SELECT * FROM vw_loss_orders;




