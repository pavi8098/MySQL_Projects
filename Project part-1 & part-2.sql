use modelcarsdb;
select * from customers;
select * from employees;
select * from offices;
select * from orderdetails;
select * from orders;
select * from payments;
select * from productlines;
select * from products;

/*customer data analysis*********************************************
***********************************************************************
************************************************************************/
-- Task-1 find the top 10 customer by credit limit
select customername,creditlimit from customers
order by 1 asc
limit 10;

-- Interpretation
	/*Under this task we have to find top 10 customer by credit limit
    so I have used limit*/

-- Task-2 find the avg credit limit for customer in each country

select customername,country,avg(creditlimit) from customers
group by 1,2
order by customername asc;

-- Interpretation
	/*Under this task I used average to find 
    average credit limit and used group by to find for each country*/

-- Task-3 Find the number of customer in each state

select customername,count(customername),state from customers 
group by customername,state
order by customername asc;

-- Interpretation
	/*Under this task I used group by to find number of customer in each state*/

-- Task-4 Find the customer who haven't placed any order

select * from customers
where customernumber not in (select customernumber from orders);

-- Interpretation
  /*Under this task I used subquery to find the customer who haven't placed the order*/

-- Task-5 Calculate total sales for each customers

select customername,sum(amount) as 'total sales' from customers
join payments using(customernumber)
group by 1
order by 1 asc;

-- Interpretation
   /*Under this task I used sum function to find the total sales amount*/

-- Task-6 List customer with assigned sales representatives

select customername,salesRepEmployeeNumber from customers
order by customername asc;

-- Interpretation
  /*Under this task I used only select commend to find the customer with 
  assigned sales representatives*/

-- Task-7 Retrive customer information with their most recent payment details

select customerName,year(paymentdate) as year_payment,phone addressLine1,city,country,paymentDate,amount from customers
join payments using (customernumber)
where year(paymentdate)>=2005;

-- Interpretation
  /*Under this task I used year commend to find the most recent payment*/

-/*Task-8 Identify the customer who have excedeed their
credit limit*****************************************************/

select customername,creditlimit from customers
where creditlimit>=100000;

-- Interpretation
   /*Under this task I used the credit limit to find the customer 
   who have excedeed their creditlimit*/

/* Task-9 Find the name of all customer who have placed an order for
a product from a specific product line************************************/

select customername,productline,productname from customers join orders using (customernumber)
join orderdetails using(ordernumber) join products using (productcode)
where productline='motorcycles';

-- Interpretation
   /*Under this task I used join commend and I used the productline =mototcycle
   so it is identified using where clause*/


/*Task-10 Find the name of all customers who have placed an order for
 the most expensive products*****************************************************************************/
 
 select customername,buyprice,quantityordered from customers
 join orders using(customernumber)join orderdetails using (ordernumber)
 join products using (productcode)
 group by customername ,buyprice,quantityordered
 order by buyprice desc;
 select max(buyprice) from products;
 
 -- Interpretation
   /*Under this task I used join and where clause to find the most expensive
   product and I used order by to find the expensive price*/

 
 /*Office data analysis*******************************************************
 ****************************************************************************
 ****************************************************************************/
 
 /* Task-1 Count the number of employees in each office**********************************************************/
 
 select employeenumber,firstname,count(employeenumber) as employeecount,officecode from employees
 join offices using (officecode)
 group by employeenumber,firstname,officecode
 order by 3 desc;
 
 -- Interpretation
    /*Under this task I used join ,select,groupby commend to find count number
    of employees in each office*/
 
 /*Task-2 Identify the offices with less than certain number of employees*********************************************************/
 
select employeenumber,officecode,firstname from employees
 join offices using(officecode)
 where officecode=5;
 
 -- Interpretation
    /*Under this task I used join and where clause to find the office 
    with less than certain number of employees*/
 
 /* Task-3 List offices along with their assigned territories***************************************************************/
 
 select officecode,territory from employees 
 join offices using (officecode);
 
 -- Interpretation
    /*Under this task I used join and select statement to find the
    offices with assigned territories*/
 
 /*Task-4 Find offices that have no employees assigned to them***************************************************************/
 -- using subquery
 select officecode from employees
 where officecode not in(select officecode from offices);
 
 -- using join
 select officecode from employees
 join offices using(officecode)
 where officecode<=0;
 
 -- Interpretation
   /*Under this task I used both subquery and join to find
   the offices having no employees*/
 
 /* Task-5 Retrive the most profitable office based on total sales***********************************************************/
 
 select officecode,buyprice,max(buyprice) as total_sales from employees
 join offices using (officecode)
 join customers using (country)
 join orders  using (customernumber)
