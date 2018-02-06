USE master 
 IF (SELECT COUNT(*) FROM sys.sysdatabases WHERE NAME = 'Online seminar') > 0
 BEGIN
	DROP DATABASE [Online seminar]
END

	CREATE DATABASE [online seminar]
GO

--------create table statements----------


USE [online seminar]


CREATE TABLE Subscriptions
(
	subscriptionID    INT         not null IDENTITY (1,1),
	subscriptiontype  VARCHAR(25) not null,
	stillactive       BIT         not null,
	subscriptionprice SMALLMONEY  not null,
	joineddate        DATETIME    not null,
	PRIMARY KEY       (subscriptionID)
)







CREATE TABLE Members
(
	memberID		 INT		   not null,
	firstname		 VARCHAR(30)   not null,
	middlename		 VARCHAR(30)   not null,
	lastname		 VARCHAR(30)   not null,
	gender			 VARCHAR(8)    not null,
	currentflag		 BIT           null,
	birthdate		 DATETIME      not null,
	subscriptionID   INT		   not null,
	PRIMARY   KEY    (memberID),
	CONSTRAINT fk_subcriptionID  FOREIGN KEY (subscriptionID) REFERENCES Subscriptions (subscriptionID)
)






CREATE TABLE Memberinterests
(
	memberinterestID    INT         not null IDENTITY (1,1),
	memberID            INT         not null,
	interest1           VARCHAR(30) null,
	interest2           VARCHAR(30) null,
	interest3           VARCHAR(30) null,
	PRIMARY KEY    (memberinterestID),
	CONSTRAINT fk_memberID FOREIGN KEY (memberID) REFERENCES Members (memberID)
)





CREATE TABLE [Address]
(
	addressID         INT            not null IDENTITY(1,1),
	memberID          INT            not null,
	addressline1      VARCHAR(30)    not null,
	addressline2      VARCHAR(30)    null,
	city              VARCHAR(30)    not null,
	[state]           VARCHAR(25)    not null,
	zipcode           VARCHAR(8)     not null,
	PRIMARY KEY       (addressID),
	CONSTRAINT fk_address_memberID FOREIGN KEY (memberID) REFERENCES Members (memberID)
)






CREATE TABLE Contactinfo
(
	contactID     INT		   not null IDENTITY(1,1),
	memberID      INT		   not null,
	email         VARCHAR(40)  not null,
	phonenumber   VARCHAR(12)  not null,
	PRIMARY KEY   (contactID),
	CONSTRAINT fk_contact_memberID  FOREIGN KEY (memberID) REFERENCES Members (memberID)
)





CREATE TABLE [events]
(
	eventID      INT         not null IDENTITY(1,1),
	eventtitle   VARCHAR(35) not null,
	eventspeaker VARCHAR(20) not null,
	eventdate    DATETIME    not null,
	PRIMARY KEY  (eventID)
)







CREATE TABLE Eventmembers
(
	memberID     INT        not null,
	eventID      INT        not null,
	attendance   BIT        not null,
	PRIMARY KEY (memberID, eventID),  -------creates a composite primary key
	CONSTRAINT  fk_eventmemberID FOREIGN KEY (memberID) REFERENCES Members (memberID),
	CONSTRAINT  fk_eventmemberevent FOREIGN KEY (eventID) REFERENCES [Events] (eventID)
	
) 





CREATE TABLE transactions
(   
	transID          INT	    not null IDENTITY(1,1),
	memberID         INT		not null,
	transactiondate  DATETIME   not null,
	charges          SMALLMONEY not null,
	approved         BIT       null,
	PRIMARY KEY     (transID),
	CONSTRAINT fk_transmemberID FOREIGN KEY (memberID) REFERENCES Members (memberID)
)






CREATE TABLE paymentinfo
(
	creditcardID     INT        not null IDENTITY (1,1),
	transID          INT        not null,
	memberID         INT        not null,
	cardtype       VARCHAR(20)  not null,
	cardnumber     VARCHAR(50)  not null,
	expdate        DATETIME    not null,
	PRIMARY KEY   (creditcardID),
	CONSTRAINT  fk_transID FOREIGN KEY (transID) REFERENCES transactions (transID),
	CONSTRAINT fk_paymentmemberID FOREIGN KEY (memberID) REFERENCES Members (memberID)
)




--------Inserts-------------
 ----subscription insert

 INSERT INTO Subscriptions
			(subscriptiontype, subscriptionprice, stillactive, joineddate)
VALUES      ('monthly', '$9.99', '1', '4-7-2017')
 ------------------------------------------------------------------------
 INSERT INTO Subscriptions
			(subscriptiontype, subscriptionprice, stillactive, joineddate)
VALUES      ('monthly', '$9.99', '1', '11-29-2017')
 ----------------------------------------------------------------------------
 INSERT INTO Subscriptions
			(subscriptiontype, subscriptionprice, stillactive, joineddate)
