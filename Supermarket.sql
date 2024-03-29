CREATE TABLE Employee(
employee_id varchar (20)  NOT NULL,
employee_name varchar (20) NOT NULL,
employee_contact int   NOT NULL ,         
employee_dob  date  NOT NULL,
employee_email varchar(50)  NOT NULL,
employee_address varchar(50)  NOT NULL,
gender  VARCHAR(10) NOT NULL      check (gender = 'female' or gender='male'),
PRIMARY KEY (employee_id)
);

CREATE TABLE OfferDetails(
offers_id varchar(50)  NOT NULL,
offers_type varchar(50)  NOT NULL,
offers_details varchar(50)  NOT NULL,
offers_start_date date  NOT NULL,
offers_end_date date  NOT NULL,
PRIMARY KEY (offers_id)
    );
	
	CREATE TABLE CustomerType(
type_id varchar(6)  NOT NULL,
type_name varchar(20)  NOT NULL,
PRIMARY KEY (type_id)    
 ) ;
 
 CREATE TABLE Customer(
customer_id varchar(10)  NOT NULL,
customer_name varchar(50)  NOT NULL,
customer_contact int    NOT NULL,
date_of_birth  date  NOT NULL,            
email varchar(50)  NOT NULL,
address varchar(50)  NOT NULL,
gender VARCHAR(20)    NOT NULL check (gender = 'female' or gender='male'),
customer_type_id varchar(6)  NOT NULL,
membership_to date  NOT NULL,
membership_to_from  date  NOT NULL,    
PRIMARY KEY (customer_id),
FOREIGN KEY (customer_type_id) REFERENCES CustomerType(type_id)    
                                                                           ON DELETE SET NULL ON UPDATE CASCADE
);


CREATE TABLE Warehouse(
warehouse_no varchar(20)  ,
warehouse_name varchar(50)  ,
PRIMARY KEY (warehouse_no)
); 
    
  
CREATE TABLE Block(
block_id VARCHAR(2)  NOT NULL,
block_name varchar(50)  NOT NULL,
block_incharge_id  varchar(50)  NOT NULL,
PRIMARY KEY (block_id),
FOREIGN KEY (block_incharge_id) REFERENCES Employee(employee_id)  
                                                                           ON DELETE SET NULL ON UPDATE CASCADE
    );  
  
CREATE TABLE Category(
category_id varchar(6)  NOT NULL,
category_name varchar(50)  NOT NULL,
store_id varchar(2)  NOT NULL,
warehouse_no varchar(20) ,
PRIMARY KEY (category_id) ,
FOREIGN KEY (store_id) REFERENCES Block(block_id),
FOREIGN KEY (warehouse_no) REFERENCES Warehouse(warehouse_no)
);



    
CREATE TABLE  PaymentMode(
payment_mode_id varchar(6)  NOT NULL,
mode_of_payment varchar(20)  NOT NULL,
offer_id varchar(50)  NOT NULL,
PRIMARY KEY (payment_mode_id) ,
FOREIGN KEY (offer_id) REFERENCES OfferDetails(offers_id)
                                                                                 ON DELETE SET NULL ON UPDATE CASCADE
);    

CREATE TABLE  InvoiceDetails(
inv_id varchar(20)  NOT NULL,
cust_id varchar(20)  NOT NULL,
amount float  NOT NULL,
inv_date  date   NOT NULL,
payment_mode_id varchar(6)  NOT NULL,
cashier_id varchar(10)  NOT NULL,
PRIMARY KEY (inv_id)  ,
FOREIGN KEY (payment_mode_id) REFERENCES PaymentMode(payment_mode_id)
                                                                                 ON DELETE SET NULL ON UPDATE CASCADE,
FOREIGN KEY (cashier_id) REFERENCES Employee(employee_id)
                                                                                 ON DELETE SET NULL ON UPDATE CASCADE,
FOREIGN KEY (cust_id) REFERENCES Customer (customer_id)
										 ON DELETE SET NULL ON UPDATE CASCADE
);


CREATE TABLE  Product(
product_id varchar(20)  NOT NULL,
product_type varchar(50)  NOT NULL,
brand varchar(20)  NOT NULL,
cost_price float  NOT NULL,
weight varchar(20)  NOT NULL,
selling_price float  NOT NULL,
category_id varchar(6)  NOT NULL,
offer_id  varchar(50) NOT NULL,
block_count int NOT NULL,
warehouse_count int NOT NULL,
 PRIMARY KEY (product_id),   
FOREIGN KEY (offer_id) REFERENCES OfferDetails(offers_id)    
                                                                                ON DELETE SET NULL ON UPDATE CASCADE,
FOREIGN KEY (category_id) REFERENCES Category(category_id)
                                                                                ON DELETE SET NULL ON UPDATE CASCADE
);          

CREATE TABLE Buys(
product_id varchar(20)  NOT NULL,
invoice_id varchar(20)  NOT NULL,
quantity int  NOT NULL,
cost float Not NULL,  
PRIMARY KEY (product_id,invoice_id),                 
FOREIGN KEY (product_id) REFERENCES Product(product_id)
                                                                                  ON DELETE SET NULL ON UPDATE CASCADE,
FOREIGN KEY (invoice_id) REFERENCES InvoiceDetails(inv_id)
                                                                                  ON DELETE SET NULL ON UPDATE CASCADE
);  

CREATE TABLE Feedback(
review_id varchar(20)  NOT NULL,
review_text VARCHAR(50)  NOT NULL,
rating int  NOT NULL,
review_date date  NOT NULL,
cust_id varchar(20)  NOT NULL,
invoice_id varchar(20) NOT NULL,
PRIMARY KEY (review_id),   
FOREIGN KEY (cust_id) REFERENCES Customer(customer_id)
                                                                                 ON DELETE SET NULL ON UPDATE CASCADE,
FOREIGN KEY (invoice_id) REFERENCES InvoiceDetails(inv_id)
                           ON DELETE SET NULL ON UPDATE CASCADE   
);


CREATE TABLE ReturnSlip(
slip_no varchar(20)  NOT NULL, 
inv_id varchar(20)  NOT NULL,
product_id varchar(20)  NOT NULL,
quantity  int  NOT NULL check(quantity>0),
return_date date NOT NULL,
PRIMARY KEY (slip_no,product_id),
FOREIGN KEY (product_id) REFERENCES Product(product_id)
ON DELETE SET NULL ON UPDATE CASCADE,
FOREIGN KEY (inv_id) REFERENCES InvoiceDetails(inv_id)
ON DELETE SET NULL ON UPDATE CASCADE
);