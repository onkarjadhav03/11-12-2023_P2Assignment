create database Day3Db
use Day3Db

create table Products(
Pid int primary key,
Pname nvarchar(50) not null,
Pprice float not null,
Pcat nvarchar(50))

insert into Products values(1,'i-phone',120000,'Mobile')
insert into Products values(2,'i-phone',150000,'Laptop')
insert into Products values(3,'Samsung',100000,'Mobile')
insert into Products values(4,'Redmi',50000,'Mobile')
insert into Products values(5,'Dell',540000,'Laptop')
insert into Products values(6,'i-phone',60000,'Smartwatch')
insert into Products values(7,'One plus',70000,'Mobile')

select * from Products

select sum(Pprice) as 'total' from Products
select avg(Pprice) as 'average' from Products
-----------------
select sum(Pprice) as 'sub total',Pcat as 'Product Category' from Products group by Pcat
select min(Pprice) as 'minimum total',Pcat as 'Product Category' from Products group by Pcat
select max(Pprice) as 'maximum total',Pcat as 'Product Category' from Products group by Pcat
select avg(Pprice)  'average total',Pcat  'Product Category' from Products group by Pcat

select sum(Pprice) as 'sub total',Pcat as 'Product Category' from Products group by Pcat having Pcat='mobile'

select LOWER('India')
select UPPER('india')
select left('India',2)
select left('India',3)
select upper(right('india',2))
select upper(SUBSTRING('India',3,5)) as 'From India'

select lower(PCat) as 'Product Category' from Products
select upper(PCat) as 'Product Category' from Products
select upper(left(PCat,3)) as 'Product Category' from Products
select upper(Pname)+' '+upper(PCat) 'Product Datails' from Products
select upper(Pname)+' '+upper(PCat) 'Product Datails',left(Pname,1)+'.'+left(PCat,1)+'.' as 'initial' from Products
--date function
select GETDATE()
select DATEPART(day,getdate()) 'Today'
select DATEPART(month,getdate()) 'Current Month'
select DATEPART(year,getdate()) 'Current Year'

select DATEADD(day,3,getdate()) 'Today + 3Daye'
select DATEADD(month,3,getdate()) 'Current Month + 3Months'
select DATEADD(year,3,getdate()) 'Current Year + 3Years'

select DATEDIFF(year,'12/12/2013',getdate()) as 'Year 2013 to Today'


create table Employee(
Id nvarchar(5) primary key check(Id like '[a-z][0-9][0-9][0-9]'),
Name nvarchar(20) not null,
Designation nvarchar(20) not null,
Salary float,
DOJ date)

	insert into Employee (ID,Name,Designation,Salary,DOJ) values('E001','Sam','Manager',98000.0,'03/12/2020')
insert into Employee (ID,Name,Designation,Salary,DOJ) values('E002','Samar','Developer',88000.0,'03/02/2020')
insert into Employee (ID,Name,Designation,Salary,DOJ) values('E003','Rishi','Tester',70000.0,'05/06/2021')
insert into Employee (ID,Name,Designation,Salary,DOJ) values('E004','Manish','Manager',60000.0,'02/05/2020')
insert into Employee (ID,Name,Designation,Salary,DOJ) values('E005','Pavan','Developer',50000.0,'03/12/2019')
insert into Employee (ID,Name,Designation,Salary,DOJ) values('E006','Kunal','HR',75000.0,'03/03/2022')

select * from Employee

select DATEPART(DAY,DOJ) from Employee

select DATEPART(DAYOFYEAR,DOJ) from Employee

select Id,Name,Designation,Salary,DOJ,datediff(year,DOJ,getdate()) 'working Year in org'  from Employee

create function fnfullname(
@fn nvarchar(50),@In nvarchar(50)
)
returns nvarchar(101) As
begin 
return (select @fn+'  '+@In);
end

select dbo.fnfullname('sam','HR')as 'full name'
select dbo.FnFullName(Name,Designation) as 'Full Designation' from Employee

create schema OurSchema
create function OurSchema.Bonus
(@salary float)
returns float
as 
begin
return(@salary*0.15)
end

select OurSchema.Bonus(1200) as 'Bonus'
select Id,Name,Designation,Salary,OurSchema.Bonus(salary) as 'Bonus' from Employee

--table valued function
create function fnGetEmps()
returns Table
As
return(select * from Employee)

select * from fnGetEmps()
select Id,Name from fnGetEmps()


--stored procedure
create proc usp_sProducts
as
select * from Products

exec usp_sProducts

--with single parameter
create proc usp_ProdById
@id int
as 
select * from  Products	where Pid=@id

execute usp_ProdById 2

execute usp_ProdById 3

create proc usp_ipro
@id int,
@name nvarchar(50),
@price float,
@cat nvarchar(50)
as
 insert into Products(Pid,Pname,Pprice,Pcat) values(@id,@name,@price,@cat)
 if(@@ERROR=0)
 print 'record inserted'

 exec usp_ipro 8,'Nord',20000,'Mobile'

 select * from Products


 create proc usp_delPro
 @id int
 as
 delete from Products where PId=@id

 execute usp_delPro 56

  select * from Products

  create  proc usp_updatePro
  @id int,
  @name nvarchar(50),
  @price float
  as
  update Products set PName=@name,PPrice=@price where PId=@id

execute usp_updatePro 52,'Smart-watch',12000

select * from Products


use Day3Db

 execute usp_delPro 56
 
  select * from Products

  select count(PId) from Products where PCat='mobile'

  create proc usp_NoPro
  @cat nvarchar(20),
  @nop int output
  as
  select @nop=count(Pid) from Products where Pcat=@cat

  declare @proCount int
  execute usp_NoPro 'laptop', @proCount out
  print @proCount