VALUES      ('quarterly', '$27.00', '1', '2-26-2017')
----------------------------------------------------------------------------
 INSERT INTO Subscriptions
			(subscriptiontype, subscriptionprice, stillactive, joineddate)
VALUES      ('quarterly', '$27.00', '1', '11-5-2017')
----------------------------------------------------------------------------
 INSERT INTO Subscriptions
			(subscriptiontype, subscriptionprice, stillactive, joineddate)
VALUES      ('monthly', '$9.99', '1', '1-15-2016')
-------------------------------------------------------------------------------
 INSERT INTO Subscriptions
			(subscriptiontype, subscriptionprice, stillactive, joineddate)
VALUES      ('yearly', '$99.00', '1', '3-13-2017')
--------------------------------------------------------------------------------
 INSERT INTO Subscriptions
			(subscriptiontype, subscriptionprice, stillactive, joineddate)
VALUES      ('monthly', '$9.99', '1', '8-9-2017')
-----------------------------------------------------------------------------------
 INSERT INTO Subscriptions
			(subscriptiontype, subscriptionprice, stillactive, joineddate)
VALUES      ('yearly', '$99.00', '1', '9-9-2016')
--------------------------------------------------------------------------------
 INSERT INTO Subscriptions
			(subscriptiontype, subscriptionprice, stillactive, joineddate)
VALUES      ('yearly', '$99.00', '0', '11-21-2016')
--------------------------------------------------------------------------------
 INSERT INTO Subscriptions
			(subscriptiontype, subscriptionprice, stillactive, joineddate)
VALUES      ('monthly', '$9.99', '1', '12-22-2017')
-----------------------------------------------------------------------------
 INSERT INTO Subscriptions
			(subscriptiontype, subscriptionprice, stillactive, joineddate)
VALUES      ('monthly', '$9.99', '1', '3-19-2017')
-----------------------------------------------------------------------------
 INSERT INTO Subscriptions
			(subscriptiontype, subscriptionprice, stillactive, joineddate)
VALUES      ('quarterly', '$27.00', '1', '4-25-2016')
------------------------------------------------------------------------------
 INSERT INTO Subscriptions
			(subscriptiontype, subscriptionprice, stillactive, joineddate)
VALUES      ('yearly', '$99.00', '1', '3-21-2016')
-----------------------------------------------------------------------------
 INSERT INTO Subscriptions
			(subscriptiontype, subscriptionprice, stillactive, joineddate)
VALUES      ('monthly', '$9.99', '1', '1-27-2017')
---------------------------------------------------------------------------
 INSERT INTO Subscriptions
			(subscriptiontype, subscriptionprice, stillactive, joineddate)
VALUES      ('monthly', '$9.99', '0', '10-6-2017')





--insert into members

INSERT INTO members
			(memberID, firstname, middlename, lastname, gender, birthdate, currentflag, subscriptionID)
VALUES      (1,'otis', 'Brooke', 'Fallon', 'Male', '6-29-1971', '1', 1)

------------------------------------------------------------------------------------------
INSERT INTO members
			(memberID,firstname, middlename, lastname, gender, birthdate, currentflag, subscriptionID)
VALUES      (2,'katee', 'Virgie', 'Gepp', 'Female', '4-3-1972', '1', 2)

---------------------------------------------------------------------------------------------
INSERT INTO members
			(memberID,firstname, middlename, lastname, gender, birthdate, currentflag, subscriptionID)
VALUES      (3,'Lilla', 'Charmion', 'Eattok', 'female', '12-13-1975', '1', 3)

------------------------------------------------------------------------------------------
INSERT INTO members
			(memberID,firstname, middlename, lastname, gender, birthdate, currentflag, subscriptionID)
VALUES      (4,'Ddene', 'Shelba', 'Clapperton', 'female', '2-19-1997', '1', 4)
----------------------------------------------------------------------------------------------

INSERT INTO members
			(memberID,firstname, middlename, lastname, gender, birthdate, currentflag, subscriptionID)
VALUES      (5,'Audrye', 'Agathe', 'Dawks', 'female', '2-7-1989', '1', 5)

--------------------------------------------------------------------------------------------
INSERT INTO members
			(memberID,firstname, middlename, lastname, gender, birthdate, currentflag, subscriptionID)
VALUES      (6,'Fredi', 'Melisandra', 'Burgyn', 'female', '5-31-1956', '1', 6)

-----------------------------------------------------------------------------------------
INSERT INTO members
			(memberID,firstname, middlename, lastname, gender, birthdate, currentflag, subscriptionID)
VALUES      (7,'Dimitri', 'Francisco', 'Bellino', 'Male', '10-12-1976', '1', 7)

-------------------------------------------------------------------------------------------
INSERT INTO members
			(memberID,firstname, middlename, lastname, gender, birthdate, currentflag, subscriptionID)
VALUES      (8,'Enrico', 'Cleve', 'Seeney', 'Male', '2-29-1988', '1', 8)

----------------------------------------------------------------------------------------------
INSERT INTO members
			(memberID,firstname, middlename, lastname, gender, birthdate, currentflag, subscriptionID)