join orderdetails using (ordernumber)
join products using (productcode)
group by officecode,buyprice
order by total_sales desc
limit 3;

-- Interpretation
  /*Under this task I used to join multiple table to fine the most profitable office based on total sales*/


/* Task-6  Find the office with the highest number of employees*********************************************************/

select officecode,employeenumber,max(employeenumber) as max_number from employees
join offices using (officecode)
group by officecode,employeenumber
order by max_number desc
limit 1;


-- Interpretation
	/*Under this task we used max to find highes number of employee
    and used groupby to find office code with highest number of employees*/

/* Task-7 Find the average credit limits for customers in each office*************************************************/

select creditlimit,customername,customernumber,officecode,avg(creditlimit) from employees
join offices using(officecode)
join customers using(country)
group by creditlimit,customername,customernumber,officecode;

-- Interpretation
	/* Under this task I used average to find avg creditlimit for customers in each office
    and used group by */
    
/*Task-8 Find the number of offices in each country********************************************************************/

select country,officecode,count(officecode) from offices
join employees using (officecode)
group by country,officecode;

-- Interpretation
    /* Under this task I used join to join employees table and
     identified the number of office in each country*/
     
     
/* Product data analysis*******************************************
*******************************************************************
*******************************************************************/

/*Task-1 Count the number of product in each productline************************************************************/

select count(productcode),count(productname),productline from products
join productlines using(productline)
group by productline;

-- Interpretation
   /* Under this task I has used group by to find product count in each product line*/
   
/*Task-2 Find the productline with the highest average product price************************************************/

select productline,avg(quantityordered*priceeach) as avg_price from products
join orderdetails using(productcode)
group by productline
order by  avg_price desc
limit 1;

-- Interpretation
   /* Under this task I used avg to find average price by
   multiplying quantity and price and then used orderby, group by, limit to find the
   highest average product price*/
   
/*Task-3 Find all products with price above or below a certain
amount(MSRP should be between 50 and 100)  ***************************************************************************/

select productname,MSRP from products
where MSRP between 50 and 100;

-- Interpretation
   /*Under this task I used where clause ,and,between to find the price between 50 and 100*/
   
/*Task-4 Find the total sales amount for each productline**************************************************************/

select productline,sum(quantityordered*priceeach) as total_sales from products
join orderdetails using(productcode)
group by productline;

-- Interpretation
  /*Under this task I has jointed 2 tables to find the total sales
  after that I used group nby to find total sales in each productline*/
  
/*Task-5 Identify products with low inventory level(less than specific threshold value
of 10 for quantity stock)**********************************************************************************************/

select productname,productcode,quantityinstock from products
where quantityinstock<=10;

-- Interpretation
   /*Under this task we need to find low stock of 10 and there is no product below 10*/
   
/*Task-6 Retrive the most expensive product based on MSRP******************************************************************/

select productname,productcode,max(MSRP) as highest_MSRP from products
group by productname,productcode
order by highest_MSRP desc
limit 1;

-- Interpretation
    /*Under this task we need to find the most expensive product based on MSRP
    so that I used order by desc and limit 1 to find the expensive product*/
    
/*Task-7 Calculate total sales for each product*****************************************************************************/

select productname,productcode,sum(quantityordered*priceeach) as total_sales from products
join orderdetails using(productcode)
group by productname,productcode
order by total_sales desc;

-- Interpretation
   /* Under this task I joined 2 tables to 
   find total sales and then I used group by to find total sales for each product*/
   
/* Task-8 Identify top selling product based on total selling quantity ordered using a 
stored procedure. The procedure should accept an input parameter to
specify the number of top selling products to retrive************************************************************************/

delimiter //
create procedure top_selling (in product_code int)
begin
select sum(quantityordered) as total_sell_qty ,productname,productcode from products
join orderdetails using(productcode)
group by productname,productcode
order by total_sell_qty desc;
end //
delimiter ;

call top_selling (5);

-- Interpretation
   /* Under this task I created procedure and identified total selling
   using sum and I used join . so that we can identified the top selling product
   based on total selling quantity*/
   
/*Task-9 Retrive products with low inverntory level(less than a threshold value of 10 
for quantity instock) for specific productlines(classic cars,Motorcycles)****************************************************************/

select productname,productcode,quantityinstock from products
where quantityinstock<=10 and productline in('motorcycles','classicalcars');

