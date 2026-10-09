select * from customers
;

with row_numbers as 
(
select customer_id, company_name, country, industry, employee_count, devices_managed, customer_start_date, customer_status, annual_revenue, 
acquisition_source, plan,
row_number() over(partition by customer_id, company_name, country, industry, employee_count, devices_managed, customer_start_date, customer_status, annual_revenue, 
acquisition_source, plan) as row_num
from customers
)
select *
from row_numbers
where row_num > 1
;


CREATE TABLE `customers2` (
  `customer_id` text,
  `company_name` text,
  `country` text,
  `industry` text,
  `employee_count` int DEFAULT NULL,
  `devices_managed` int DEFAULT NULL,
  `customer_start_date` text,
  `customer_status` text,
  `annual_revenue` int DEFAULT NULL,
  `acquisition_source` text,
  `plan` text,
  `row_num` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
;

insert into customers2
select customer_id, company_name, country, industry, employee_count, devices_managed, customer_start_date, customer_status, annual_revenue, 
acquisition_source, plan,
row_number() over(partition by customer_id, company_name, country, industry, employee_count, devices_managed, customer_start_date, customer_status, annual_revenue, 
acquisition_source, plan) as row_num
from customers
;

delete 
from customers2
where row_num > 1
;

select *
from customers2
;

SELECT STR_TO_DATE
(customer_start_date, '%Y-%m-%d')
FROM customers2;

update customers2
set customer_start_date = STR_TO_DATE
(customer_start_date, '%Y-%m-%d');

ALTER TABLE customers2
MODIFY COLUMN customer_start_date DATE
;

select distinct company_name
from customers2
;

select distinct country
from customers2
;

delete
from customers2
where country = ''
;

UPDATE customers2
Set country = 'United States'
WHERE country = 'US'
;

UPDATE customers2
Set country = 'United States'
WHERE country = 'USA'
;

UPDATE customers2
Set country = 'United Kingdom'
WHERE country = 'UK'
;

select distinct country
from customers2
;

select distinct industry
from customers2
;

select *
from customers2
where employee_count is null
;

select *
from customers2
where devices_managed = ''
;

select *
from customers2
where customer_start_date is null
;

select *
from customers2
where annual_revenue = ''
;

select distinct customer_status
from customers2
;

select distinct acquisition_source
from customers2
;

select distinct plan
from customers2
;

alter table customers2
drop column row_num
;

select *
from customers2
;


select *
from experiment
;

with row_numbers2 as 
(
select experiment_id, customer_id, `group`, baseline_weekly_actions, post_weekly_actions, target_feature_adopted, 
row_number() over(partition by experiment_id, customer_id, `group`, baseline_weekly_actions, post_weekly_actions, target_feature_adopted) as row_num
from experiment
)
select *
from row_numbers2
where row_num > 1
;

select*
from experiment 
where experiment_id = ''
;

select*
from experiment 
where customer_id = ''
;

select*
from experiment 
where `group` = ''
;

select distinct `group`
from experiment
;

select*
from experiment 
where baseline_weekly_actions is null
;

select*
from experiment 
where post_weekly_actions is null
;

select*
from experiment 
where target_feature_adopted is null
;

CREATE TABLE `experiment` (
  `experiment_id` text,
  `customer_id` text,
  `group` text,
  `baseline_weekly_actions` int DEFAULT NULL,
  `post_weekly_actions` int DEFAULT NULL,
  `target_feature_adopted` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

select * 
from experiment 
;

select*
from orders 
;

with row_numbers3 as 
(
select order_id, customer_id, device_type, device_model, quantity, order_date, delivery_date, order_status, country, order_value,
row_number() over(partition by order_id, customer_id, device_type, device_model, quantity, order_date, delivery_date, 
order_status, country, order_value) as row_num
from orders
)
select *
from row_numbers3
where row_num > 1
;

select distinct device_type
from orders
;

select distinct device_model
from orders
;

select distinct order_status
from orders
;

select distinct country
from orders
;

UPDATE orders
Set country = 'United States'
WHERE country = 'US'
;

UPDATE orders
Set country = 'United States'
WHERE country = 'USA'
;

UPDATE orders
Set country = 'United Kingdom'
WHERE country = 'UK'
;

select *
from orders
where order_id = ''
;

select *
from orders
where customer_id is null
;

select *
from orders
where order_value = ''
;

select *
from orders
where quantity is null
;

select *
from orders
where order_date = ''
;


select *
from orders
where delivery_date = ''
;

select *
from orders
where order_status = 'failed'
;

select *
from orders
where order_status = 'cancelled'
;

select *
from orders
where order_status = 'In Transit'
;

select *
from orders
where order_status = 'failed' or  order_status = 'cancelled' or order_status = 'In Transit'
;

update orders
set delivery_date = ''
where order_status = 'failed' or  order_status = 'cancelled' or order_status = 'In Transit'
;

select *
from orders;

CREATE TABLE `orders` (
  `order_id` text,
  `customer_id` text,
  `device_type` text,
  `device_model` text,
  `quantity` int DEFAULT NULL,
  `order_date` text,
  `delivery_date` text,
  `order_status` text,
  `country` text,
  `order_value` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT STR_TO_DATE
(order_date, '%Y-%m-%d')
FROM orders;

update orders
set order_date = STR_TO_DATE
(order_date, '%Y-%m-%d');

ALTER TABLE orders
MODIFY COLUMN order_date DATE
;

SELECT STR_TO_DATE
(delivery_date, '%Y-%m-%d')
FROM orders;

update orders
set delivery_date = STR_TO_DATE
(delivery_date, '%Y-%m-%d');

ALTER TABLE orders
MODIFY COLUMN delivery_date DATE
;

SELECT delivery_date
FROM orders
WHERE STR_TO_DATE(delivery_date, '%Y-%m-%d') IS NULL
  AND delivery_date IS NOT NULL
  AND delivery_date <> '';
  
UPDATE orders
SET delivery_date = NULL
WHERE delivery_date = '';

ALTER TABLE orders
MODIFY delivery_date DATE;

CREATE TABLE `orders` (
  `order_id` text,
  `customer_id` text,
  `device_type` text,
  `device_model` text,
  `quantity` int DEFAULT NULL,
  `order_date` date DEFAULT NULL,
  `delivery_date` date DEFAULT NULL,
  `order_status` text,
  `country` text,
  `order_value` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


select *
from product_usage;

with row_numbers4 as 
(
select usage_id, customer_id, usage_date, feature, active_users, devices_in_scope,
row_number() over(partition by usage_id, customer_id, usage_date, feature, active_users, devices_in_scope) as row_num
from product_usage
)
select *
from row_numbers4
where row_num > 1
;

CREATE TABLE `product_usage` (
  `usage_id` text,
  `customer_id` text,
  `usage_date` text,
  `feature` text,
  `active_users` int DEFAULT NULL,
  `devices_in_scope` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


SELECT STR_TO_DATE
(usage_date, '%Y-%m-%d')
FROM product_usage;

update product_usage
set usage_date = STR_TO_DATE
(usage_date, '%Y-%m-%d');

ALTER TABLE product_usage
MODIFY COLUMN usage_date DATE
;

CREATE TABLE `product_usage` (
  `usage_id` text,
  `customer_id` text,
  `usage_date` date DEFAULT NULL,
  `feature` text,
  `active_users` int DEFAULT NULL,
  `devices_in_scope` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

select *
from product_usage
;

select distinct feature 
from product_usage
;

select *
from product_usage
where usage_id = ''
;

select *
from product_usage
where customer_id is null
;

select *
from product_usage
where usage_date is null
;

select *
from product_usage
where active_users is null
;

select *
from product_usage
where devices_in_scope is null
;

select *
from product_usage
;

select * 
from vendors
;

with row_numbers5 as 
(
select vendor_id, vendor_name, country, vendor_type, vendor_status, orders_fulfilled, avg_fulfilment_days, vendor_rating,
row_number() over(partition by vendor_id, vendor_name, country, vendor_type, vendor_status, orders_fulfilled, avg_fulfilment_days, vendor_rating) as row_num
from vendors
)
select *
from row_numbers5
where row_num > 1
;

CREATE TABLE `vendors` (
  `vendor_id` text,
  `vendor_name` text,
  `country` text,
  `vendor_type` text,
  `vendor_status` text,
  `orders_fulfilled` int DEFAULT NULL,
  `avg_fulfilment_days` double DEFAULT NULL,
  `vendor_rating` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

select *
from vendors; 

select distinct country 
from vendors
;

UPDATE vendors
Set country = 'United States'
WHERE country = 'US'
;

UPDATE vendors
Set country = 'United States'
WHERE country = 'USA'
;

UPDATE vendors
Set country = 'United Kingdom'
WHERE country = 'UK'
;

select *
from vendors
;

select distinct vendor_status 
from vendors
;

select *
from vendors
where vendor_id is null
;

select *
from vendors
where vendor_name is null
;

select *
from vendors
where orders_fulfilled is null
;

select *
from vendors
where avg_fulfilment_days is null
;

select *
from vendors
where vendor_rating is null
;

select * 
from sales;

with row_numbers as 
(
select lead_id, company_name, country, industry, lead_source, date_created, sales_stage, date_converted, contract_value, outcome, lost_reason,
row_number() over(partition by lead_id, company_name, country, industry, lead_source, date_created, sales_stage, 
date_converted, contract_value, outcome, lost_reason) as row_num
from sales
)
select *
from row_numbers
where row_num > 1
;

CREATE TABLE `sales` (
  `lead_id` text,
  `company_name` text,
  `country` text,
  `industry` text,
  `lead_source` text,
  `date_created` text,
  `sales_stage` text,
  `date_converted` text,
  `contract_value` double DEFAULT NULL,
  `outcome` text,
  `lost_reason` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT STR_TO_DATE
(date_created, '%Y-%m-%d')
FROM sales;

update sales
set date_created = STR_TO_DATE
(date_created, '%Y-%m-%d');

ALTER TABLE sales
MODIFY COLUMN date_created DATE
;

SELECT STR_TO_DATE
(date_converted, '%Y-%m-%d')
FROM sales;

update sales
set date_converted = STR_TO_DATE
(date_converted, '%Y-%m-%d');

ALTER TABLE sales
MODIFY COLUMN date_converted DATE
;

SELECT date_converted
FROM sales
WHERE STR_TO_DATE(date_converted, '%Y-%m-%d') IS NULL
  AND date_converted IS NOT NULL
  AND date_converted <> '';
  
UPDATE sales
SET date_converted = NULL
WHERE date_converted = '';

ALTER TABLE sales
MODIFY date_converted DATE;

CREATE TABLE `sales` (
  `lead_id` text,
  `company_name` text,
  `country` text,
  `industry` text,
  `lead_source` text,
  `date_created` date DEFAULT NULL,
  `sales_stage` text,
  `date_converted` date DEFAULT NULL,
  `contract_value` double DEFAULT NULL,
  `outcome` text,
  `lost_reason` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


select *
from sales
where country = '';

select distinct country 
from sales;

UPDATE sales
Set country = 'United States'
WHERE country = 'US'
;

UPDATE sales
Set country = 'United States'
WHERE country = 'USA'
;

UPDATE sales
Set country = 'United Kingdom'
WHERE country = 'UK'
;

UPDATE sales
Set country = 'Unspecified'
WHERE country = ''
;
select *
from sales;

select *
from orders
where order_status = 'Delivered'
;



