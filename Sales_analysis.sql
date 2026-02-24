Use Retail_cs;
Select * from information_schema.tables;
Use Retail_cs

Select Top 1 * from Transactions;
Select Top 1 * from prod_cat_info;
Select Top 1 * from Customer;

1)

Select count(*) as cnt from Customer;

Select count(*) as cnt from prod_cat_info;

Select count(*) as cnt from Transactions;

2) 

Select count(distinct(transaction_id)) as tot_trans from Transactions
where Qty < 0;

3)

Select convert(date,tran_date,105) as trans_dates from Transactions;

4)
SELECT DATEDIFF(YEAR, MIN(CONVERT(date, tran_date, 105)), MAX(CONVERT(date, tran_date, 105))) AS diff_years, 
DATEDIFF(MONTH, MIN(CONVERT(date, tran_date, 105)), MAX(CONVERT(date, tran_date, 105))) AS diff_months, 
DATEDIFF(DAY, MIN(CONVERT(date, tran_date, 105)), MAX(CONVERT(date, tran_date, 105))) AS diff_days 
FROM Transactions;

Q5)
Select prod_cat,prod_subcat from prod_cat_info
where prod_subcat = 'DIY'

-Data analysis-

Select Top 1 * from Transactions;
Select Top 1 * from prod_cat_info;
Select Top 1 * from Customer;

Q1)Select top 1 store_type,count(*) as cnt from transactions
group by Store_type
order by cnt desc

Q2) Select gender, count(*) as cnt from Customer
where gender is not null 
group by gender

Q3) Select city_code, count(*) as cnt from Customer
group by city_code
order by cnt desc

Q4) Select prod_cat, prod_subcat from prod_cat_info
where prod_cat = 'Books'

Q5) Select prod_cat_code, max(qty) as max_prod from Transactions
group by prod_cat_code

Q6) Select * from prod_cat_info as t1	
join Transactions as t2
on t1.prod_cat_code = T2.Prod_cat_code AND t1.prod_cat_code = t2.prod_subcat_code

Q6) select Sum(cast (total_amount as float)) as net_revenue from prod_cat_info as t1
join Transactions as t2
on t1.prod_cat_code = T2.prod_cat_code AND t1.prod_sub_cat_code = t2.prod_subcat_code
where prod_cat = 'Books' OR prod_cat = 'Electronics'

Q7) Select count(*) as tot_cust from (
Select cust_id, count(distinct(transaction_id)) as cnt_trans from Transactions
where qty > 0
group by cust_id
Having count(distinct(transaction_id)) >10
) as t5

Q8) select * from prod_cat_info as t1
join Transactions as t2
on t1.prod_cat_code = T2.prod_cat_code AND t1.prod_sub_cat_code = t2.prod_subcat_code
where prod_cat in ('Clothing','Electronics') AND Store_type = 'Flagship store'


select sum(cast(Total_amount as float)) as combined_revenue from prod_cat_info as t1
join Transactions as t2
on t1.prod_cat_code = T2.prod_cat_code AND t1.prod_sub_cat_code = t2.prod_subcat_code
where prod_cat in ('Clothing','Electronics') AND Store_type = 'Flagship store' and qty > 0

Q9)
Select prod_subcat,Sum(cast(total_amount as float)) as tot_revenue from Customer as t1
join transactions as t2
on t1.customer_Id = t2.cust_id
join prod_cat_info as t3
on t2.prod_cat_code = t3.prod_cat_code and t2.prod_subcat_code = t3.prod_sub_cat_code
where gender = 'M' and prod_cat = 'Electronics'
Group by prod_subcat;

Q10)--Percentage of sales--

Select * from (
Select top 5 prod_subcat, (sum(cast(total_amount as float))/(Select sum(cast(total_amount as float)) as tot_sales from Transactions where qty >0)) as percentage_sales
from prod_cat_info as t1
join Transactions as t2
on t1.prod_cat_code = t2.prod_cat_code AND t1.prod_sub_cat_code = t2.prod_subcat_code
where qty > 0
group by prod_subcat
order by percentage_sales desc
) as t5
join
--Percentage of sales--
(
Select prod_subcat, (sum(cast(total_amount as float))/(Select sum(cast(total_amount as float)) as tot_sales from Transactions where qty <0)) as percentage_returns
from prod_cat_info as t1
join Transactions as t2
on t1.prod_cat_code = t2.prod_cat_code AND t1.prod_sub_cat_code = t2.prod_subcat_code
where qty < 0
group by prod_subcat  ) t6
on t5.prod_subcat = t6.prod_subcat


Q11)--Age of customer

Select * from (
Select * from (
Select cust_id, DATEDIFF(year,dob,max_date) as age, revenue from (
Select cust_id,dob,Max(convert(date,tran_date,105)) as max_date , Sum(cast(total_amount as float)) as revenue from Customer as t1
join Transactions as t2
on t1.customer_id = t2.cust_id
where qty > 0
group by cust_id,DOB
) as A
                  ) as B
where age between 25 and 35
                           ) as C
Join (
--last 30 days of transations

Select cust_id, convert(date, tran_date,105) as tran_date 
from Transactions
group by cust_id, convert(date, tran_date,105)
having convert(date, tran_date,105) >=(Select dateadd(day, -30,MAX(convert(date, tran_date,105))) as cutoff_date from Transactions)
)D 
on C.cust_id = d.cust_id

12) 
Select dateadd(month, -3,MAX(convert(date, tran_date,105))) as cutoff_date from Transactions

Select top 2 prod_cat_code, convert(date, tran_date,105) as tran_date, Sum(qty) as returns
from Transactions
where Qty < 0
group by prod_cat_code, convert(date, tran_date,105)
having convert(date, tran_date,105) >=(Select dateadd(month, -3,MAX(convert(date, tran_date,105))) as cutoff_date from Transactions)
order by returns

13) Select store_type, sum(cast(total_amount as float)) as revenue , sum(qty) as Quantity
from transactions
where qty>0 
group by store_type
order by revenue desc, quantity desc

14) Select prod_cat_code, avg(cast(total_amount as float)) as avg_revenue
from Transactions
where qty>0
group by prod_cat_code
having avg(cast(total_amount as float)) >= (Select avg(cast(total_amount as float))
from Transactions
where qty>0 ) 
order by prod_cat_code desc;

15) Select prod_subcat_code, SUM(cast(total_amount as float)) as revenue, AVG(cast(total_amount as float)) as avg_revenue
from Transactions
where qty > 0 and prod_cat_code IN ( select top 5 prod_cat_code from Transactions
                                     where qty>0
                                     group by prod_cat_code
                                     order by sum(qty) desc )
group by prod_subcat_code