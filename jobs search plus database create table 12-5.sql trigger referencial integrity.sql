use master
if (select count(*) from sys.databases where name = 'jobsearchplus')> 0 
begin 
	drop database jobsearchplus
end


create database jobsearchplus
go

use jobsearchplus

Create table BusinessTypes 
(
	BusinessType  varchar(40)  not null,
	primary key (BusinessType)

)

--insert into businesstypes
insert into BusinessTypes
(businesstype)
values
	  ('Accounting'),
	  ('advertising/Marketing'),
	  ('Agriculture'),
	  ('Architecture'),
	  ('Arts/Entertainment'),
	  ('Aviation'),
	  ('Beauty/Fitness'),
	  ('Business Services'),
	  ('Communications'),
	  ('Computer/Hardware'),
	  ('Computer/services'),
	  ('Computer/software'),
	  ('Computer/training'),
	  ('Construction'),
	  ('Consulting'),
	  ('Crafts/Hobbies'),
	  ('education'),
	  ('eletrcial'),
	  ('electronics'),
	  ('employment'),
	  ('engineering'),
	  ('environmental'),
	  ('fashion'),
	  ('financial'),
	  ('Food/bevarage'),
	  ('government'),
	  ('health/medicine'),
	  ('home and garden'),
	  ('immigration'),
	  ('import/export'),
	  ('industrial'),
	  ('industrial medicine'),
	  ('information services'),
	  ('insurance'),
	  ('internet'),
	  ('legal and law'),
	  ('logistics'),
	  ('manufacturing'),
	  ('mapping/surveying'),
	  ('marine/maritime'),
	  ('motor vehicle'),
	  ('multimedia'),
	  ('network marketing'),
	  ('news and weather'),
	  ('non-profit'),
	  ('petrochemical'),
	  ('pharmaceutical'),
	  ('printing/publishing'),
	  ('real estate'),
	  ('restaurants'),
	  ('resturant services'),
	  ('service clubs'),
	  ('service industry'),
	  ('shopping/retail'),
	  ('spiritual/religious'),
	  ('sports/recreation'),
	  ('storage/warehousing'),
	  ('technologies'),
	  ('transportation'),
	  ('travel'),
	  ('utilities'),
	  ('venture capital'),
	  ('wholesale')


create table Companies 
(
	CompanyID  Int  not null Identity (1,1),
	companyname varchar(40) null,
	Address1    varchar(30) null,
	Address2   varchar(40)  null,
	City       varchar(50)  null,
	[State]      varchar(30)  null,
	Zip         char  (10)  null,
	Phone		varchar(25) null,
	Fax			varchar(30) null,
	Email       varchar(80) null,
	Website     varchar(90) null,
	[Description] varchar(40) null,
	BusinessType varchar (40) null,
Primary key  (CompanyID),
	Constraint Fk_companies_BusinessTypes foreign key (BusinessType) references BusinessTypes (BusinessType)
	
) 

--insert into companies
Insert into companies
(companyname)
values ('Drewslair.com'), ('AndrewComeau.com'), ('Mircrosoft.com'), ('vinergys Inc'), ('Liberty Software')

insert into companies (companyname, Address1, Address2, City, [State], Zip, Phone, Fax, Email, Website, [Description],  BusinessType)
values      ('Exter Employment', '123 Test lane', null, 'Orlando', 'FL', '33321' , '904-555-5555', '904-555-5555', 'drone@vingergys.com',
			'http://www.vingergys.com',  'test', 'consulting')

go
create trigger trg_company
on			   Companies 
after		   Insert, update, delete
as
begin
	PRINT 'Dummy text'
end
go



create table Contacts 
(
	ContactID       int             not null Identity (1,1),
	CompanyID       int             not null,
	Courtesytitle   varchar(30)     null,
	ContactFirstName varchar(25)    null,
	ContactLastName varchar(25)     null,
	Title			varchar(30)     null,
	Phone			varchar(20)     null,
	Extension        bit            null,
	Fax				 char(20)       null,
	Email			 varchar(40)    null,
	Comments         varchar(30)    null,
	Modifieddate     datetime        null,
	Primary key   (ContactID),
constraint fk_Contacts_Companies foreign key (CompanyID) references companies (companyID)
)