VALUES      (9,'Marylinda', 'Jennie', 'Osiaghail', 'female', '2-6-1965', '0', 9)

----------------------------------------------------------------------------------------------
INSERT INTO members
			(memberID,firstname, middlename, lastname, gender, birthdate, currentflag, subscriptionID)
VALUES      (10,'Luce', 'Codi', 'Kovalksi', 'Male', '3-31-1978', '1', 10)

-----------------------------------------------------------------------------------------------
INSERT INTO members
			(memberID,firstname, middlename, lastname, gender, birthdate, currentflag, subscriptionID)
VALUES      (11,'Claiborn', 'Shadow', 'Baldinotti', 'Male', '12-26-1991', '1', 11)

-----------------------------------------------------------------------------------------------
INSERT INTO members
			(memberID,firstname, middlename, lastname, gender, birthdate, currentflag, subscriptionID)
VALUES      (12,'Isabelle', 'Betty', 'Glossop', 'female', '2-17-1965', '1', 12)

-----------------------------------------------------------------------------------------------
INSERT INTO members
			(memberID,firstname, middlename, lastname, gender, birthdate, currentflag, subscriptionID)
VALUES      (13,'Davina', 'Lira', 'Wither', 'female', '12-16-1957', '1', 13)

------------------------------------------------------------------------------------------------
INSERT INTO members
			(memberID,firstname, middlename, lastname, gender, birthdate, currentflag, subscriptionID)
VALUES      (14,'Panchito', 'Hashim', 'DeGregorio', 'Male', '10-14-1964', '1', 14)

-------------------------------------------------------------------------------------------------
INSERT INTO members
			(memberID,firstname, middlename, lastname, gender, birthdate, currentflag, subscriptionID)
VALUES      (15,'Rowen', 'Arvin', 'Birdfield', 'Male', '1-9-1983', '0', 15)





--insert into memberinterests

INSERT INTO memberinterests
			( memberiD, interest1, interest2, interest3)
VALUES      (1, 'acting', 'video games', 'crossword puzzles')

-----------------------------------------------------------------------------
INSERT INTO memberinterests
			( memberiD, interest1, interest2, interest3)
VALUES      (2, 'caligraphy', NULL, NULL)

--------------------------------------------------------------------------
INSERT INTO memberinterests
			( memberiD, interest1, interest2, interest3)
VALUES      (3, 'movies', 'restaurants', 'woodworking')

--------------------------------------------------------------------------
INSERT INTO memberinterests
			( memberiD, interest1, interest2, interest3)
VALUES      (4, 'juggling', 'quilting', NULL)

---------------------------------------------------------------------
INSERT INTO memberinterests
			( memberiD, interest1, interest2, interest3)
VALUES      (5, 'electronics', NULL, NULL)

--------------------------------------------------------------------
INSERT INTO memberinterests
			( memberiD, interest1, interest2, interest3)
VALUES      (6, 'sewing', 'cooking', 'movies')

------------------------------------------------------------------------
INSERT INTO memberinterests
			( memberiD, interest1, interest2, interest3)
VALUES      (7, 'botany', 'skating', NULL)
-----------------------------------------------------------------------

INSERT INTO memberinterests
			( memberiD, interest1, interest2, interest3)
VALUES      (8, 'dancing', 'coffee', 'foreign laungauges')
------------------------------------------------------------------

INSERT INTO memberinterests
			( memberiD, interest1, interest2, interest3)
VALUES      (9, 'fashion',NULL, NULL)
---------------------------------------------------------------------

INSERT INTO memberinterests
			( memberiD, interest1, interest2, interest3)
VALUES      (10, 'woodworking', NULL, NULL)
--------------------------------------------------------------------
INSERT INTO memberinterests
			( memberiD, interest1, interest2, interest3)
VALUES      (11, 'homebrewing', 'genelology', 'movies, scapbooking')

-------------------------------------------------------------------
INSERT INTO memberinterests
			( memberiD, interest1, interest2, interest3)
VALUES      (12, 'surfing', 'amateur radio',NULL)

------------------------------------------------------------------
INSERT INTO memberinterests
			( memberiD, interest1, interest2, interest3)
VALUES      (13, 'computers',NULL, NULL)
--------------------------------------------------------------------

INSERT INTO memberinterests
			( memberiD, interest1, interest2, interest3)
VALUES      (14, 'writing', 'singing',NULL)

-----------------------------------------------------------------
INSERT INTO memberinterests
			( memberiD, interest1, interest2, interest3)
VALUES      (15, 'reading', 'pottery', NULL)





--insert into address

INSERT INTO [Address]
			(memberID, addressline1, addressline2, city, [state], zipcode)
VALUES		(1,  '020 New Castle Way', NULL, 'Port Washington', 'New York', '11054')
----------------------------------------------------------------------------------------

INSERT INTO [Address]
			(memberID, addressline1, addressline2, city, [state], zipcode)
VALUES		(2,  '8 Corry Parkway', 'PO Box 7088', 'Newton', 'Massachusetts', '2458')
-----------------------------------------------------------------------------------------

