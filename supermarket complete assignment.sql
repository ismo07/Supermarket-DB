
1. Find the most profitable product sold.

select profit,product_id,brand from (select distinct product_id, 	brand, (selling_price-cost_price) as profit from buys natural join 	product) as r3 natural join (select max(profite) as profit from 
(select distinct product_id,brand,(selling_price-cost_price) as 	profite from buys natural join product) as r2) as r4
where r4.profit=r3.profit;
2. Count the number of platinum card holder who shopped for more than ₹ 2000.
select count(distinct cust_id) from invoicedetails natural join customer natural join customertype where invoicedetails.amount > 2000 and customertype.type_name='Platinum';

3. List details of product which are bought through thepayment mode, PayTm and had the product offer KHUSIWALIDIAWLI.

select * from (select DISTINCT product_id from (select inv_id from InvoiceDetails as i join PaymentMode as p on (i.payment_mode_id=p.payment_mode_id) where mode_of_payment='Paytm')as d join Buys as b on(d.inv_id=b.invoice_id)) as s join Product as pro
on(s.product_id=pro.product_id) where offer_id='KHUSIWALIDIWALI';

4. List product id, product type and category id of product which are sold whose category id begins with MF and stored in warehouse ending with 002.

select distinct product_id , product_type,category_id from buys natural join product natural join category where
category.warehouse_no like '%002' and
product.category_id like 'MF%';

5. Find the most valuable customer of the year.

select sum,cust_id,year,customer_name from 
(select sum,cust_id,year from (select sum(amount) as sum, cust_id,extract(year from inv_date) as year from invoicedetails group by cust_id,year) as r1 natural join (select max(sume) as sum ,year from (select sum(amount) as sume, cust_id, extract(year from inv_date) as year from invoicedetails group by cust_id,year) as r2 group by year ) as r3 where r1.sum=r3.sum and r3.year=r1.year order by year) as r5 join customer on (r5.cust_id=customer.customer_id); 


6. If a customer went to shops on 31 dec, 2016 , list the offers applicable for him on that day.

         select offers_id,offers_type,offers_details from OfferDetails    	where offers_start_date < '2016-12-31' and offers_end_date >  	'2016-12-31';

7. List the incharge name, incharge id and gender of all block incharges under whose work no product of his block were returned by any customer.

	select employee_name, employee_id ,gender from (select 	block_incharge_id from block except select block_incharge_id 	from  (select store_id from (select distinct category_id from 	ReturnSlip as rs join Product as p on 	(rs.product_id=p.product_id)) 	as e join category as c on(e.category_id=c.category_id))as f join block 	as b on (f.store_id=b.block_id))as bl join employee as emp 
	on (bl.block_incharge_id=emp.employee_id);

8. List the product id, product type, warehouse count and block count of products which were returned and whose block count is 30 % more than their warehouse count.
	select  p.product_id, p.product_type, p.warehouse_count, 	p.block_count from returnslip as r join Product as p on  	(r.product_id=p.product_id)  where block_count > 0.3 * 	warehouse_count; 

9. List the customer id who shopped for atleast a total of 3 quantities of any product (maybe same product) and paid a amount greater tha ₹ 3000 on 5 march, 2015 and were having the Platinum card. 

	select distinct cust_id,type_name from(select DISTINCT cust_id , 	inv_date ,amount from (select invoice_id , sum(quantity) from Buys 	group by invoice_id having sum(quantity)>3 or sum(quantity)=3)as p 	natural join InvoiceDetails where amount >3000 and inv_date='2015-03-05' ) as j natural join Customer as c natural join 
	CustomerType where CustomerType.type_name='Platinum';

10. List product id and quantity of products sold under offer OFF10.
select product_id, count(product_id) , sum(quantity) as quan_max  from buys natural join product 
where offer_id='OFF10'
group by product_id order by sum(quantity) desc ;

11. List the employee name and id who is incharge of grocery department.

select  distinct employee_name,employee_id from employee inner join block on(employee_id=block_incharge_id) 
inner join category on (block_id=store_id) where block_name='Grocery'; 

12. List the offer id and quantity of product under that offer which          were returned.

	select max,offer_id from (select offer_id ,sum(quantity) as max 	from returnslip natural join product group by offer_id) as r2 	natural 	join (select max(sum) as max from (select sum(quantity) as sum, 	offer_id from returnslip natural join product group by offer_id)  as r1) 	as r3 where r3.max=r2.max;

13. Find the customer type which is most attracted by offer KHUSIWALIDIWALI.

select sum, customer_type_id from (select max(count) as sum from (select count(customer_type_id) as count, customer_type_id from product natural join buys inner join invoicedetails on (invoice_id=inv_id) inner join customer on (cust_id=customer_id) inner join customertype on
(customer_type_id=type_id) where offer_id = 'KHUSIWALIDIWALI' group by (customer_type_id)) as r3) as r4 natural join (select count(customer_type_id) as sum, customer_type_id from product natural join buys inner join invoicedetails on (invoice_id=inv_id) inner join customer on(cust_id=customer_id) inner join customertype on (customer_type_id=type_id) where offer_id = 'KHUSIWALIDIWALI' group by (customer_type_id)) as r2 where r2.sum=r4.sum;