create table sources
(
	SourceID int  not null   Identity (1,1),
	sourcename    varchar(40)  not null,
	sourcetype    varchar(40)  null,
	sourcelink    varchar(50)  null,
	[Description]  varchar(30) null,
	PRIMARY KEY (SourceID)
)




--insert into sources

insert into sources
(sourcename, sourcetype, sourcelink, [Description])
values  ('Monster.com', 'Online', 'http://www.monster.com', 'test')
go







Create table  Leads
(
	LeadID        int                not null identity (1,1),
	Recorddate    datetime        not null default getdate(),
	Jobtitle      varchar(30)     not null,
	[Description] varchar(40)     null,
	EmploymentType varchar(40)    null constraint EmploymentType check  (EmploymentType in ('Full-time', 'part-time', 'Seasonal')),
	[Location]       varchar(40)    null,
	Active         bit            null,
	CompanyID     int			  null,
	AgencyID       int            null,
	ContactID      int            null,
	DocAttachments bit		     null,
	SourceID       int           null,
	modifieddate  datetime       default getdate(), 
	Primary key (LeadID),
	Constraint  Fk_Leads_Companies foreign key (CompanyID) references Companies (CompanyID),
	constraint  Fk_leads_Contacts  foreign key  (ContactID) references contacts (ContactID),
	

)
go		

create trigger trg_sourceid
on  leads
after insert, update
as

IF EXISTS
(
	select*
	from inserted i 
	where sourceID is not null and not exists
(
	select*
	from sources s
	where s.sourceID = i.SourceID
)
	)

begin
	RAISERROR ( 'The sourceID does not exist, please enter a valid sourceID', 16, 1)
end
go

create trigger trg_leads
on				leads
after           Insert, Update
as
begin
	update Leads
	set modifieddate = getdate()
end
go


Create table Activities 
(
	ActivityID	 int        not null Identity (1,1),
	LeadID       int       not null,
	ActivityDate datetime  not null,
	ActivityType char(50)   not null,
	ActivityDetails varchar(255) null,
	Complete      bit          null,
	Primary key  (ActivityID),
	Constraint FK_Activities_Leads foreign key (LeadID) references leads (LeadID)
)

--contactID trigger
--go
--create trigger trg_contacts
--on leads
--after insert, update
--as
--	if exists
--	(
--		select*
--		from inserted i
--		where contactID is not null and not exists
--	(
--		select*
--		from  contacts c
--		where c.ContactID = i.ContactID
--	)
--		)
	
--begin
--	RAISERROR (' The contactID does not exist, please enter a valid contactID', 16, 1)
--end
go

create trigger trg_Contact
on			    Contacts
after			Insert, update, delete
as
begin
	update Contacts
	set    modifieddate = getdate()
end
go

CREATE TRIGGER trgContawct
ON leads
AFTER INSERT, UPDATE
AS
BEGIN
	IF EXISTS
	(
		SELECT ContactID
		FROM inserted
		WHERE ContactID NOT IN (SELECT ContactID FROM Contacts)
	)
	Begin
	RAISERROR('ERROR FOOL',16,1)
END;




--insert into contacts
--insert into Contacts
--(CompanyID, Courtesytitle, ContactFirstName, ContactLastName, Modifieddate)
--values    (4, 'Mr', 'John', 'Smith', getdate()) 



--sourceID trigger




-- insert into leads
--insert into Leads
--(Jobtitle, [Description], EmploymentType, [Location])
-- values  ('programmer', 'test', 'Full-Time', 'Ocala'), 
--		 ('software developer', 'test', 'part-Time', 'Gainesville'),
--		 ('Developer', 'Test', 'Seasonal', 'Redmond')

		






----insert into Activites
--insert into activities 
--( leadID, ActivityDate, ActivityType)
--values (2,getdate(), 'filled out application')

