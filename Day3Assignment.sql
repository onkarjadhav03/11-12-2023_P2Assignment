create database Exercise
on primary (name='Products_Db', Filename='D:\mphasis\Phase2\Exercise\Products_Db.mdf')
log on (name='Products_Db_log',filename='D:\mphasis\Phase2\Exercise\Products_Db_log.ldf')
COLLATE SQL_Latin1_General_CP1_CI_AS

use Exercise

create table Products(
Pid int primary key,
Pq int not null,
Pprice float not null,
DiscountPrtcentage float not null,
ManufacturingDate date)

insert into Products values(1,1,5000,10,'10/02/2020')
insert into Products values(2,5,2000,10,'01/12/2019')
insert into Products values(3,3,10000,10,'11/09/2022')
insert into Products values(4,9,8000,10,'3/12/2023')
insert into Products values(5,3,20000,15,'2/12/2021')
insert into Products values(6,3,2000,5,'02/12/2021')

select * from Products



create function fndiscount(@Pprice float,@DiscountPrtcentage float)
returns float
as
begin
return(@Pprice-(@Pprice*(@DiscountPrtcentage/100)))
end

select Pid,Pprice,dbo.fndiscount(Pprice,DiscountPercentage) as 'Discount price' from Products