-- Interpretation
   /*Under this task we have to find the product and specific productline
   is motorcycle,classicalcars that the stock in below 10 there is output under
   this task because there is no quantity instock <0*/
   
/* Task-10 Find the names of all product that have been 
ordered by more than 10 customer***********************************************************************/

select productname,quantityordered from products 
join orderdetails using(productcode)
group by productname,quantityordered
order by quantityordered desc
limit 10;

-- Interpretation
  /*Under this task I used join to find the quantity ordered
  and used orderby to find the most ordered and used limit to find top 10*/
  
/* Task-11 Find the names of all products that have been ordered more than the
average number of orders for their productlines**********************************************************/

select productname,productline,avg(quantityordered) as avg_quantity,quantityordered  from products
join orderdetails using(productcode)
where quantityordered>35.2190
group by productname,productline,quantityordered
order by avg_quantity desc;


select avg(quantityordered) from orderdetails;  /*Identified avg quantity ordered*/


-- Interpretation
  /*Under this task I used to join 
 tables and I has identified the ordered quantity that is greater than the
 avg quantity and I used order by to find the highest average quantity*/


/* Project part-2*********************************
*****************************************************
***************************************************/

/*Task-1 find the total number of employees********************************************/

select employeenumber,count(employeenumber) from employees
group by employeenumber;

-- Interpretation
/*Under this task I used count to find total number of employees*/

/*Task-2 List all employees with theri basic information*****************************/

select employeenumber,firstname,lastname,email,jobtitle,officecode from employees;
-- Interpretation
 /*Under this task I used select statement to find basic information*/
 
 /*Task-3 Find the number of employees holding each jobtitle**********************************/

select employeenumber,count(employeenumber),firstname,jobtitle from employees
group by jobtitle,firstname,employeenumber;

-- Interpretation
/*Under this task I used count and group by to find the
number of employees holding each jobtitle*/

/*Task-4 Find the employees who haven't have manager*******************************/

select employeenumber,reportsto from employees 
where reportsto is not null;

-- Interpretation
/*Under this task I used where clause to find the reportsto is not null*/

/*Task-5 Calculate total sales generated by each sales representatives**************************************/

select salesrepemployeenumber,sum(buyprice) from customers
join orders using(customernumber)
join orderdetails using(ordernumber)
join products using (productcode)
group by salesRepEmployeeNumber;

-- Interpretation
/*Under this task I used join and groupby to complete this task*/

/*Task-6 Find the most profitable sales rep based on total sales*********************************/

select salesrepemployeenumber,sum(amount) as total_sales from customers 
join payments using(customernumber)
group by salesrepemployeenumber
having total_sales>20000;
 -- Interpretation
 /*Under this task I used having clause to find the total_sales >20000
 I is considered as a lower amount and it is profitable to sales rep*/
 
 /*Task-7 Find name of all employees who have sold more than the avg sales
 amount of their office******************************************************************************/
 
 select firstname,officecode,amount,avg(amount) as avg_amt,customernumber from employees
 join offices using(officecode)
 join customers using (country)
 join payments using(customernumber)
 where amount>32431.645531
 group by firstname,officecode,customernumber,amount;
 select avg(amount) from payments;
 
 -- Interpretation
   /*Under this task I used average and join to complete this task*/
   
   
   /*order analysis**********************************************************
**************************************************************
*********************************************************/
/*Task-1*/
/* Find the averageorder amount for each customer**************************************/

select customernumber,avg(buyprice) from customers
 join orders  using (customernumber)
join orderdetails using (ordernumber)
join products using (productcode)
group by customernumber
order by 1 desc;

-- Interpretation
/*Under this task I used join to join multiple tables and
I identified the average order amount for each customer*/

/*Task-2 Find the number of order placed in each month***************************************************/
select quantityordered,month(orderdate)as mon_th from orderdetails
join orders using(ordernumber)
group by quantityordered,mon_th;

-- Intepretation
/*Under this task I used month function to find the month 
and used join to find the orderdate and completed this task*/

/*Task-3 Identify the product that are still pending shippment*/

select status,productname from orders
join orderdetails using(ordernumber)
join products using(productcode)
where status='In Process' 
group by productname,status;

-- Interpretation
/*Under this task I used join , where clause and group by to
find the orders that are pending*/

/*Task-4list orders along with customer details*************************************************/

select customernumber,customername ,quantityordered from customers
join orders using(customernumber)
join orderdetails using(ordernumber)
group by  customernumber,customername ,quantityordered ;

