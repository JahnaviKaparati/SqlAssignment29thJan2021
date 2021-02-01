use WFA3DotNet
create table TblCustomer(
	CustomerID varchar(6) not null primary key,
	cName varchar(30),
	dob date,
	city varchar(30)
)

create proc sp_InsertTabCustomer
@cid varchar(6),
@cname varchar(30),
@dob date,
@city varchar(30)
as
begin
insert into TblCustomer(CustomerID,cName,dob,city) 
values(@cid,@cname,@dob,@city)
end

execute sp_InsertTabCustomer '123456', 'David Letterman', '04-Apr-1949', 'Hartford'
execute sp_InsertTabCustomer '123457', 'Barry Sanders', '12-Dec-1967','Detroit'
execute sp_InsertTabCustomer '123458', 'Jean-Luc Picard', '9-Sep-1940', 'San Francisco'
execute sp_InsertTabCustomer '123459', 'Jerry Seinfeld', '23-Nov-1965','New York City'
execute sp_InsertTabCustomer '123460', 'Fox Mulder', '05-Nov-1962', 'Langley'
execute sp_InsertTabCustomer '123461', 'Bruce Springsteen', '29-Dec-1960','Camden'
execute sp_InsertTabCustomer '123462', 'Barry Sanders', '05-Aug-1974','Martha''s Vineyard'
execute sp_InsertTabCustomer '123463', 'Benjamin Sisko', '23-Nov-1955','San Francisco'
execute sp_InsertTabCustomer '123464', 'Barry Sanders', '19-Mar-1966','Langley'
execute sp_InsertTabCustomer '123465', 'Martha Vineyard', '19-Mar-1963','Marthas Vineyard'

create table TblAccount(
CustomerID varchar(6) not null,
AccountNumber varchar(10) not null primary key,
AccountTypeCode int,
DateOpened datetime default getdate(),
balance float
)
insert into tblAccount values ('123456', '123456-1', 1, '04-Apr-1993', 2200.33); 
insert into tblAccount values ('123456', '123456-2', 2, '04-Apr-1993', 12200.99); 
insert into tblAccount values ('123457', '123457-1', 3, '01-JAN-1998', 50000.00); 
insert into tblAccount values ('123458', '123458-1', 1, '19-FEB-1991', 9203.56); 
insert into tblAccount values ('123459', '123459-1', 1, '09-SEP-1990', 9999.99); 
insert into tblAccount values ('123459', '123459-2', 1, '12-MAR-1992', 5300.33); 
insert into tblAccount values ('123459', '123459-3', 2, '12-MAR-1992', 17900.42); 
insert into tblAccount values ('123459', '123459-4', 3, '09-SEP-1998', 500000.00); 
insert into tblAccount values ('123460', '123460-1', 1, '12-OCT-1997', 510.12); 
insert into tblAccount values ('123460', '123460-2', 2, '12-OCT-1997', 3412.33); 
insert into tblAccount values ('123461', '123461-1', 1, '09-MAY-1978', 1000.33); 
insert into tblAccount values ('123461', '123461-2', 2, '09-MAY-1978', 32890.33); 
insert into tblAccount values ('123461', '123461-3', 3, '13-JUN-1981', 51340.67); 
insert into tblAccount values ('123462', '123462-1', 1, '23-JUL-1981', 340.67); 
insert into tblAccount values ('123462', '123462-2', 2, '23-JUL-1981', 5340.67); 
insert into tblAccount values ('123463', '123463-1', 1, '1-MAY-1998', 513.90); 
insert into tblAccount values ('123463', '123463-2', 2, '1-MAY-1998', 1538.90); 
insert into tblAccount values ('123464', '123464-1', 1, '19-AUG-1994', 1533.47); 
insert into tblAccount values ('123464', '123464-2', 2, '19-AUG-1994', 8456.47); 

create table TblAccountType(
TypeCode int not null primary key,
TypeDesc varchar(20)
)
insert into tblAccountType values (1, 'Checking'); 
insert into tblAccountType values (2, 'Saving'); 
insert into tblAccountType values (3, 'Money Market'); 
insert into tblAccountType values (4, 'Super Checking');

--1)Print customer id and balance of customers who have at least $5000 in any of their accounts. 
select c1.customerid,a1.balance
from TblCustomer c1 join TblAccount a1
on a1.balance>5000

--2)Print names of customers whose names begin with a ‘B’.
select cname 
from TblCustomer
where cname LIKE 'B%'

--3)Print all the cities where the customers of this bank live.
select city from TblCustomer

--4)Use IN [and NOT IN] clauses to list customers who live in [and don’t live in] San Francisco or Hartford. 
select * from TblCustomer
where city In ('San Francisco','Hartford')

select * from TblCustomer
where city not In ('San Francisco','Hartford')
--5)Show name and city of customers whose names contain the letter 'r' and who live in Langley.
select c1.cname, c1.city
from TblCustomer c1
where c1.cname like '%r%' and city='Langley'

--6)How many account types does the bank provide?
select count(TypeCode) as numberOftypes from tblAccountType

--7)Show a list of accounts and their balance for account numbers that end in '-1' 
select AccountNumber,balance from TblAccount
where AccountNumber like '%-1'

--8)Show a list of accounts and their balance for accounts opened on or after July 1, 1990.
select AccountNumber,balance from TblAccount
where DateOpened>'1-july-1990'

--9)If all the customers decided to withdraw their money, how much cash would the bank need? 
select sum(balance) from TblAccount

Declare @bal float=(select sum(balance) from TblAccount)
print 'Amount needed'
print @bal

--10)List account number(s) and balance in accounts held by ‘David Letterman’. 
select t2.accountnumber,t2.balance
from TblCustomer t1 join TblAccount t2
on t1.CustomerID=t2.customerid and t1.cname='David Letterman'
--11)list the name of the customer who has the largest balance (in any account).  
select t1.cname,max(t2.balance) from TblCustomer t1 join TblAccount t2
on t1.CustomerID=t2.customerid 
group by cname

--12)List customers who have a ‘Money Market’ account. 
select t1.cname from TblCustomer t1 join TblAccount t2
on t1.CustomerID=t2.CustomerID and t2.AccountTypeCode=(
select typeCode from tblAccountType t3 where t3.TypeDesc='Money market')

--13)Produce a listing that shows the city and the number of people who live in that city. 
select city,count(City) as numOfPeople from TblCustomer group by city

--14)Produce a listing showing customer name, the type of account they hold and the balance in that account.   (Make use of Joins) 
select t1.cname, t2.AccountTypecode, t2.balance
from TblCustomer t1 join TblAccount t2
on t1.CustomerID=t2.CustomerID

--15)Produce a listing that shows the customer name and the number of accounts they hold.                                     (Make use of Joins) 
select t1.cname ,count(t2.Accountnumber)
from TblCustomer t1 join TblAccount t2
on t1.CustomerID=t2.CustomerID
group by t1.Cname

--select *
--from TblCustomer t1 join TblAccount t2
--on t1.CustomerID=t2.CustomerID

--16)Produce a listing that shows an account type and the average balance in accounts of that type.               (Make use of Joins) 
select t3.TypeDesc,avg(t2.balance) as average
from tblaccount t2 join tblAccounttype t3
on t2.AccountTypeCode=t3.TypeCode
group by t3.TypeDesc

 

select * from TblAccountType
select * from TblAccount
select * from TblCustomer

