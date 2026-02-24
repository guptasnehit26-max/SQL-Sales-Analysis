## SQL-Sales-Analysis Project
## Project Objective
-To Analyse the customer and sales data
## Tools Used 
-MYSQL/ SQL server
-SQL Queries

## Dataset Details
1)Transactions Table
Contain all transaction records.
Columns:
-Transaction_ID- Unique ID for each transactions
-cust_id: Customer ID
-trans_date: Transaction date
-prod_subcat_code: Product sub category code
-Qty: Quantity
-prod_cat_code: Product category code
-Rate: Price Per Unit
-Tax: Tax Amount
-total_amount: Total transaction Value
-Store_type: Type of store

2)Product Category Table
Contain product category and sub category details
Columns:
-prod_cat_code: Product category code
-prod_cat: Product category name
-prod_sub_cat_code: Sub-category code
-prod_subcat: Sub-category name

3) Customer Table
Contain Information
Columns:
-custumer_id: Unique customer ID
-DOB: Date of birth
-Gender: Customer gender
city_code: city code if the customer

## Key Queries Performed
1) Maximum quantity of product ordered
2) Net total revenue generated
3) Repeated transactions of the customers
4) Maximum number of customers from the specific city
5) Total revenue generated
6) Net total revenue generated from the specific age group(25-35 years)
7) Product category returned in last 3 months
8) Average and total revenue from each sub category for the categories

## Insights
-E-shop leads in both sales volume and revenue generation.
-The total number of customers aged 25–35 who generated net revenue in the last 30 days is 225.
-The Personal Appliances subcategory within Electronics generates the highest revenue.

## Files
-Sales_analysis.sql



