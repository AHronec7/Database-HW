use master
if (select count(*) from sys.databases where name = 'library')> 0 
begin
	drop database library
end

create database library
go

use library

--create statements 
create table [address]
(	
	addressID		int			     not null,
	addressline1	nvarchar(30)	 not null,
	addressline2	nvarchar(30)	 not null,
	city			nvarchar(25)	 not null,
	[state]			varchar(2)		 null,
	postalcode		char(5)			 null,
	modifieddate	datetime		 null,
	primary key(addressID)
  
)




create table employees 
(
	
	employeeID   int           not null,
	empfirstname varchar(30)   not null,
	emplastname  varchar(30)   not null,
	birthdate    datetime      not null,
	gender       nchar (20)    not null,
	hiredate     datetime      not null,
	city         varchar(30)   null,
	state        varchar(2)    null,
	postalcode   char(5)       null,
	modifieddate datetime
	primary key (employeeID)
)


create table person
(
	personID	 int		   not null,
	addressID	 int		   not null,
	persontype   nchar(20)     not null,
	firstname    nvarchar(30)  not null,
	lastname     nvarchar(30)  not null,
	addressline1 nvarchar(30)  not null,
	addressline2 nvarchar(30)  not null,
	phonenumber  nchar(12)     not null,
	city		 nvarchar(35)  null,
	[state]		 char(2)	   null,
	postalcode	 char(6)	   null,
	modifieddate datetime
	primary key (personID),
	constraint fk_person_address foreign key (addressID) references [address] (addressID)

	)



create table publishers 
(
	pubID		 int			    not null,
	pubname		 varchar(30)		not null,
	phone		 varchar(12)		not null,
	city		 nvarchar(30)		null,
	state		 varchar(2)		    null,
	postalcode   char	(5)		    null,
	modifieddate datetime			not null,
	modifiedby   varchar(30)		not null,		
	primary key (pubID)

)
go 
create trigger trg_publisher
on			   publishers
after          Insert, update, delete
as
begin
			   update publishers
			   set modifieddate = getdate()
end
go


create table authors 
(
	authorID		int		     not null,
	pubID			int		     not null,
	authorfirstname varchar(30)  not null,
	authorlastname  varchar(30)  not null,
	homephone       varchar(20)  not null,
	cellphone       varchar(20)  not null,
	city			nvarchar(30) null,
	[state]			char(2)	     null,
	postalcode		char(5)      null,
	modifieddate    datetime	not null,
	modifiedby		varchar(30)	null
	primary key (authorID),
	constraint fk_authors_publishers foreign key (pubID) references publishers(PubID)
	
)


create table customers
(
	customerID   int	      not null,
	personID     int	      not null,
	firstname    nvarchar(30) not null,
	lastname     nvarchar(30) not null,
	homephone    varchar(12)  not null,
	cellphone    varchar(12)  not null,
	city	     nvarchar(30) null,
	[state]	     varchar(2)   null,
	postalcode   char(5)      null,
	modifieddate datetime	  not null,
	primary key (customerID),
	constraint librarycard_customers foreign key (customerID) references customers (customerID)
	
)

create table orders
(
	orderID			int				 not null,
	orderdate		datetime		 not null,
	shipdate		datetime		 not null,
	status		    varchar(20)		 not null,
	customerID		int				 not null,
	shiptoaddressID int				 not null,
	city			varchar(30)		 null,	
	[state]			varchar(2)		 null,
	postalcode		char(5)			 null,
	modifieddate    datetime 
	primary key (orderID),
	constraint fk_orders_customers foreign key (customerID) references customers (customerID)

)
go
create trigger trg_order
on			   orders
after          Insert, update, delete
as
begin
			   update products
			   set modifieddate = getdate()

end
go



create table fees_fines 
(
	
	feeID       int		       not null,
	orderID     int		       not null,
	customerID  int		       not null,
	overdue     varchar(30)	   not null,
	damaged     varchar(30)	   not null,
	reportedate datetime       not null,
	activefees  char(40)       not null,
	modifieddate datetime
	primary key (feeID),
	constraint fk_fees_fines_orders foreign key (orderID) references orders (orderID),
	constraint fk_fees_fines_customers foreign key (customerID) references customers (customerID) 

)

create table librarycard 
(
	libraryID    int	     not null,
	customerID   int	     not null,
	customername varchar(20) not null,
	firstname    nvarchar(20)not null,
	lastname     nvarchar(20)not null,
	overdue      char(20)	 not null,
	activefees   char(20)	 not null,
	damaged		 char(18)	 not null,
	state		 char(2)	 null,
	modifieddate datetime
	primary key (libraryID),

	
)

