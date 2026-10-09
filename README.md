Rayda Data Analyst Intern Assessment

An end-to-end analytics project built on Rayda's synthetic company dataset. I cleaned six raw tables in MySQL, analysed a controlled product experiment in Excel, and built a multi-page Power BI dashboard that tells leadership what to track across growth, operations, customers and product.

Business Questions
How healthy is order fulfilment, and where is revenue being lost?
Are some markets getting slower delivery than others?
Why are sales opportunities being lost?
Did the product intervention actually change customer behaviour?
Dataset
Table	Description
customers	Company profile, country, industry, plan, status, annual revenue
orders	720 device orders with status, dates, country and value
vendors	Vendor type, status, fulfilment speed and rating
sales	96 closed sales opportunities with outcome and lost reason
product_usage	Feature-level usage by customer over time
experiment	Control vs Treatment test on 80 customers

The scope covers 143 customers across 8+ countries.

Tools
MySQL for data cleaning and validation
Excel for the experiment (A/B test) analysis
Power BI for the dashboard and visuals
Process
1. Data Cleaning (MySQL)

Full script: data_cleaning.sql

Removed exact duplicate rows in every table using ROW_NUMBER() partitioned on all columns
Standardised inconsistent country values (US, USA → United States; UK → United Kingdom) across customers, orders, vendors and sales
Converted text date fields to proper DATE types with STR_TO_DATE()
Set blank delivery dates to NULL for failed, cancelled and in-transit orders, since they were never delivered
Labelled 10 sales records with no country as Unspecified instead of dropping them, to avoid losing data
Checked every table for blanks, nulls and inconsistent categories before analysis
2. Experiment Analysis (Excel)

Workbook: experiments.xlsx

Compared baseline and post-experiment weekly actions and feature adoption between Control and Treatment groups.

3. Dashboard (Power BI)

File: Rayda_Dashboard.pbix

A 5-page report covering orders and fulfilment, delivery performance by country, sales outcomes and the product experiment.

Key Findings
80% of orders completed (576 of 720), generating $9M in revenue. Failed and cancelled orders still account for $2M in lost value.
Delivery speed varies by market. The company average is 6.67 days, but Nigeria (7.62) and Canada (7.20) lag well behind Australia (6.11) and the Netherlands (6.32).
61% of non-delivered orders fail before shipping. The bigger problem is upstream fulfilment, not delivery speed.
Sales losses have no single cause. Lost reasons are spread fairly evenly across budget, feature gap, competitors and no response.
The product intervention worked.
Metric	Control	Treatment
Baseline weekly actions	3.53	3.63
Post-experiment weekly actions	3.43	5.68
Change	-0.10	+2.05
Feature adoption	27.5%	52.5%

Net lift is roughly +2.15 actions per week attributable to the intervention.

Recommendations
Prioritise root-cause analysis on cancelled and failed orders over shipping-speed optimisation.
Target delivery-time improvements in Nigeria and Canada, aiming to close about half the gap to the fastest markets.
Roll out the tested intervention broadly, starting with Starter and Growth tier customers, since enterprise customers already show strong baseline engagement.
Limitations
The data has no reason code for order failure or cancellation, so the root cause of fulfilment failures cannot be pinpointed from this data alone.
The dataset is synthetic, so findings illustrate the analytical approach rather than real business performance.
