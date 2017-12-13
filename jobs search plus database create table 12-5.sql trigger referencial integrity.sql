use master
if (select count(*) from sys.databases where name = 'jobsearchplus')> 0 
begin 
	drop database jobsearchplus
end


create database jobsearchplus
go

use jobsearchplus


--create table statements

Create table BusinessTypes 
(
	BusinessType  varchar(40)  not null,
	primary key (BusinessType)

)



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

) 

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

)



create table sources
(
	SourceID        int        not null identity (1,1),
	sourcename    varchar(40)  not null,
	sourcetype    varchar(40)  null,
	sourcelink    varchar(50)  null,
	[Description]  varchar(30) null,
	PRIMARY KEY (SourceID)
)


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
	
	

)



Create table Activities 
(
	ActivityID	 int        not null Identity (1,1),
	LeadID       int        not null,
	ActivityDate datetime  not null,
	ActivityType char(50)   not null,
	ActivityDetails varchar(255) null,
	Complete      bit          null,
	Primary key  (ActivityID),
	
)

--activity trigger
go
create trigger trg_activities 
on             activities
after		   insert, update
as
begin
	if exists (select* from inserted i where i.leadID not in (select LeadID from Leads))
begin
	raiserror (' leadID is not found, please find a valid source', 16,1)
	rollback transaction
end
end 
go

--tripple trigger
create trigger trg_source_company_contact
on			   leads
after          insert, update
as
begin
	if exists (select* from inserted i where i.SourceID not in (select SourceID from sources))
begin
	raiserror ('SourceID is not found, please find a valid source', 16, 1)
	rollback transaction
end 

	if exists (select* from inserted i where i.contactID not in (select contactID from contacts))
begin
	raiserror ('ContactID is not found, please find a valid source', 16, 1)
	rollback transaction
end 

	if exists (select* from inserted i where i.CompanyID not in (select CompanyID from Companies))
begin
	raiserror ('CompanyID is not found', 16, 1)
	rollback transaction
end
end
go   

--companyID trigger
create trigger trg_company
on			   contacts
after          insert, update
as
begin
     if exists (select* from inserted i where i.CompanyID not in (select CompanyID from Companies))
begin
	raiserror ('CompanyID is not found, please enter a valid source', 16, 1)
	rollback transaction
end
end
go


--businesstypes trigger
create trigger trg_businesstype
on			   companies
after          insert, update
as
begin
	if exists (select* from inserted i where i.BusinessType not in (select BusinessType from BusinessTypes))
begin
	raiserror (' Businesstype not valid, please select a valid source', 16, 1)
	rollback transaction
end
end
go



--delete triggers
 create trigger trg_activitiesdelete 
 on				leads
 after			delete
 as
 begin
		if exists (select* from deleted i where i.LeadID in (select distinct LeadID from Activities))
begin
	raiserror (' Record exists in the referenced table, delete did not happen' ,16, 1)
	rollback transaction 
end
end
go


--delete sourceID trigger
create trigger trg_sourceID_contact_company_Delete
on			   leads
after		   delete
as
begin
	if exists (select* from deleted i where i.sourceID in (select distinct SourceID from Leads))
begin
	raiserror ('Record exists in the referenced table, delete did not happen', 16, 1)
	rollback transaction 
end
	if exists (select* from deleted i where i.ContactID in (select distinct ContactID from leads))
begin
	raiserror ('Record exists in the referenced table, delete did not happen', 16, 1)
	rollback transaction
end
	if exists (select* from deleted i where i.CompanyID in (select distinct CompanyID from leads))
begin
	raiserror ('Record exists in the referenced table , delete did not happen', 16, 1)
end
end
go





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


--insert into companies
Insert into companies
(companyname)
values ('Drewslair.com'), ('AndrewComeau.com'), ('Mircrosoft.com'), ('vinergys Inc'), ('Liberty Software')

insert into companies (companyname, Address1, Address2, City, [State], Zip, Phone, Fax, Email, Website, [Description],  BusinessType)
values      ('Exter Employment', '123 Test lane', null, 'Orlando', 'FL', '33321' , '904-555-5555', '904-555-5555', 'drone@vingergys.com',
			'http://www.vingergys.com',  'test', 'consulting')




--insert into contacts
insert into Contacts
(CompanyID, Courtesytitle, ContactFirstName, ContactLastName, Modifieddate)
values    (4, 'Mr', 'John', 'Smith', getdate()) 



--insert into sources
insert into sources
(sourcename, sourcetype, sourcelink, [Description])
values  ('Monster.com', 'online', 'http://www.monster.com', 'test')
go



--insert into leads
insert into Leads
(Jobtitle, [Description], EmploymentType, [Location])
 values  ('programmer', 'test', 'Full-Time', 'Ocala'), 
		 ('software developer', 'test', 'part-Time', 'Gainesville'),
		 ('Developer', 'Test', 'Seasonal', 'Redmond')

		






--insert into Activites
insert into activities 
( leadID, ActivityDate, ActivityType)
values ( 2, getdate(), 'filled out application')