create table suppliers 
(
	supplierID   int			not null,
	suppliername varchar(50)	not null,
	firstname    nvarchar(55)	not null,
	lastname     nvarchar(55)	not null,
	phone        varchar(25)	not null,
	city		 varchar(45)	null,
	state        varchar(10)	null,
	postalcode   varchar(12)    null,
	modifieddate datetime		not null,
	modifiedby   varchar(30)	null,
	primary key (supplierID)


)






create table products
(
	productID	  int			 not null,
	supplierID	  int			 not null,
	authorID	  int			 not null,
	name		  nvarchar(30)	 not null,
	productnumber nvarchar(40)	 not null,
	listprice     money		     not null,
	unitprice     money		     not null,
	standardcost  money		     not null,
	damaged       bit		     not null,
	overdue       bit		     not null,
	modifieddate  datetime		 not null,
	modifiedby	  varchar(30)	 null,
	primary key (productID),
	constraint fk_products_authors foreign key (authorID) references authors(authorID),
	constraint fk_products_suppliers foreign key (supplierID) references suppliers (supplierID)

)
go
 create trigger trg_product
 on				products
 after			Insert, update, delete
 as
 begin
				update products
				set modifieddate = getdate()
end 
go




--address
insert into address (addressID, addressline1, addressline2, city , state, postalcode, modifieddate) values (1, '983 Bridgeton Court', '459 Dixon Ave', 'Blacksburg', 'VA', '24060', GETDATE());
insert into address (addressID, addressline1, addressline2, city , state, postalcode, modifieddate) values (2, '37 North Gartner Drive', '9 Graedel Court', 'Grand Forks', 'ND', '58201', GETDATE());
insert into address (addressID, addressline1, addressline2, city , state, postalcode, modifieddate) values (3, '9712 Airport St', '88 Cambridge Alley', 'Henderson', 'KY', '42420', GETDATE());
insert into address (addressID, addressline1, addressline2, city , state, postalcode, modifieddate) values (4, '215 Old Roberts Rd', '42903 Summit Lane', 'Portland', 'ME', '04103', GETDATE());
insert into address (addressID, addressline1, addressline2, city , state, postalcode, modifieddate) values (5, '737 Harvey St', '02874 Del Sol Plaza', 'Groton', 'CT', '06340', GETDATE());
insert into address (addressID, addressline1, addressline2, city , state, postalcode, modifieddate) values (6, '8141 Ridewood Court', '91033 Logan Center', 'Oswego', 'NY', '13126', GETDATE());
insert into address (addressID, addressline1, addressline2, city , state, postalcode, modifieddate) values (7, '177 Spring Court', '724 Buena Vista Way', 'Jamestown', 'NY', '14701', GETDATE());
insert into address (addressID, addressline1, addressline2, city , state, postalcode, modifieddate) values (8, '96 Clay Ave', '0547 Maryland Place', 'Augusta', 'GA', '30906', GETDATE());
insert into address (addressID, addressline1, addressline2, city , state, postalcode, modifieddate) values (9, '501 Peg Shop Drive', '68838 Nobel Terrace', 'Quakertown', 'PA', '18951', GETDATE());
insert into address (addressID, addressline1, addressline2, city , state, postalcode, modifieddate) values (10, '8619 Vernon Road', '6 Arapahoe Trail', 'Eugene', 'OR', '97402', GETDATE());
--person
insert into person (personID, addressID, persontype, firstname, lastname, addressline1, addressline2, phonenumber, city, state, postalcode, modifieddate) values (1, 1, 'Female', 'Dee dee', 'Cabble', '9 Ridgeview Drive', '4335 Ilene Center', '203-988-2012', 'Stamford', 'CT', '06905', getdate());
insert into person (personID, addressID, persontype, firstname, lastname, addressline1, addressline2, phonenumber, city, state, postalcode, modifieddate) values (2, 2, 'Female', 'Sheree', 'Totton', '396 Loomis Trail', '776 Eagle Crest Hill', '607-295-6487', 'Elmira', 'NY', '14905', getdate());
insert into person (personID, addressID, persontype, firstname, lastname, addressline1, addressline2, phonenumber, city, state, postalcode, modifieddate) values (3, 3, 'Female', 'Lorie', 'Watsam', '01 Sycamore Terrace', '6 Mccormick Road', '989-108-2696', 'Midland', 'MI', '48670', getdate());
insert into person (personID, addressID, persontype, firstname, lastname, addressline1, addressline2, phonenumber, city, state, postalcode, modifieddate) values (4, 4, 'Male', 'Alva', 'Frarey', '94556 Lake View Terrace', '2508 Division Pass', '530-901-3105', 'Sacramento', 'CA', '95818', getdate());
insert into person (personID, addressID, persontype, firstname, lastname, addressline1, addressline2, phonenumber, city, state, postalcode, modifieddate) values (5, 5, 'Male', 'Frederigo', 'Swoffer', '75486 Pearson Point', '55 Ronald Regan Plaza', '808-511-0354', 'Honolulu', 'HI', '96810', getdate());
insert into person (personID, addressID, persontype, firstname, lastname, addressline1, addressline2, phonenumber, city, state, postalcode, modifieddate) values (6, 6, 'Female', 'Jenn', 'Nettleship', '833 Northview Crossing', '78 Transport Way', '773-664-1086', 'Chicago', 'IL', '60646', getdate());
insert into person (personID, addressID, persontype, firstname, lastname, addressline1, addressline2, phonenumber, city, state, postalcode, modifieddate) values (7, 7, 'Male', 'Craggy', 'Gascar', '760 Springs Place', '7526 Starling Court', '480-819-5811', 'Gilbert', 'AZ', '85297', getdate());
insert into person (personID, addressID, persontype, firstname, lastname, addressline1, addressline2, phonenumber, city, state, postalcode, modifieddate) values (8, 8, 'Female', 'Alana', 'Ourtic', '7817 Golf View Crossing', '55 North Drive', '862-600-8126', 'Paterson', 'NJ', '07544', getdate());
insert into person (personID, addressID, persontype, firstname, lastname, addressline1, addressline2, phonenumber, city, state, postalcode, modifieddate) values (9, 9, 'Male', 'Harwell', 'Bannister', '8 Toban Road', '7803 Surrey Drive', '775-755-1627', 'Reno', 'NV', '89510', getdate());
insert into person (personID, addressID, persontype, firstname, lastname, addressline1, addressline2, phonenumber, city, state, postalcode, modifieddate) values (10, 10, 'Female', 'Christal', 'Findon', '97 Hayes Drive', '927 David Place', '573-182-5273', 'Columbia', 'MO', '65218', getdate());
--publishers
insert into publishers (pubID, pubname, phone, city, state, postalcode, modifieddate, modifiedby) values (1, 'Barri Whitfeld', '754-799-5110', 'Pompano Beach', 'FL', '33069', getdate(), ORIGINAL_LOGIN());
insert into publishers (pubID, pubname, phone, city, state, postalcode, modifieddate, modifiedby) values (2, 'Franciskus Davison', '804-386-8628', 'Richmond', 'VA', '23220', getdate(), original_login());
insert into publishers (pubID, pubname, phone, city, state, postalcode, modifieddate, modifiedby) values (3, 'Fidela Tebbutt', '786-427-8532', 'Miami', 'FL', '33164', getdate(), original_login());
insert into publishers (pubID, pubname, phone, city, state, postalcode, modifieddate, modifiedby) values (4, 'Abramo Lowensohn', '562-544-0232', 'San Francisco', 'CA', '94110', getdate(), original_login());
insert into publishers (pubID, pubname, phone, city, state, postalcode, modifieddate, modifiedby) values (5, 'Mead Fairn', '828-819-2919', 'Asheville', 'NC', '28805', getdate(), original_login());
insert into publishers (pubID, pubname, phone, city, state, postalcode, modifieddate, modifiedby) values (6, 'Grethel Brickwood', '208-117-2635', 'Boise', 'ID', '83711', getdate(), original_login());
insert into publishers (pubID, pubname, phone, city, state, postalcode, modifieddate, modifiedby) values (7, 'Fitzgerald Matteucci', '339-326-7136', 'Woburn', 'MA', '01813', getdate(), original_login());
insert into publishers (pubID, pubname, phone, city, state, postalcode, modifieddate, modifiedby) values (8, 'Henry Pevie', '865-842-1045', 'Knoxville', 'TN', '37924', getdate(), original_login());
insert into publishers (pubID, pubname, phone, city, state, postalcode, modifieddate, modifiedby) values (9, 'Michale Kear', '224-901-1252', 'Chicago', 'IL', '60604', getdate(), original_login());
insert into publishers (pubID, pubname, phone, city, state, postalcode, modifieddate, modifiedby) values (10, 'Cindee Bonallick', '214-665-5629', 'Denton', 'TX', '76210', getdate(), original_login());