-- Interpretation
/*Under this task I used join and group by to find the order with customer details*/

/*Task-5 Retrive the most recent orders based on order date******************************************/

select orderdate,ordernumber from orders
where orderdate='2005-05-31';

-- Interpretation
/*Under this task I has used only where clause to find the most recent date ordered*/

/*Task-6 calculate total sales for each order**************************************/

select productname,sum(amount)  as total_sales ,ordernumber, quantityordered from products
join orderdetails using( productcode)
join orders using (ordernumber)
join payments using (customernumber)
group by productname, ordernumber,quantityOrdered;

-- interpretation
/*Under this task I used join and group by to find the total sales for each order*/

/*Task-7 Find the highest value ordered based on total sales**************************************************/

select sum(amount) as total_amount,max(quantityordered) as qty_ordered from payments

join orders using (customernumber)
join orderdetails using(ordernumber)
order by 2 desc;

-- Interpretation
/*Under this task I has used order by to find the highest value*/

/* Task-8 List all orders with their correspondence order details****************************************************/

select ordernumber,productCode,quantityOrdered,priceEach,orderLineNumber from orders
join orderdetails using(ordernumber);

-- Interpretation
/* Under this task only join commend to complete this task*/

/*Task-9 List the most frequently ordered products*****************************************************************/

select productname,count(quantityordered) as count_qty  from products
join orderdetails using(productcode)
group by productname
order by 2 desc;

-- Interpretation
/*Under this task I has used count to find the most frequent order that placed*/

/*Task-10 Calculate total revenue for each order*********************************************************/

select  sum(amount) as total_revenue,ordernumber from payments
join orders using (customernumber)
join orderdetails using(ordernumber)
group by ordernumber;

-- Interpretation
/*Under this task I has used sum function to find the total revenue 
and completed this task using group by*/

/*Task-11 Identify the most profitable orders based on total revenue********************************************/

select  sum(amount) as total_revenue,ordernumber from payments
join orders using (customernumber)
join orderdetails using(ordernumber)
group by ordernumber
order by 1 desc
limit 5;

-- Interpretation
/* Under this task I used sum function,join,groupby,orderby and limit to complete this task*/

/*Task-12 List all products with detailed product information***************************************/

select productname,productCode,productLine,productScale,productVendor,productDescription,quantityInStock,buyPrice,MSRP 
from products;

-- Interpretation
/* Under this task I has used select statement to list all
products along with detailed product infromation*/

/*Task-13 Identify orders with delayed shipping(shipped date>required date)******************************************/

select ordernumber,requireddate,shippeddate,status from orders
where (shippeddate>requireddate)
group by status,ordernumber;
 
-- Interpretation
/*Under this task I has used where clause and groupby to find the delayed shipping as a hint*/

/*Task-14 Find the most popular products combinations with orders****************************************************/

select productname ,max(quantityordered) as popular_products,ordernumber from products
join orderdetails using(productcode)
group by  productname,ordernumber
order by popular_products desc
limit 10;

-- Interpretation
/*Under this task I has used maximum function to find the most popular products*/

/*Task-15 Find revenue for each order and identify the top 10 most profitable**************************************************/

select sum(amount) as total_revenue,ordernumber from payments
join orders using(customernumber)
group by ordernumber
order by total_revenue desc
limit 10;

-- Interpretation
/* Under this task I has used join,groupby ,order by and limit to find the top 10 most profitable */

/* Task-16 create a trigger that automatically updates a customers credit limit after
after a new order is placed ,reducing it by the order total**************************************************************/

insert into orderdetails values(10206,'S24_2022',10,12,4);

delimiter //
create trigger tri_credit
after insert on customers
for each row
begin
update customers set creditlimit=quantityordered-new.quantityordered where ordernumber=new.ordernumber;
end //
delimiter ;

/*Task-17 Create a trigger that logs product quantity where ever a order details is inserted
or updated*******************************************************************************************/

insert into orderdetails values(10207,'S24_2022',100,12,4);

delimiter // 
create trigger tri_logs
after insert on orderdetails
for each row
begin
update orderdetails set quantityordered=quantityordered-new.quantityordered where ordernumber=new.ordernumber;
end //
delimiter ;


select * from customers;
select * from employees;
select * from offices;
select * from orderdetails;
select * from orders;
select * from payments;
select * from productlines;
select * from products;
select quantityordered,ordernumber from orderdetails order by quantityordered desc limit 10;
update orderdetails set quantityordered=quantityordered-new.quantityordered where ordernumber=new.ordernumber;