INSERT INTO [Address]
			(memberID, addressline1, addressline2, city, [state], zipcode)
VALUES		(3,  '39426 Stone Corner Drive', NULL, 'Peoria', 'illinois', '61605')
-----------------------------------------------------------------------------------------

INSERT INTO [Address]
			(memberID, addressline1, addressline2, city, [state], zipcode)
VALUES		(4,  '921 Granby Junction', NULL, 'Oklahoma city', 'Oklahoma', '73173')

------------------------------------------------------------------------------------
INSERT INTO [Address]
			(memberID, addressline1, addressline2, city, [state], zipcode)
VALUES		(5,  '77 Butternut Drive', NULL, 'Saint Paul', 'Minnesota', '55146')

-----------------------------------------------------------------------------------
INSERT INTO [Address]
			(memberID, addressline1, addressline2, city, [state], zipcode)
VALUES		(6,  '821 Ilene Drvie', NULL, 'Odessa', 'Texas', '79764')

------------------------------------------------------------------------------------
INSERT INTO [Address]
			(memberID, addressline1, addressline2, city, [state], zipcode)
VALUES		(7,  '1110 Johnson Court', NULL, 'Rochester', 'New York', '14624')

-----------------------------------------------------------------------------------
INSERT INTO [Address]
			(memberID, addressline1, addressline2, city, [state], zipcode)
VALUES		(8,  '6 Canary Hill', 'PO Box 225', 'Tallahassee', 'Florida', '32309')

------------------------------------------------------------------------------------
INSERT INTO [Address]
			(memberID, addressline1, addressline2, city, [state], zipcode)
VALUES		(9,  '9 Buhler Lane', NULL, 'Bismarck', 'North Dakota', '58505')

---------------------------------------------------------------------------------
INSERT INTO [Address]
			(memberID, addressline1, addressline2, city, [state], zipcode)
VALUES		(10,  '99 Northwestern Pass', NULL, 'Midland', 'Texas', '79710')

----------------------------------------------------------------------------------
INSERT INTO [Address]
			(memberID, addressline1, addressline2, city, [state], zipcode)
VALUES		(11,  '69 Spenser Hill', NULL, 'Provo', 'Utah', '84605')


--------------------------------------------------------------------------------------
INSERT INTO [Address]
			(memberID, addressline1, addressline2, city, [state], zipcode)
VALUES		(12,  '3234 Kings Court', 'PO Box 1233', 'Tacoma', 'Washington', '98424')

-------------------------------------------------------------------------------------
INSERT INTO [Address]
			(memberID, addressline1, addressline2, city, [state], zipcode)
VALUES		(13,  '3 Lakewood Gardens Circle', NULL, 'Columbia', 'South Carolina', '29225')

------------------------------------------------------------------------------------------
INSERT INTO [Address]
			(memberID, addressline1, addressline2, city, [state], zipcode)
VALUES		(14,  '198 Muir Parkway', NULL, 'Fairfax', 'Virginia', '22036')

---------------------------------------------------------------------------------------------
INSERT INTO [Address]
			(memberID, addressline1, addressline2, city, [state], zipcode)
VALUES		(15,  '258 Jenna Drive', NULL, 'Pensacola', 'Florida', '32520')




--insert into contactinfo

INSERT INTO Contactinfo
			(memberID, email, phonenumber)
VALUES      (1,     'bfallon@artisteer.com', '818-873-3863')
---------------------------------------------------------------
INSERT INTO Contactinfo
			(memberID, email, phonenumber)
VALUES      (2,     'vgepp1@nih.gov', '503-689-8066')
-------------------------------------------------------------------
INSERT INTO Contactinfo
			(memberID, email, phonenumber)
VALUES      (3,     'ceatttok2@google.com', '210-426-7426')
---------------------------------------------------------------------
INSERT INTO Contactinfo
			(memberID, email, phonenumber)
VALUES      (4,     'sclapperton3@mapquest.com', '716-674-1640')
-------------------------------------------------------------------------
INSERT INTO Contactinfo
			(memberID, email, phonenumber)
VALUES      (5,     'adawks4@mlb.com', '305-415-9419')
----------------------------------------------------------------------------------
INSERT INTO Contactinfo
			(memberID, email, phonenumber)
VALUES      (6,     'mburgyn5@cbslocal.com', '214-650-9837')
-------------------------------------------------------------------------
INSERT INTO Contactinfo
			(memberID, email, phonenumber)
VALUES      (7,     'fbellino6@devhub.com', '937-971-1026')
----------------------------------------------------------------------------
INSERT INTO Contactinfo
			(memberID, email, phonenumber)
VALUES      (8,     'cseeney7@macromedia.com', '407-445-6895')
------------------------------------------------------------------------
INSERT INTO Contactinfo
			(memberID, email, phonenumber)
VALUES      (9,     'josiaghail8@tuttocitta.it', '206-484-6850')
--------------------------------------------------------------------------
INSERT INTO Contactinfo
			(memberID, email, phonenumber)
