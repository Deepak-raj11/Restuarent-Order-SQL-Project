
-- Rename columns
ALTER TABLE menu_items
RENAME COLUMN ï»¿menu_item_id TO menu_item_id;

ALTER TABLE order_details
RENAME COLUMN ï»¿order_details_id TO order_details_id;


-- TABLE NAME - menu_items
-- 1. Show all items in the Asian category that are available. 
SELECT * FROM menu_items WHERE category = 'Asian';

-- 2. How many mexican dishes are on the menu ?
SELECT COUNT(*)
FROM menu_items
WHERE category = "mexican";

-- 3. what are the most and least expensive american dishes on the menu ?

SELECT *
FROM menu_items
WHERE category = "American"
ORDER BY price DESC;

SELECT *
FROM menu_items
WHERE category = "American"
ORDER BY price ASC;


-- 4. How many dishes are in each category ?
SELECT category ,COUNT(item_name) AS num_dishes
FROM menu_items
GROUP BY category;

-- 5. What is the average dish price ?
SELECT category ,AVG(price) AS avg_dishes
FROM menu_items
GROUP BY category;


-- TABLE NAME - order_details

-- 1. What is the date range of the table?
SELECT MIN(order_date),MAX(order_date) FROM order_details;

-- 2. How many items were ordered within this date range ?
SELECT COUNT(DISTINCT order_id) FROM order_details;


-- 3. Which orders had the most number of items ?
SELECT order_id,COUNT(item_id) AS num_items
FROM order_details
GROUP BY order_id
ORDER BY num_items DESC;

-- 4. How many orders had more than 10 items ?
SELECT COUNT(*) FROM 
(SELECT order_id,COUNT(item_id) AS num_items
FROM order_details
GROUP BY order_id
HAVING num_items > 10
ORDER BY num_items DESC) AS num_orders;

-- joins

SELECT *
FROM order_details
LEFT JOIN menu_items
ON order_details.item_id = menu_items.menu_item_id;

-- 1. What were the least and most ordered items ?
SELECT item_name, COUNT(order_details_id) AS num_purchases
FROM order_details
LEFT JOIN menu_items
ON order_details.item_id = menu_items.menu_item_id
GROUP BY item_name
ORDER BY num_purchases;

SELECT item_name, COUNT(order_details_id) AS num_purchases
FROM order_details
LEFT JOIN menu_items
ON order_details.item_id = menu_items.menu_item_id
GROUP BY item_name
ORDER BY num_purchases DESC;

-- 2. What were the most ordered items? What categories were they in ?
SELECT item_name, category,COUNT(order_details_id) AS num_purchases
FROM order_details
LEFT JOIN menu_items
ON order_details.item_id = menu_items.menu_item_id
GROUP BY item_name,category
ORDER BY num_purchases DESC;

-- 3. What were the top 5 orders that spent the most money ? 
SELECT order_id ,SUM(price) AS total_spend
FROM order_details
LEFT JOIN menu_items
ON order_details.item_id = menu_items.menu_item_id
GROUP BY order_id
ORDER BY total_spend DESC
LIMIT 5;

-- 4. Calculate the total number of orders and total revenue generated for each category ?
SELECT category, COUNT(menu_item_id) AS total_orders, SUM(price) AS total_revenue
FROM order_details
LEFT JOIN menu_items
ON order_details.item_id = menu_items.menu_item_id
GROUP BY category;

