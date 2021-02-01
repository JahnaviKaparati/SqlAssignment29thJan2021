use WFA3DotNet

create table productsTable(
id int not null primary key identity(1,1),
pname varchar(20),
quantity int,
price float
)

insert into productsTable values('Aaa',2,100.00)
insert into productsTable values('Bbb',3,200.00)
insert into productsTable values('Ccc',1,450.00)
insert into productsTable values('Ddd',4,500.00)
insert into productsTable values('Eee',1,150.00)

--Aggregate Functions
--------------------------------------
--avg
select avg(price) from productsTable
--count
select count(*) from productsTable
--max
select max(price)  from productsTable
--min
select min(quantity) from productsTable
--count
select sum(price) from productsTable

--String functions
---------------------
--Ascii : Return the ASCII value of the first character
SELECT ASCII(pName) FROM productsTable
--char : Return the character based on the number code 65
SELECT CHAR(65) AS CodeToCharacter
--charindex : Search for "t" in string "Customer", and return position
SELECT CHARINDEX('t','Customer') 
--concat : add two strings together
SELECT CONCAT('jahnavi', 'kaparati')
--datalength : returns the length of an expression
select DATALENGTH(pname) from productsTable
--left
select left('abcdefg',4)
--len
select LEN(pname) from productsTable
--lower
select lower('JAHNAVI')
--ltrim
select ltrim('       Jahnavi')
--upper
select upper('Jahnavi')
--rtrim
select rtrim('Kaparati      ')
--right
select RIGHT('abcdefgh',4)


--DATE FUNCTIONS
--------------------------
--CURRENT_TIMESTAMP
SELECT CURRENT_TIMESTAMP
--dateadd
SELECT DATEADD(year, 1, '2021/01/30')
SELECT DATEADD(month, 1, '2021/01/30')
SELECT DATEADD(day, 1, '2021/01/31')
--datediff
SELECT DATEdiff(year, '2017/01/30', '2021/01/30')
--datename : returns a specific part of s date
select dateName(year,'2020/12/23')
select dateName(month,'2020/12/23')
select dateName(day,'2020/12/23')
--getdate
select GETDATE()
--isdate
SELECT ISDATE('2022-15-25')