VALUES      (10,     'ckovalski9@facebook.com', '253-159-6773')
----------------------------------------------------------------------
INSERT INTO Contactinfo
			(memberID, email, phonenumber)
VALUES      (11,     'sbaldinottia@discuz.net', '253-141-4314')
------------------------------------------------------------------------
INSERT INTO Contactinfo
			(memberID, email, phonenumber)
VALUES      (12,     'bglossopb@msu.edu', '412-646-5145')
--------------------------------------------------------------------------
INSERT INTO Contactinfo
			(memberID, email, phonenumber)
VALUES      (13,     'lwitherc@smugmug.com', '404-495-3676')
------------------------------------------------------------------------------
INSERT INTO Contactinfo
			(memberID, email, phonenumber)
VALUES      (14,     'hdegregoriod2a8.net', '484-717-6750')
------------------------------------------------------------------------------
INSERT INTO Contactinfo
			(memberID, email, phonenumber)
VALUES      (15,     'abirdfielde@over-blog.com', '915-299-3451')




--insert into events

INSERT INTO [Events]
			(eventtitle, eventspeaker, eventdate)
VALUES      ('The History Of Human Emotions', 'Tiffany Watt Smith', '1-12-2017')
------------------------------------------------------------------------------------
INSERT INTO [Events]
			(eventtitle, eventspeaker, eventdate)
VALUES      ('How Great Leaders Inspire Actions', 'Simon Sinek', '2-22-2017')
---------------------------------------------------------------------------------
INSERT INTO [Events]
			(eventtitle, eventspeaker, eventdate)
VALUES      ('The Puzzle of Motivation', 'Dan Pink', '3-5-2017')
-----------------------------------------------------------------------------
INSERT INTO [Events]
			(eventtitle, eventspeaker, eventdate)
VALUES      ('Your Elusive Creative Genius', 'Elizabeth Gilbert', '4-16-2017')
---------------------------------------------------------------------------------
INSERT INTO [Events]
			(eventtitle, eventspeaker, eventdate)
VALUES      ('Why Are Programmers So Smart?', 'Andrew Comeau', '5-1-2017')



--insert into eventmembers



INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (1,    1,     0)

-----------------------------------------------------------------

INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (1,    2,     0)

-----------------------------------------------------------------------

INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (1,    3,     1)

-----------------------------------------------------------------------

INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (1,    4,     1)

-------------------------------------------------------------------------


INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (1,    5,     1)

-------------------------------------------------------------------------

INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (2,    1,     1)

----------------------------------------------------------------------------

INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (2,    2,     0)

----------------------------------------------------------------------------

INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (2,    3,     1)

-------------------------------------------------------------------------------

INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (2,    4,     1)


-------------------------------------------------------------------------------
INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (2,    5,     0)

-----------------------------------------------------------------------------

INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (3,    1,     1)

-------------------------------------------------------------------------------

INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (3,    2,     1)

------------------------------------------------------------------------------

INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (3,    3,     1)

------------------------------------------------------------------------------

INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (3,    4,     0)

-----------------------------------------------------------------------------

INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (3,    5,     1)

---------------------------------------------------------------------------

INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (4,    1,     1)

-------------------------------------------------------------------------------

INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (4,    2,     1)

---------------------------------------------------------------------------------

INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (4,    3,     1)


-------------------------------------------------------------------------------
INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (4,    4,     1)

----------------------------------------------------------------------------------

INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (4,    5,     1)

---------------------------------------------------------------------------------

INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (5,    1,     1)

------------------------------------------------------------------------

INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (5,    2,     1)

----------------------------------------------------------------------------

INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (5,    3,     1)

------------------------------------------------------------------------------

INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (5,    4,     1)

-----------------------------------------------------------------------------

INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (5,    5,     0)

------------------------------------------------------------------------------

INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (6,    1,     1)

-----------------------------------------------------------------------------

INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (6,    2,     0)

-----------------------------------------------------------------------------

INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (6,    3,     1)


----------------------------------------------------------------------------
INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (6,    4,     1)

----------------------------------------------------------------------------

INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (6,    5,     0)


----------------------------------------------------------------------------
INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (7,    1,     0)

------------------------------------------------------------------------------

INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (7,    2,     1)
-------------------------------------------------------------------------------



INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (7,    3,     1)

-----------------------------------------------------------------------------

INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (7,    4,     1)
--------------------------------------------------------------------------------


INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (7,    5,     0)

------------------------------------------------------------------------------

INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (8,    1,     1)

----------------------------------------------------------------------------

INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (8,    2,     1)

-----------------------------------------------------------------------------

INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (8,    3,     1)

--------------------------------------------------------------------------------

INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (8,    4,     1)

-----------------------------------------------------------------------------------

INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (8,    5,     0)

------------------------------------------------------------------------------------

INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (9,    1,     0)

