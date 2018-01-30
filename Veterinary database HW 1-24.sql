use master
if (select count(*) from sys.databases where name = 'Veterinary')> 0 
begin
	drop database veterinary
end

create database veterinary
go







USE veterinary
GO

------client table
CREATE TABLE clients
(
	clientID	 INT identity(1,1),
	firstname	VARCHAR(25)  not null,
	lastname	VARCHAR(25)  not null,
	middleName  VARCHAR(25),
	createdate  DATE   DEFAULT getdate()     
	PRIMARY KEY   (clientID)


)



-----client contact table
CREATE TABLE clientcontacts 
(
	addressID    INT IDENTITY (1,1),
	clientID     INT  not null,
	addresstype  INT  not null,
	addressline1  VARCHAR(50) not null,
	addressline2  VARCHAR(50) not null,
	city		  VARCHAR(35) not null,
	stateprovince VARCHAR(25) not null,
	postalcode    VARCHAR(15) not null,
	phone		  VARCHAR(15) not null,
	altphone      VARCHAR(15) not null,
	email		  VARCHAR(35) not null,
	PRIMARY KEY (addressID),
	CONSTRAINT fk_clientcon_client FOREIGN KEY (clientID) REFERENCES clients (clientID),
	CONSTRAINT chk_addresstype CHECK (addresstype = 1 OR addresstype = 2)
)





------animaltype table
CREATE TABLE animaltypereference
(
	animaltypeID  INT  IDENTITY (1,1),
	species       VARCHAR(30)  not null,
	breed         VARCHAR(35)  not null,
	PRIMARY KEY  (animaltypeID) 
)




-----patients table
CREATE TABLE patients 
(
	patientID      INT IDENTITY (1,1),
	clientID       INT,
	patname        VARCHAR(35)  not null,
	animaltype     INT           not null,
	color	       VARCHAR(25),
	gender         VARCHAR(2)   not null,
	birthyear      VARCHAR(4),
	[weight]       DECIMAL(2)   not null,
	[description]  VARCHAR(1024),
	generalnotes   VARCHAR(2048) not null,
	rabiesvacc    DATETIME,
	PRIMARY KEY  (patientID),
	CONSTRAINT fk_patients_clients FOREIGN KEY (clientID) REFERENCES clients (clientID),
	CONSTRAINT fk_patients_animaltype FOREIGN KEY (animaltype) REFERENCES animaltypereference (animaltypeID)
) 





-----employee table
CREATE TABLE employees
(
	employeeID	  INT IDENTITY (1,1),
	lastname     VARCHAR(25)  not null,
	firstname    VARCHAR(25)  not null,
	middlename   VARCHAR(25)  not null,
	hiredate     DATE         not null,
	title        VARCHAR(50)  not null,
	PRIMARY KEY (employeeID)

)




----employeecontact table
CREATE TABLE employeecontactinfo
(
	addressID     INT IDENTITY (1,1),
	employeeID    INT         not null,
	addresstype   INT         not null,
	addressline1  VARCHAR(50) not null,
	addressline2  VARCHAR(50) not null,
	city          VARCHAR(35) not null,
	stateprovince VARCHAR(25) not null,
	postalcode    VARCHAR(15) not null,
	phone         VARCHAR(15) not null,
	altphone      VARCHAR(15),
	email		  VARCHAR(50),
	PRIMARY KEY  (addressID),
	CONSTRAINT fk_empcontact_employees FOREIGN KEY (employeeID) REFERENCES employees (employeeID)

)






------visits table
CREATE TABLE visits
(
	visitID        INT	 IDENTITY (1,1),
	starttime      DATETIME      not null,
	endtime        DATETIME      not null,
	appointment    BIT		     not null,
	diagnosiscode  VARCHAR(12)   not null,
	procedurecode  VARCHAR(12)   not null,
	visitnotes     VARCHAR(2048) not null,
	patientID      INT           not null,
	employeeID     INT           not null,
	PRIMARY KEY  (visitID),
	CONSTRAINT fk_visits_patients FOREIGN KEY (patientID) REFERENCES patients (patientID),
	CONSTRAINT fk_visits_employees FOREIGN KEY (employeeID) REFERENCES employees (employeeID),
	CONSTRAINT  chk_start_end CHECK (endtime > starttime)
	
)




------billing table

CREATE TABLE billing
(
	billID   INT  IDENTITY (1,1),
	billdate DATE    not null,
	clientID INT     not null,
	visitID  INT     not null,
	amount   DECIMAL not null,
	PRIMARY KEY (billID),
	CONSTRAINT fk_bill_clients FOREIGN KEY (clientID) REFERENCES clients (clientID),
	CONSTRAINT fk_bill_visits  FOREIGN KEY (visitID)  REFERENCES visits (visitID)

)




