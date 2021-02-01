use WFA3DotNet

create table Employee(
	EmpId int not null Primary key identity(100,1),
	EmpName varchar(20),
	Salary float
)
--alter table
alter table Employee
add city varchar(20)
insert into Employee values('Jahnavi',35436.56)
insert into Employee(empname,Salary) values('Aman',85695)
insert into Employee values('lavanya',35436.56)
insert into Employee values('Dhirendra',35436.56)

update Employee set Salary=58444.25 where empid=101

update Employee set Salary=58444.25,EmpName='Aman sayam' where empid=101

update Employee set city ='Guntur' where EmpId=100
alter table Employee add Email varchar(20)
--Drop clo Email
alter table Employee drop column Email

alter table employee 
alter column city varchar(50)
--truncate will remove data
--(truncate table employee
--delete table
--(drop table  Employee
select * from Employee

create table DeptTable(
DptId int not null primary key,
DptName varchar(20) not null,
)

create table EmployeeTab(
	EmpId int not null Primary key identity(1,1),
	EmpName varchar(20),
	Salary float,
	DeptNo int foreign key references DeptTable(dptid)
)

insert into DeptTable values(10,'HR')
insert into DeptTable values(11,'Admin')
insert into DeptTable values(12,'Sales')
insert into DeptTable values(13,'Marketing')

insert into EmployeeTab values('Aaa',35436.56,10)
insert into EmployeeTab values('Bbb',45436.56,10)
insert into EmployeeTab values('Ccc',55436.56,10)
insert into EmployeeTab values('Ddd',65436.56,10)
insert into EmployeeTab values('Ddd',75436.56,10)
insert into EmployeeTab values('Eee',85436.56,10)
insert into EmployeeTab values('Fff',95436.56,10)
insert into EmployeeTab values('Ggg',15436.56,10)

update EmployeeTab set DeptNo=11 where EmpId=2
update EmployeeTab set DeptNo=11 where EmpId=4
update EmployeeTab set DeptNo=12 where EmpId=6
update EmployeeTab set DeptNo=13 where EmpId=8
select * from EmployeeTab
select * from DeptTable

select Avg(salary) from EmployeeTab

select  MIN(salary) as MinSalary from EmployeeTab 
group by EmpName

select round(23333.333,2) as RoundValue

--Sql server Groupby statements

-- find the count of employees in a particular dept
select count(EmpId),deptno
from EmployeeTab
group by DeptNo

--group by with join
select d1.DptName,
count(EmpId) as TotEmps
from EmployeeTab e1
join DeptTable d1 on e1.DeptNo=d1.DptId
group by d1.DptName
having count(e1.Empid)>2

--group by and having
select DeptNo,sum(Salary)
from EmployeeTab
group by DeptNo
having sum(salary) > 50000
order by count(salary) desc 



--stored procedures
create proc sp_InsertEmp
@ename varchar(20),
@sal float,
@dno int
as
begin
insert into EmployeeTab(EmpName,Salary,DeptNo) 
values(@ename,@sal,@dno)
end

execute sp_InsertEmp 'Hhh',22222,10
select * from EmployeeTab where DeptNo=10

-- sp eg 2 , with no parameters
alter proc sp_WithNoParameters
as 
select t1.Empid,t1.empname,t1.salary,t2.*
from EmployeeTab t1
join DeptTable t2
on t1.DeptNo=t2.DptId

exec sp_WithNoParameters
--------------------------------------
--eg3 stored procedure with output parameters

create proc sp_WithOutputParameter
@empcnt int output
as
begin
select @empcnt=count(empid)
from EmployeeTab
end


alter proc sp_WithOutputParameter
@empcnt int output
as
begin
select @empcnt=count(empid)
from EmployeeTab
if(@empcnt is null)
print '@empcnt is null'
else
print 'The of Employees are not null '
end

--exec sp with output parameter
declare @result int 
exec sp_WithOutputParameter @result output
print @result

--using of built-in sp
sp_help EmployeeTab


--DMl Trigger Example
create table PastEmpTable(
empid int,
ename varchar(20),
esal float,
dol datetime default getdate()
)

alter trigger trgAfterDel on EmployeeTab
for delete
as
declare @empid int, 
@ename varchar(20),
@esal float,
@dol datetime
select @empid=deleted.EmpId,@ename=deleted.EmpName,@esal=deleted.Salary,@dol=getdate() from deleted
insert into PastEmpTable(empid,ename,esal,dol) values(@empid,@ename,@esal,@dol)
print 'After delete trigger fired on EmpTable'

-- updtae -trigger
alter trigger trAfterUpdate on EmployeeTab
after update
as 
declare @empid int, 
@ename varchar(20),
@esal float,
@dol datetime
select @empid=deleted.EmpId,@ename=deleted.EmpName,@esal=deleted.Salary,@dol=getdate() from deleted
insert into PastEmpTable(empid,ename,esal,dol) values(@empid,@ename,@esal,@dol)
update EmployeeTab set EmpName=@ename,salary=@esal where EmpId=@empid
print 'After update trigger fired on EmpTable'

update EmployeeTab set EmpName='Iii',salary=33333 where EmpId=10
select * from EmployeeTab
delete from EmployeeTab where EmpId=4;
select * from PastEmpTable