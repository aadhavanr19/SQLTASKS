SELECT SalesOrderID,ProductName FROM functions_sample.sales_data;
select * from functions_sample.sales_data;
-- the Total sales by customername & top 5 customers by sales
select CustomerName,sum(salesamount) from functions_sample.sales_data
 group by CustomerName;

select A.customername, A.salesamount from 
(select customername,salesamount, dense_rank() over (order by salesamount desc) as rnk
from functions_sample.sales_data) as A
where rnk <=5;

 -- the rank based on total sales amount & top 5 customers by least sales 
 select CustomerName,SalesAmount,dense_rank() over (order by salesAmount ) as RN
 from functions_sample.sales_data;
 
 select b.customername, b.salesamount from
(select customername,salesamount, dense_rank() over (order by salesamount ) as abc
from functions_sample.sales_data) as b 
where abc <=5;
 
 --  quantity of the products ordered.
select ProductName,sum( OrderQty ) from functions_sample.sales_data
 group by ProductName;
 
 -- minimum order
 select productName, min(orderQty) from functions_sample.sales_data
 group by ProductName;

-- no.of orders by customers
select 
 customerName
 ,count(orderQty) from functions_sample.sales_data
 group by customerName;
 
-- top 10 custoers by their orders
select c.customername, c.OrderQty from
(select customername, OrderQty, dense_rank() over (order by OrderQty desc ) as xyz
from functions_sample.sales_data) as c
where xyz <=10;

-- top 10 customers by total no of  orders made.
select customername, OrderQty, dense_rank() over (order by OrderQty desc ) as xyz
from functions_sample.sales_data;

-- the customers who made less than 50 orders.
select c.customername, c.OrderQty from
(select customername, OrderQty, dense_rank() over (order by OrderQty ) as xyz
from functions_sample.sales_data) as c
where xyz <=10;

-- Month wise total sales sort the data by sales amount desc

select concat(year(orderDate),'_',
monthname(orderDate)) as Orderdate,
round(sum(salesamount),2) as SalesAMT from
functions_sample.sales_data 
group by Orderdate;


-- month over month sales 

SELECT year(orderdate), month(orderdate), sum(salesamount) as sales_amount , 
lag (sum(salesAmount)) over (order by year(orderdate), Month(orderdate)) as PreviousYearSales
from functions_sample.sales_data 
where year(orderdate) in (2011,2012,2013,2014)
group by year(orderdate), month(orderdate);

-- the Costliest Product.

select *, max(unitprice) over(partition by categoryName order by unitprice) 
from functions_sample.sales_data; 