---------------------------------------------------------------------------

INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (9,    2,     1)

-----------------------------------------------------------------------------

INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (9,    3,     1)

---------------------------------------------------------------------------------

INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (9,    4,     1)

------------------------------------------------------------------------------

INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (9,    5,     0)

-------------------------------------------------------------------------------

INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (10,    1,     1)

-----------------------------------------------------------------------

INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (10,    2,     1)

--------------------------------------------------------------------------

INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (10,    3,     0)

-----------------------------------------------------------------------------

INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (10,    4,     0)

-------------------------------------------------------------------------

INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (10,    5,     0)

-----------------------------------------------------------------------

INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (11,    1,     1)

-------------------------------------------------------------------------

INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (11,    2,     1)

---------------------------------------------------------------------------

INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (11,    3,     0)

-------------------------------------------------------------------------------------

INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (11,    4,     0)

--------------------------------------------------------------------------------------

INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (11,    5,     0)

------------------------------------------------------------------------------

INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (12,    1,     1)
------------------------------------------------------------------------------

INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (12,    2,     0)

------------------------------------------------------------------------------
INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (12,    3,     1)

-------------------------------------------------------------------------
INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (12,    4,     1)

----------------------------------------------------------------------------

INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (12,    5,     1)

-------------------------------------------------------------------------------
INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (13,    1,     1)

-----------------------------------------------------------------------------
INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (13,    2,     1)

---------------------------------------------------------------------------------
INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (13,    3,     0)

----------------------------------------------------------------------------------
INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (13,    4,     0)

------------------------------------------------------------------------------------
INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (13,    5,     1)

------------------------------------------------------------------------------
INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (14,    1,     0)
-------------------------------------------------------------------------------
INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (14,    2,     1)

------------------------------------------------------------------------------
INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (14,    3,     1)

---------------------------------------------------------------------------------
INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (14,    4,     1)

-------------------------------------------------------------------------------
INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (14,    5,     0)

------------------------------------------------------------------------------
INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (15,    1,     1)

-----------------------------------------------------------------------------------
INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (15,    2,     1)

--------------------------------------------------------------------------------
INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (15,   3,     1)

------------------------------------------------------------------------------
INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (15,    4,     1)

------------------------------------------------------------------------------
INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (15,    5,     0)
------------------------------------------------------------------------------









--insert into transactions

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(5,     '1/15/2016', '$9.99', '1')
-----------------------------------------------------------------
INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(5,     '2/15/2016', '$9.99', '1')
-----------------------------------------------------------------
INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(5,     '3/15/2016', '$9.99', '1')
-----------------------------------------------------------------------
INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(13,     '3/21/2016', '$99.00', '1')
----------------------------------------------------------------------------
INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(5,     '4/15/2016', '$9.99', '1')
----------------------------------------------------------------------------
INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(13,     '4/21/2016', '$99.00', '1')

--------------------------------------------------------------------------------
INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(12,     '4/25/2016', '$27.00', '1')

---------------------------------------------------------------------------
INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(5,     '5/15/2016', '$9.99', '1')

------------------------------------------------------------------------------
INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(5,     '6/15/2016', '$9.99', '1')

-------------------------------------------------------------------------------------
INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(5,     '7/15/2016', '$9.99', '1')

--------------------------------------------------------------------------------------
INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(5,     '1/15/2016', '$9.99', '1')

--------------------------------------------------------------------------------------
INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(12,     '7/25/2016', '$27.00', '1')
-----------------------------------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(5,     '8/15/2016', '$9.99', '1')

---------------------------------------------------------------------------------------
INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(8,     '9/9/2016', '$99.00', '1')

-----------------------------------------------------------------------------------------------
INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(5,     '9/15/2016', '$9.99', '1')

------------------------------------------------------------------------------------------------
INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(5,     '10/15/2016', '$9.99', '1')

------------------------------------------------------------------------------------------
INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(12,     '10/25/2016', '$27.00', '1')

-----------------------------------------------------------------------------------------
INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(5,     '11/15/2016', '$9.99', '1')

-------------------------------------------------------------------------------------
INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(9,     '11/21/2016', '$99.00', '1')
--------------------------------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(5,     '12/15/2016', '$9.99', '1')

-------------------------------------------------------------------------------------------



INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(5,     '1/15/2017', '$9.99', '1')
-------------------------------------------------------------------------------------


INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(12,     '1/25/2017', '$9.99', '1')

---------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(14,     '1/27/2017', '$9.99', '1')
---------------------------------------------------------------


INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(5,     '2/15/2017', '$9.99', '1')

------------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(3,     '2/26/2017', '$27.00', '1')

------------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(14,     '2/27/2017', '$9.99', '1')

---------------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(6,     '3/13/2017', '$99.00', '1')
----------------------------------------------------------------------


INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(5,     '3/15/2017', '$9.99', '1')
------------------------------------------------------------------------


INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(11,     '3/19/2017', '$9.99', '1')

---------------------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(14,     '3/27/2017', '$9.99', '1')
-------------------------------------------------------------------------


INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(1,     '4/7/2017', '$9.99', '1')

-------------------------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(5,     '4/15/2017', '$9.99', '1')

--------------------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(11,     '4/19/2017', '$9.99', '1')

------------------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(12,     '4/25/2017', '$27.00', '1')
----------------------------------------------------------------------


INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(14,     '4/27/2017', '$9.99', '1')

-----------------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(1,     '5/7/2017', '$9.99', '1')


---------------------------------------------------------------------
INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(5,     '5/15/2017', '$9.99', '1')

----------------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(11,     '5/19/2017', '$9.99', '1')
-------------------------------------------------------------------------


INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(3,     '5/26/2017', '$27.00', '1')

---------------------------------------------------------------------------



INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(14,     '5/27/2017', '$9.99', '1')
-------------------------------------------------------------------------------


INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(1,     '6/7/2017', '$9.99', '0')

---------------------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(1,     '6/8/2017', '$9.99', '1')

--------------------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(5,     '6/15/2017', '$9.99', '1')

------------------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(11,     '6/19/2017', '$9.99', '1')
----------------------------------------------------------------


INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(14,     '6/27/2017', '$9.99', '1')

------------------------------------------------------------------------


INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(1,     '7/7/2017', '$9.99', '1')

--------------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(5,     '7/15/2017', '$9.99', '1')

----------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(11,     '7/19/2017', '$9.99', '0')

----------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(11,     '7/20/2017', '$9.99', '1')

----------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(12,     '7/25/2017', '$27.00', '1')

-------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(14,     '7/27/2017', '$9.99', '1')

------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(1,     '8/7/2017', '$9.99', '1')

---------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(7,     '8/9/2017', '$9.99', '1')

----------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(5,     '8/15/2017', '$9.99', '1')

-----------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(11,     '8/19/2017', '$9.99', '1')

------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(3,     '8/26/2017', '$27.00', '1')

-----------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(14,     '8/27/2017', '$9.99', '1')

------------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(7,     '9/9/2017', '$9.99', '1')

----------------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(8,     '9/9/2017', '$99.00', '1')

------------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(5,     '9/15/2017', '$9.99', '1')
------------------------------------------------------------------


INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(11,     '9/19/2017', '$9.99', '1')
---------------------------------------------------------------------


INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(14,     '9/27/2017', '$9.99', '1')

-------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(15,     '10/6/2017', '$9.99', '0')


-----------------------------------------------------------------
INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(1,     '10/7/2017', '$9.99', '1')

---------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(7,     '10/9/2017', '$9.99', '1')

--------------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(5  ,   '10/15/2017', '$9.99', '1')
-------------------------------------------------------------------


INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(11,     '10/19/2017', '$9.99', '1')

-----------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(12,     '10/25/2017', '$27.00', '1')

----------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(14,     '10/27/2017', '$9.99', '1')

-----------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(4,     '11/5/2017', '$27.00', '1')

------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(1,     '11/7/2017', '$9.99', '1')

--------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(7,     '11/9/2017', '$9.99', '1')

-------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(5,     '11/15/2017', '$9.99', '1')

-------------------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(11,     '11/19/2017', '$9.99', '1')

-----------------------------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(3,     '11/26/2017', '$27.00', '1')

----------------------------------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(3,     '11/27/2017', '$27.00', '1')

-------------------------------------------------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(14,     '11/27/2017', '$9.99', '1')

--------------------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(2,     '11/29/2017', '$9.99', '1')

------------------------------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(1,     '12/7/2017', '$9.99', '1')

-------------------------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(7,     '12/9/2017', '$9.99', '1')

---------------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(5,     '12/15/2017', '$9.99', '1')

---------------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(11,     '12/19/2017', '$9.99', '1')

--------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(10,     '12/22/2017', '$9.99', '1')

--------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(14  ,   '12/27/2017', '$9.99', '1')

-------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(2,     '12/29/2017', '$9.99', '1')

--------------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(1,     '1/7/2018', '$9.99', '1')

------------------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(7,     '1/9/2018', '$9.99', '1')

------------------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(5,     '1/15/2018', '$9.99', '1')

------------------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(11,     '1/19/2018', '$9.99', '1')

----------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(10,     '1/22/2018', '$9.99', '1')



INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(12,     '1/25/2018', '$27.00', '1')

--------------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(14,     '1/27/2018', '$9.99', '1')

















--insert into payment info



INSERT INTO paymentinfo
			(transID, memberID, cardtype, cardnumber, expdate)
VALUES      ('1'  , '1',      'Discover', '337941553240515', '9/1/2019')
----------------------------------------------------------------------
INSERT INTO paymentinfo
			(transID, memberID, cardtype, cardnumber, expdate)
VALUES		('2',   '2',     'americanexpress', '4041372553875903', '1/1/2020')
----------------------------------------------------------------------------