--authors
insert into authors (authorID, pubID, authorfirstname, authorlastname, homephone, cellphone, city, state, postalcode, modifieddate, modifiedby) values (1, 1, 'Carr', 'Canto', '202-483-6969', '716-761-9884', 'Washington', 'DC', '20210', getdate(), original_login());
insert into authors (authorID, pubID, authorfirstname, authorlastname, homephone, cellphone, city, state, postalcode, modifieddate, modifiedby) values (2, 2, 'Kendrick', 'Brame', '765-166-9618', '315-501-8883', 'Anderson', 'IN', '46015', getdate(), original_login());
insert into authors (authorID, pubID, authorfirstname, authorlastname, homephone, cellphone, city, state, postalcode, modifieddate, modifiedby) values (3, 3, 'Salvidor', 'Allewell', '310-996-0660', '440-295-3451', 'Santa Monica', 'CA', '90410', getdate(), original_login());
insert into authors (authorID, pubID, authorfirstname, authorlastname, homephone, cellphone, city, state, postalcode, modifieddate, modifiedby) values (4, 4, 'Luther', 'Mouncey', '504-985-0798', '216-204-8034', 'New Orleans', 'LA', '70160', getdate(), original_login());
insert into authors (authorID, pubID, authorfirstname, authorlastname, homephone, cellphone, city, state, postalcode, modifieddate, modifiedby)values (5, 5, 'Gannie', 'Seefeldt', '254-389-1678', '419-255-9953', 'Waco', 'TX', '76796', getdate(), original_login());
insert into authors (authorID, pubID, authorfirstname, authorlastname, homephone, cellphone, city, state, postalcode, modifieddate, modifiedby) values (6, 6, 'Delaney', 'Laddle', '814-661-3229', '412-294-3260', 'Erie', 'PA', '16565', getdate(), original_login());
insert into authors (authorID, pubID, authorfirstname, authorlastname, homephone, cellphone, city, state, postalcode, modifieddate, modifiedby) values (7, 7, 'Orv', 'Domenici', '412-484-2200', '915-550-6595', 'Pittsburgh', 'PA', '15225', getdate(), original_login());
insert into authors (authorID, pubID, authorfirstname, authorlastname, homephone, cellphone, city, state, postalcode, modifieddate, modifiedby) values (8, 8, 'Hamilton', 'Leaver', '309-668-5828', '212-962-5568', 'Carol Stream', 'IL', '60158', getdate(), original_login());
insert into authors (authorID, pubID, authorfirstname, authorlastname, homephone, cellphone, city, state, postalcode, modifieddate, modifiedby) values (9, 9, 'Fleming', 'Axell', '813-572-1668', '865-438-7527', 'Tampa', 'FL', '33605', getdate(), original_login());
insert into authors (authorID, pubID, authorfirstname, authorlastname, homephone, cellphone, city, state, postalcode, modifieddate, modifiedby) values (10, 10, 'Fair', 'Cardoe', '202-147-8810', '713-825-9633', 'Alexandria', 'VA', '22309', getdate(), original_login());
--customers
insert into customers (customerID, personID, firstname, lastname, homephone, cellphone, city, state, postalcode, modifieddate) values (1, 1, 'Lancelot', 'Pickle', '915-871-8526', '520-235-3580', 'El Paso', 'TX', '88525', getdate());
insert into customers (customerID, personID, firstname, lastname, homephone, cellphone, city, state, postalcode, modifieddate) values (2, 2, 'Yanaton', 'Fetherstonhaugh', '253-933-4192', '714-893-7326', 'Kent', 'WA', '98042', getdate());
insert into customers (customerID, personID, firstname, lastname, homephone, cellphone, city, state, postalcode, modifieddate) values (3, 3, 'Tammy', 'Heynen', '704-259-8715', '612-818-2131', 'Charlotte', 'NC', '28256', getdate());
insert into customers (customerID, personID, firstname, lastname, homephone, cellphone, city, state, postalcode, modifieddate) values (4, 4, 'Alonzo', 'Kinforth', '626-151-2952', '540-280-3520', 'Pasadena', 'CA', '91125', getdate());
insert into customers (customerID, personID, firstname, lastname, homephone, cellphone, city, state, postalcode, modifieddate) values (5, 5, 'Gayelord', 'Camillo', '714-319-0294', '562-340-3092', 'Fullerton', 'CA', '92835', getdate());
insert into customers (customerID, personID, firstname, lastname, homephone, cellphone, city, state, postalcode, modifieddate) values (6, 6, 'Zedekiah', 'Hinckley', '714-182-2490', '940-198-1805', 'Orange', 'CA', '92862', getdate());
insert into customers (customerID, personID, firstname, lastname, homephone, cellphone, city, state, postalcode, modifieddate) values (7, 7, 'Jethro', 'Wyper', '909-573-0372', '239-902-3302', 'San Bernardino', 'CA', '92410', getdate());
insert into customers (customerID, personID, firstname, lastname, homephone, cellphone, city, state, postalcode, modifieddate) values (8, 8, 'Gunner', 'Santon', '205-143-7988', '806-152-9211', 'Birmingham', 'AL', '35236', getdate());
insert into customers (customerID, personID, firstname, lastname, homephone, cellphone, city, state, postalcode, modifieddate) values (9, 9, 'Serge', 'Boatswain', '404-118-2490', '330-801-9402', 'Atlanta', 'GA', '31106', getdate());
insert into customers (customerID, personID, firstname, lastname, homephone, cellphone, city, state, postalcode, modifieddate) values (10, 10, 'Mahmoud', 'Calley', '262-640-0181', '704-187-9485', 'Racine', 'WI', '53405', getdate());
--orders