-----payments table
CREATE TABLE payments 
(
	paymentID   INT  IDENTITY (1,1),
	paymentdate DATE    not null,
	billID      INT,
	notes       VARCHAR(2048),
	amount      DECIMAL not null,
	PRIMARY KEY (paymentID),
	CONSTRAINT fk_pay_bill FOREIGN KEY (billID) REFERENCES billing (billID),
	CONSTRAINT chk_billdates CHECK (paymentdate  <= getdate())
)


-----inserts--------


INSERT INTO clients
            ( Firstname , lastname)
VALUES      ('John', 'Smith'),
			('Bob', 'Jones'),
			('Harry', 'Lukan'),
			('Blake', 'Williams'),
			('Tyler', 'Davis')


			

INSERT INTO clientcontacts
            (  clientID,addresstype, addressline1, addressline2, city, stateprovince,
			 postalcode, phone, altphone, email)
VALUES      (1, '1', '564 Sea way', '4536 Gorge pass', 'Boston', 'NY', '45867', 
             '456-758-6674', '546-561-2314', 'austinh@yahoo.com'),

			(2, '2', '3278 Pinellas pass', '6456 Johnson path', 'Jackson', 'WY',
			 '65345', '785-785-6456', '445-624-5039', 'donq@gmail.com'),

			(3, '1', '468 John loop', '645 Turkey LN', 'Hershey', 'PA',
			 '63490', '437-780-9007', '578-712-2234', 'cynthiasmith@comcast.net'),


			(4, '2', '4667 Vine Ter', '645 Simon way', 'Las Vegas', 'NA',
			 '63433', '432-224-3427', '554-345-4432', 'ryanjohnson@yahoo.com'),


			(5, '1', '468 John loop', '645 Turkey LN', 'Hershey', 'PA',
			 '63490', '437-780-9007', '578-712-2234', 'cynthiasmith@comcast.net')



INSERT INTO animaltypereference 
			( species, breed)
VALUES		( 'Dog', 'Rottweiller'),
			('Cat', 'Persian'),
			('Horse', 'Arabian'),
			('Dog' , 'Pitbull'),
			('Cat', 'Sphynx'),
			('Bird', 'Caique'),
			('Cat', 'Maine Coon')
			





INSERT INTO patients
            (  patname, animaltype, color, gender, birthyear, [weight], [description], generalnotes)