INSERT INTO paymentinfo
			(transID, memberID, cardtype, cardnumber, expdate)
VALUES		('3',   '3',     'Visa', '4041593962566', '3/1/2019')

----------------------------------------------------------------------------
INSERT INTO paymentinfo
			(transID, memberID, cardtype, cardnumber, expdate)
VALUES		('4',   '4',     'americanexpress', '3571066026049076', '4/1/2019')

--------------------------------------------------------------------------------
INSERT INTO paymentinfo
			(transID, memberID, cardtype, cardnumber, expdate)

VALUES		('5',   '5',     'Giftcard', '30423652701879', '6/1/2018')

------------------------------------------------------------------------------
INSERT INTO paymentinfo
			(transID, memberID, cardtype, cardnumber, expdate)
VALUES		('6',   '6',     'Visa', '3532950215393858', '5/1/2018')
----------------------------------------------------------------------------

INSERT INTO paymentinfo
			(transID, memberID, cardtype, cardnumber, expdate)
VALUES		('7',   '7',     'americanexpress', '337941553240515', '2/1/2019')
-------------------------------------------------------------------------------

INSERT INTO paymentinfo
			(transID, memberID, cardtype, cardnumber, expdate)
VALUES		('8',   '8',     'American Express', '3569709859937370', '3/1/2019')

-----------------------------------------------------------------------------------
INSERT INTO paymentinfo
			(transID, memberID, cardtype, cardnumber, expdate)
VALUES		('9',   '9',     'americanexpress', '3529188090740670', '5/1/2019')
---------------------------------------------------------------------------------

INSERT INTO paymentinfo
			(transID, memberID, cardtype, cardnumber, expdate)
VALUES		('10',   '10',     'Discover', '3530142576111598', '11/1/2019')
------------------------------------------------------------------------------------

INSERT INTO paymentinfo
			(transID, memberID, cardtype, cardnumber, expdate)
VALUES		('11',   '11',     'Mastercard', '5108756299877313', '7/1/2018')
---------------------------------------------------------------------------------

INSERT INTO paymentinfo
			(transID, memberID, cardtype, cardnumber, expdate) 
VALUES		('12',   '12',     'americanexpress', '3543168150106220', '6/1/2018')

--------------------------------------------------------------------------
INSERT INTO paymentinfo
			(transID, memberID, cardtype, cardnumber, expdate)
VALUES		('13',   '13',     'Mastercard', '3559166521684728', '10/1/2019')

-------------------------------------------------------------------------
INSERT INTO paymentinfo
			(transID, memberID, cardtype, cardnumber, expdate)
VALUES		('14',   '14',     'Mastercard', '30414677064054', '6/1/2018')

-------------------------------------------------------------------------
INSERT INTO paymentinfo
			(transID, memberID, cardtype, cardnumber, expdate)
VALUES		('15',   '15',     'jcb', '35428280939385763', '3/1/2020')
GO





--------complete contact view
CREATE VIEW viewcontactlist
AS
	SELECT m.firstname, m.lastname, a.addressline1, a.addressline2, a.city, a.[state], a.zipcode,
		   ci.email, ci.phonenumber
	FROM   Members m
	JOIN   Address a
	ON     m.memberID = a.memberID
	JOIN   Contactinfo ci
	ON     a.memberID = ci.memberID
GO

----If someone would frequently need to look up or see everyones complete address and contact
----info





--------------view on all emails
CREATE VIEW viewemail
AS
	SELECT m.firstname, m.lastname, ci.email
	FROM   members m
	JOIN   Contactinfo ci
	ON     ci.memberID = m.memberID
GO	





-------------view on current month birthdays
CREATE VIEW viewbirthdate
AS
	SELECT m.firstname, m.lastname, m.birthdate
	FROM   Members m
	WHERE  m.birthdate LIKE '%Feb%'
GO





----------expired credit cards view 

CREATE VIEW viewexpcreditcards
AS
	SELECT expdate, memberID FROM paymentinfo 
	WHERE  expdate > getdate()
GO







------ new member sign up over a time frame
 CREATE PROCEDURE proc_newmember
 (
	 @startdate  DATETIME,
	 @enddate    DATETIME 
)
AS

	SELECT COUNT(m.memberID) AS 'Members'
	FROM   Members m
	JOIN   Subscriptions s 
	ON     m.subscriptionID = s.subscriptionID
	WHERE  s.joineddate BETWEEN @startdate AND @enddate
GO
--	EXEC proc_newmember '4/25/16', '3/13/17'






------attendance over a time period
	CREATE PROCEDURE proc_attendance
	(
		@eventstartdate DATETIME,
		@eventenddate   DATETIME
	)
	AS

		SELECT m.memberID, em.attendance
		FROM   Members m
		JOIN   Eventmembers em
		ON     em.memberID = m.memberID
		WHERE  em.attendance BETWEEN @eventstartdate AND @eventenddate


		--EXEC proc_attendance '2/22/2017', '3/5/2017'