insert into orders (orderID, orderdate, shipdate, status, customerID, shiptoaddressID, city, state, postalcode, modifieddate) values (1, '2/10/2017', '1/1/2016', '005S4ZZ', 1, 1, 'Anchorage', 'AK', '99507', Getdate());
insert into orders (orderID, orderdate, shipdate, status, customerID, shiptoaddressID, city, state, postalcode, modifieddate) values (2, '5/21/2017', '1/31/2016', '06RT0JZ', 2, 2, 'Charlotte', 'NC', '28284', Getdate());
insert into orders (orderID, orderdate, shipdate, status, customerID, shiptoaddressID, city, state, postalcode, modifieddate) values (3, '9/13/2017', '2/24/2016', '0YWB30Z', 3, 3, 'Akron', 'OH', '44315', Getdate());
insert into orders (orderID, orderdate, shipdate, status, customerID, shiptoaddressID, city, state, postalcode, modifieddate) values (4, '8/14/2017', '1/21/2016', '0RWR33Z', 4, 4, 'New York City', 'NY', '10039', Getdate());
insert into orders (orderID, orderdate, shipdate, status, customerID, shiptoaddressID, city, state, postalcode, modifieddate) values (5, '7/24/2017', '10/4/2017', '0FN87ZZ', 5, 5, 'Sarasota', 'FL', '34238', Getdate());
insert into orders (orderID, orderdate, shipdate, status, customerID, shiptoaddressID, city, state, postalcode, modifieddate) values (6, '4/8/2017', '7/13/2017', '06B93ZX', 6, 6, 'Arlington', 'VA', '22212', Getdate());
insert into orders (orderID, orderdate, shipdate, status, customerID, shiptoaddressID, city, state, postalcode, modifieddate) values (7, '6/12/2017', '9/24/2017', '0L8Q0ZZ', 7, 7, 'Tampa', 'FL', '33625', Getdate());
insert into orders (orderID, orderdate, shipdate, status, customerID, shiptoaddressID, city, state, postalcode, modifieddate) values (8, '3/22/2017', '8/1/2017', '049R0ZZ', 8, 8, 'Washington', 'DC', '20036', Getdate());
insert into orders (orderID, orderdate, shipdate, status, customerID, shiptoaddressID, city, state, postalcode, modifieddate) values (9, '3/28/2017', '3/24/2017', '2W5JX7Z', 9, 9, 'Anchorage', 'AK', '99522', Getdate());
insert into orders (orderID, orderdate, shipdate, status, customerID, shiptoaddressID, city, state, postalcode, modifieddate) values (10, '5/5/2017', '12/24/2016', '0FUC4JZ', 10, 10, 'Tucson', 'AZ', '85748', Getdate());
--fees_fines
insert into fees_fines (feeID, orderID, customerID, overdue, damaged, reportedate, activefees, modifieddate) values (1, 1, 1, '5/11/2017', 'yelp.com', '8/6/2017', '70-367-6018', getdate());
insert into fees_fines (feeID, orderID, customerID, overdue, damaged, reportedate, activefees, modifieddate) values (2, 2, 2, '12/11/2016', 'independent.co.uk', '4/8/2017', '32-884-3638', getdate());
insert into fees_fines (feeID, orderID, customerID, overdue, damaged, reportedate, activefees, modifieddate) values (3, 3, 3, '2/8/2017', 'vk.com', '9/18/2017', '47-515-7452', getdate());
insert into fees_fines (feeID, orderID, customerID, overdue, damaged, reportedate, activefees, modifieddate) values (4, 4, 4, '2/16/2017', 'msu.edu', '3/13/2017', '32-411-0140', getdate());
insert into fees_fines (feeID, orderID, customerID, overdue, damaged, reportedate, activefees, modifieddate) values (5, 5, 5, '10/21/2017', 'yellowpages.com', '2/11/2017', '52-914-9235', getdate());
insert into fees_fines (feeID, orderID, customerID, overdue, damaged, reportedate, activefees, modifieddate) values (6, 6, 6, '11/12/2017', 'irs.gov', '3/7/2017', '38-956-9332', getdate());
insert into fees_fines (feeID, orderID, customerID, overdue, damaged, reportedate, activefees, modifieddate) values (7, 7, 7, '2/15/2017', 'ebay.com', '3/7/2017', '07-064-7033', getdate());
insert into fees_fines (feeID, orderID, customerID, overdue, damaged, reportedate, activefees, modifieddate) values (8, 8, 8, '11/12/2017', 'examiner.com', '7/27/2017', '61-633-8210', getdate());
insert into fees_fines (feeID, orderID, customerID, overdue, damaged, reportedate, activefees, modifieddate) values (9, 9, 9, '7/21/2017', 'hatena.ne.jp', '12/22/2016', '40-861-6570', getdate());
insert into fees_fines (feeID, orderID, customerID, overdue, damaged, reportedate, activefees, modifieddate) values (10, 10, 10, '5/22/2017', '163.com', '6/21/2017', '30-888-2675', getdate());
--librarycard