VALUES      ('Rufus', '1',  'Brown', 'M', '09', '8.9', 'Dark brown with a light brown spot',
             'The light brown spot is above the eye'),
			
			( 'Smokey', '2', 'Grey stripes', 'M', '10', '4.2', 'Grey stripes on the tail',
			 ' Missing some of tail, snagged by a piece of barbedwire'),

			( 'Sundance', '3',  'Chestnut', 'F', '04', '5.2', 'Chestnut mane as well
			 as the color of the body', 'Fast horse, likes to take off on the rider, does not like carrots'),


			(  'Maui', '4',   'Dark grey and Auroa blue', 'F', '6.1', '63.1', 'Cut ears and
			 dark brown eyes', 'very fit, likes to play and run a lot'),

			 
		    ( 'Jake', '5', 'Dark grey', 'M', '4.2', '8.5', 'Dark grey all the way around',
			 'Jake is lazy, is in one spot all day long'),
			 
			 
			(  'Larry', '6', 'White', 'M', '17', '2.8', 'White with a tip of black on top of
			 head', 'Larry will mimick you and mock you, very unlikeable'),
 

			(  'Shelly', '7', 'Calico', 'F', '13', '5.1', 'White with black and orange spots
			  all over', 'Shelly is timid, keeps to herself in the garage')
		








INSERT INTO employees
			(firstname, middlename, lastname, hiredate, title)
VALUES      ('Charles', 'Marie',  'Withers', getdate(), 'Vet assistant'),
			('Ray', 'Pete',    'Johns',  getdate(),  'Veterinarian'),
			('Patty', 'Shell',   'Harris',getdate(),   'Veterinarian'),
			('Tyler', 'Rick',  'Shoeman', getdate(), 'Vetclerk'),
			('Mark', 'Anthony', 'Jones',  getdate(),   'Vet medicine'),
			('Steven', 'Turner', 'Cannon',  getdate(), 'Part time'),
			('John', 'Don',	'Wiles', getdate(),   'Volunteer')
			


INSERT INTO  employeecontactinfo
			 (employeeID, addresstype, addressline1, addressline2, city, stateprovince, postalcode,
			  phone, altphone, email)
VALUES       (1,   '2',    '4458 SW Ark Pass', '543 Wreath LP', 'Lexington', 'KY', '56754',
              ' 578-782-9965', '578-783-5565', 'CharlesW@yahoo.com'),
			 
			 (2,  '1',  '453 NW Seaweed Ln', '4564 Harris Terr', 'Philidelphia', 'PA', '33354',
			  '645-877-9904', '886-855-5555', 'JohnsRay@gmail.com'),

		     (3,  '2',  '4573 NE 60th CT', '4564 Harris Jct', 'Orlando', 'FL', '34450',
			  '345-455-5666', '345-675-5556', 'VetPatty@aol.com'),

			 
			 (4,  '1',  '456 SE 123rd Pl', '422 crabcake lp', 'Ocala', 'FL', '34472',
			  '352-567-7834', '352-667-000', 'Tylerthevetman@gmail.com'),


			 (5,  '2',  '343 Johns Way', '4999 Patek Terr', 'Gainesville', 'FL', '34491',
			  '352-555-6782', '352-455-6711', 'MarkD@yahoo.com'),

			 (6,   '1', '4570 Fishman Path', '456 Bug Jct', 'Alanta', 'GA', '45670',
			  '912-674-7708', '912-333-5621', 'Stevencannon@aol.com'),
			  
			 (7,   '2', '4897 Granit Terr', '544 Rolland Way', 'Austin', 'TX', '43226',
			  '364-675-8675', '364-564-5643', 'JohnWiles@yahoo.com')




INSERT INTO visits
            ( starttime, endtime, appointment, diagnosiscode, procedurecode, visitnotes, patientID, employeeID)

VALUES      (  '2016-08-12', '2016-08-13', '1', 'FREELANCE7', 'PROC125', 'Patient was ill, had the flu,
             had to give him some antibiodics to treat him' , '1' , '1'),

			(  '2016-10-12', '2016-10-14', '0', 'CATHELP3', 'PRO1675', 'Had a mild case of heartworms, just 
			 going to give patient heartworm medicine', '2', '2'),

			( '2017-03-14', '2017-03-15','1', 'HORSEHELP7', 'PROC1693', 'Patient had equine collic, had to use
			 a nasogastric tube to remove gas in the gut', '3', '3'),

			('2017-05-02', '2017-05-04','1', 'DOGHELP7' ,  'PROC2554', ' Patient had Lyme disease, had to issue an
			  antibiodic called, Doxycycline to treat the Lyme disease', '4', '4'),

			( '2018-01-01', '2018-01-02','0', 'CAT', 'PROC234', ' Client had to take her cat in,
			    she was not eating properly', '5', '5')








--Login and user drop statements------
 IF (select count(*) FROM sys.syslogins WHERE NAME = 'VetManager') > 0
	DROP LOGIN [VetManager]


IF (select count(*) FROM sys.syslogins WHERE NAME = 'VetClerk') > 0
	DROP LOGIN [VetClerk]






------Logins and users---------

CREATE LOGIN VetClerk
WITH PASSWORD = '1234'
GO


CREATE USER VetClerk FOR LOGIN VetClerk
GO


CREATE LOGIN VetManager
WITH PASSWORD = '4321'
GO


CREATE USER VetManager FOR LOGIN VetManager
GO


-----Alter roles-----
ALTER ROLE db_reader ADD member [VetManager]
ALTER ROLE db_writer ADD member [vetmanager]
ALTER ROLE db_reader ADD member [VetClerk]

DENY SELECT ON employeecontactinfo TO VetClerk
DENY SELECT ON clientcontacts     TO VetClerk






-----stored procedures-----
CREATE PROCEDURE species
(
	@species  VARCHAR(MAX)
)
AS
BEGIN



	SELECT	p.patname, c.firstname, c.lastname, cc.addressline1, cc.addressline2, cc.city,
	        cc.stateprovince, cc.postalcode, cc.phone, cc.altphone, cc.email

FROM        clientcontacts cc
JOIN        clients c
ON          c.clientID = cc.clientID
JOIN        patients p
ON			c.clientID = p.clientID
JOIN		animaltypereference ar
ON          p.animaltype = ar.animaltypeID
WHERE      ar. species LIKE  '%' + @species + '%'
END
GO





CREATE PROCEDURE spbreed
(
	@breed VARCHAR(MAX)
)
AS
BEGIN



	SELECT	p.patname, c.firstname, c.lastname, cc.addressline1, cc.addressline2, cc.city,
	        cc.stateprovince, cc.postalcode, cc.phone, cc.altphone, cc.email

FROM        clientcontacts cc
JOIN        clients c
ON          c.clientID = cc.clientID
JOIN        patients p
ON			c.clientID = p.clientID
JOIN		animaltypereference ar
ON          p.animaltype = ar.animaltypeID
WHERE      ar. breed LIKE '%' + @breed + '%'
END
GO




CREATE PROCEDURE spemp

AS
BEGIN

	SELECT  e.firstname, e.lastname, ec.addressline1, ec.addressline2, ec.city, ec.stateprovince,
	        ec.postalcode, ec.phone
    FROM    employees e
	JOIN    employeecontactinfo ec
	ON      ec.employeeID = e.employeeID
END
GO

--EXEC spemp 