insert into librarycard (libraryID, customerID, customername, firstname, lastname, overdue, activefees, damaged , modifieddate) values (1, 1, 'Grantley', 'Penny', 'Blackly', '4/29/2017', 1, '76-967-2474', getdate());
insert into librarycard (libraryID, customerID, customername, firstname, lastname, overdue, activefees, damaged , modifieddate) values (2, 2, 'Saunders', 'Kristos', 'Kean', '8/22/2017', 0, '73-063-8763', getdate());
insert into librarycard (libraryID, customerID, customername, firstname, lastname, overdue, activefees, damaged , modifieddate) values (3, 3, 'Sheffie', 'Joni', 'Hapgood', '1/23/2017', 0, '92-024-3824', getdate());
insert into librarycard (libraryID, customerID, customername, firstname, lastname, overdue, activefees, damaged , modifieddate) values (4, 4, 'Kit', 'Fianna', 'Deener', '8/3/2017', 0, '51-584-6396', getdate());
insert into librarycard (libraryID, customerID, customername, firstname, lastname, overdue, activefees, damaged , modifieddate) values (5, 5, 'Durant', 'Inigo', 'Manhood', '8/25/2017', 1, '49-465-5348', getdate());
insert into librarycard (libraryID, customerID, customername, firstname, lastname, overdue, activefees, damaged , modifieddate) values (6, 6, 'Rolando', 'Norby', 'Stenet', '8/8/2017', 1, '56-536-5653', getdate());
insert into librarycard (libraryID, customerID, customername, firstname, lastname, overdue, activefees, damaged , modifieddate) values (7, 7, 'Goraud', 'Pavlov', 'Huckerbe', '4/17/2017', 1, '49-675-6053', getdate());
insert into librarycard (libraryID, customerID, customername, firstname, lastname, overdue, activefees, damaged , modifieddate) values (8, 8, 'Alexei', 'Bradney', 'Kopmann', '4/24/2017', 1, '92-163-3471', getdate());
insert into librarycard (libraryID, customerID, customername, firstname, lastname, overdue, activefees, damaged , modifieddate) values (9, 9, 'Cly', 'Shaine', 'Aston', '5/21/2017', 1, '81-383-7467', getdate());
insert into librarycard (libraryID, customerID, customername, firstname, lastname, overdue, activefees, damaged , modifieddate) values (10, 10, 'Reginauld', 'Mellicent', 'Hilldrop', '4/20/2017', 0, '10-295-6103', getdate());
--suppliers
insert into suppliers (supplierID, suppliername, firstname, lastname, phone, city, state, postalcode,  modifieddate, modifiedby) values (1, 'MAK-Leather', 'MAK', 'Leather', '716-873-1667', 'Buffalo', 'NY', '14207', getdate(), original_login());
insert into suppliers (supplierID, suppliername, firstname, lastname, phone, city, state, postalcode,  modifieddate, modifiedby) values (2, 'Metro Candy', 'Metro', 'Candy', '866-457-8668', 'Syosset', 'NY', '11791', getdate(), original_login());
insert into suppliers (supplierID, suppliername, firstname, lastname, phone, city, state, postalcode,  modifieddate, modifiedby) values (3, 'rick james', 'Morris', 'Kosher Poultry', '313-295-6300', 'Taylor', 'MI', '21405', getdate(), original_login());
insert into suppliers (supplierID, suppliername, firstname, lastname, phone, city, state, postalcode,  modifieddate, modifiedby) values (4, 'Acworth Library', 'Acworth', 'Library', '770-917-5165', 'Acworth', 'GE', '95167', getdate(), original_login());
insert into suppliers (supplierID, suppliername, firstname, lastname, phone, city, state, postalcode,  modifieddate, modifiedby) values (5, 'Central Library', 'Central', 'Library', '229-420-3200', 'Albany', 'GE', '30186', getdate(), original_login());
insert into suppliers (supplierID, suppliername, firstname, lastname, phone, city, state, postalcode,  modifieddate, modifiedby) values (6, 'Rogers Library', 'Rogers', 'Library', '401-253-6948', 'Bristol', 'RI', '02806', getdate(), original_login());
insert into suppliers (supplierID, suppliername, firstname, lastname, phone, city, state, postalcode,  modifieddate, modifiedby) values (7, 'Harmony Library', 'Harmony', 'Library', '401-949-2850', 'Glocester', 'RI', '02829', getdate(), original_login());
insert into suppliers (supplierID, suppliername, firstname, lastname, phone, city, state, postalcode,  modifieddate, modifiedby) values (8, 'Bunkelle Library', 'Bunkelle', 'Library', '702-346-5283', 'Bunkerville', 'Nevada', '78703', getdate(), original_login());
insert into suppliers (supplierID, suppliername, firstname, lastname, phone, city, state, postalcode,  modifieddate, modifiedby) values (9, 'Rainbow Library', 'Rainbow', 'Library', '702-507-3710', 'Las Vegas', 'Nevada', '75637', getdate(), original_login());
insert into suppliers (supplierID, suppliername, firstname, lastname, phone, city, state, postalcode,  modifieddate, modifiedby) values (10, 'Woodlawn Library', 'Woodlawn', 'Library', '302-571-7425', 'Wilmington', 'DE', '19805', getdate(), original_login());
--products
insert into products (productID, supplierID, authorID, name, productnumber, listprice, unitprice, standardcost, damaged, overdue, modifieddate, modifiedby) values (1, 1, 1, 'Cassaundra Rowbotham', '18-245-1174', '$1438.57', '$40.48', '$1782.71', 1, 1, getdate(), ORIGINAL_LOGIN());
insert into products (productID, supplierID, authorID, name, productnumber, listprice, unitprice, standardcost, damaged, overdue, modifieddate, modifiedby) values (2, 2, 2, 'Roseanne Dybbe', '92-951-6258', '$829.39', '$48.75', '$1648.61', 1, 0, getdate(), ORIGINAL_LOGIN());
insert into products (productID, supplierID, authorID, name, productnumber, listprice, unitprice, standardcost, damaged, overdue, modifieddate, modifiedby) values (3, 3, 3, 'Tadio O'' Mara', '14-914-5798', '$1080.46', '$0.44', '$907.08', 0, 0, getdate(), ORIGINAL_LOGIN());
insert into products (productID, supplierID, authorID, name, productnumber, listprice, unitprice, standardcost, damaged, overdue, modifieddate, modifiedby) values (4, 4, 4, 'Emlynne Rymill', '24-047-3979', '$532.08', '$55.19', '$546.18', 0, 1, getdate(), ORIGINAL_LOGIN());
insert into products (productID, supplierID, authorID, name, productnumber, listprice, unitprice, standardcost, damaged, overdue, modifieddate, modifiedby) values (5, 5, 5, 'Reinald Ferryman', '93-372-9417', '$1084.44', '$94.68', '$570.06', 1, 0, getdate(), ORIGINAL_LOGIN());
insert into products (productID, supplierID, authorID, name, productnumber, listprice, unitprice, standardcost, damaged, overdue, modifieddate, modifiedby) values (6, 6, 6, 'Lois Sumpton', '81-307-6258', '$805.36', '$98.44', '$577.91', 0, 1, getdate(), ORIGINAL_LOGIN());
insert into products (productID, supplierID, authorID, name, productnumber, listprice, unitprice, standardcost, damaged, overdue, modifieddate, modifiedby) values (7, 7, 7, 'Maximilian Swires', '52-938-2488', '$1245.33', '$17.02', '$1294.66', 1, 0, getdate(), ORIGINAL_LOGIN());
insert into products (productID, supplierID, authorID, name, productnumber, listprice, unitprice, standardcost, damaged, overdue, modifieddate, modifiedby) values (8, 8, 8, 'Shirlee McTrustam', '44-547-1034', '$872.65', '$80.54', '$692.71', 0, 0, getdate(), ORIGINAL_LOGIN());
insert into products (productID, supplierID, authorID, name, productnumber, listprice, unitprice, standardcost, damaged, overdue, modifieddate, modifiedby) values (9, 9, 9, 'Agace Marnes', '51-163-5979', '$173.48', '$19.55', '$1906.39', 1, 1, getdate(), ORIGINAL_LOGIN());
insert into products (productID, supplierID, authorID, name, productnumber, listprice, unitprice, standardcost, damaged, overdue, modifieddate, modifiedby) values (10, 10, 10, 'Jerri Haffenden', '48-076-7009', '$968.42', '$42.71', '$1415.19', 1, 0, getdate(), ORIGINAL_LOGIN());
--employees
insert into employees (employeeID, empfirstname, emplastname, birthdate, gender, hiredate, city, state, postalcode, modifieddate) values (1, 'Karena', 'Garfath', '5/11/2017', 'Female', '3/22/2017', 'Akron', 'OH', '44321', getdate());
insert into employees (employeeID, empfirstname, emplastname, birthdate, gender, hiredate, city, state, postalcode, modifieddate) values (2, 'Kath', 'Legh', '11/20/2017', 'Female', '4/1/2017', 'Boston', 'MA', '02104', getdate());
insert into employees (employeeID, empfirstname, emplastname, birthdate, gender, hiredate, city, state, postalcode, modifieddate) values (3, 'Bev', 'MacWhan', '10/28/2017', 'Female', '6/26/2017', 'San Francisco', 'CA', '94147', getdate());
insert into employees (employeeID, empfirstname, emplastname, birthdate, gender, hiredate, city, state, postalcode, modifieddate) values (4, 'Gal', 'Harlin', '10/10/2017', 'Male', '3/22/2017', 'West Palm Beach', 'FL', '33411', getdate());
insert into employees (employeeID, empfirstname, emplastname, birthdate, gender, hiredate, city, state, postalcode, modifieddate) values (5, 'Peadar', 'Fetherstan', '5/17/2017', 'Male', '6/22/2017', 'Littleton', 'CO', '80127', getdate());
insert into employees (employeeID, empfirstname, emplastname, birthdate, gender, hiredate, city, state, postalcode, modifieddate) values (6, 'Guthrie', 'Bereford', '2/26/2017', 'Male', '7/23/2017', 'Nashville', 'TN', '37210', getdate());
insert into employees (employeeID, empfirstname, emplastname, birthdate, gender, hiredate, city, state, postalcode, modifieddate) values (7, 'Odo', 'Tole', '12/16/2016', 'Male', '4/23/2017', 'Boca Raton', 'FL', '33487', getdate());
insert into employees (employeeID, empfirstname, emplastname, birthdate, gender, hiredate, city, state, postalcode, modifieddate) values (8, 'Adele', 'Sille', '4/28/2017', 'Female', '5/18/2017', 'Topeka', 'KS', '66699', getdate());
insert into employees (employeeID, empfirstname, emplastname, birthdate, gender, hiredate, city, state, postalcode, modifieddate) values (9, 'Walker', 'Aslett', '9/2/2017', 'Male', '8/25/2017', 'San Diego', 'CA', '92160', getdate());
insert into employees (employeeID, empfirstname, emplastname, birthdate, gender, hiredate, city, state, postalcode, modifieddate) values (10, 'Mychal', 'Kwietek', '5/17/2017', 'Male', '4/16/2017', 'Gatesville', 'TX', '76598', getdate());



--Index


create index idx_authorID on authors (authorID)


create index idx_status   on orders  (status)


create index idx_orderID  on orders  (orderID)


create index idx_employeeID on employees (employeeID)


create index idx_libraryID on librarycard (libraryID)


create index idx_customerID on librarycard (customerID)











