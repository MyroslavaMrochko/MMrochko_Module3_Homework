--- Create tables for calculations---

create table Suppliers (supplierid int, name varchar(30), rating integer, city varchar(30));
INSERT INTO Suppliers (supplierid, name, rating, city) VALUES 
(1,'Smith', 20, 'London'),
(2,'Jonth', 10, 'Paris'),
(3,'Blacke', 30, 'Paris'),
(4,'Clarck', 20, 'London'),
(5,'Adams', 30, 'Athens');
select * from Suppliers;

create table Details (detailid int, name varchar(30), color varchar(30),weight integer, city varchar(30));
INSERT INTO Details (detailid, name, color, weight, city) VALUES 
(1,'Screw', 'Red', 12, 'London'),
(2,'Bolt', 'Green', 17, 'Paris'),
(3,'Male-screw', 'Blue', 17, 'Roma'),
(4,'Male-screw', 'Red', 14, 'London'),
(5,'Whell', 'Blue', 12, 'Paris'),
(6,'Bloom', 'Red', 19, 'London');
select * from Details;

create table Products (Productid int, name varchar(30), city varchar(30));
INSERT INTO Products (Productid, name, city) VALUES 
(1,'HDD', 'Paris'),
(2,'Perforator', 'Roma'),
(3,'Reader', 'Athens'),
(4,'Printer', 'Athens'),
(5,'FDD', 'London'),
(6,'Terminal', 'Oslo'),
(7,'Ribbon', 'London');
select * from Products;

create table Supplies (supplierid int, detailid integer, Productid integer,quantity integer);
INSERT INTO Supplies (supplierid, detailid, Productid, quantity) VALUES 
(1,1,1,200),
(1,1,4,700),
(2,3,1,400),
(2,3,2,200),
(2,3,3,200),
(2,3,4,500),
(2,3,5,600),
(2,3,6,400),
(2,3,7,800),
(2,5,2,100),
(3,3,1,200),
(3,4,2,500),
(4,6,3,300),
(4,6,7,300),
(5,2,2,200),
(5,2,4,100),
(5,5,5,500),
(5,5,7,100),
(5,6,2,200),
(5,1,4,100),
(5,3,4,200),
(5,4,4,800),
(5,5,4,400),
(5,6,4,500);
select * from Supplies;
delete from Supplies;
---Task 1---
update Suppliers set rating=rating+10 where rating < (select rating from Suppliers where supplierid=4);
---Task 2---
select * into Products5 from Products where city='London' or 
city in  
(select Suppliers.city from Supplies 
inner join Suppliers on Suppliers.supplierid = Supplies.supplierid
inner join Products on Products.productid = Supplies.productid where Suppliers.city = 'London');
select * from Products5;
---Task3---
delete from Products from Products left join Supplies on Supplies.productid=Products.productid where Supplies.productid is null;
---Task4---
select supplierid, detailid into Suppliers37 from Supplies GROUP BY supplierid,detailid HAVING COUNT(detailid) = 2; 
select * from Suppliers37;
---Task5---
update Supplies set quantity=quantity*1.1 where detailid in 
(select Details.detailid from Details inner join Supplies on Supplies.detailid=Details.detailid where Details.color='Red');
---Task6---
select distinct(color), city into Details4 from Details;
select * from Details14;
--Task7--
select detailid into Details15 from Details 
where city in 
(select Suppliers.city from Suppliers 
inner join Supplies on Suppliers.supplierid = Supplies.supplierid
inner join Details on Details.detailid = Supplies.detailid where Suppliers.city = 'London');

select detailid into Details15 from Details 
where city in 
(select Products.city from Products 
inner join Supplies on Products.productid = Supplies.productid 
inner join Suppliers on Suppliers.supplierid = Supplies.supplierid where Products.city = 'London');
---Task8---
INSERT INTO Suppliers (supplierid, name, rating, city) VALUES (10,'Uayt', Null, 'New York')
select * from Suppliers;
---Task9---
DELETE supplies from supplies inner join Products on supplies.productid=Products.productid WHERE Products.city='Roma';
DELETE from Products WHERE Products.city='Roma';
--Task10---
select distinct(Products.city), Products.productid, supplies.supplierid into Products28 from supplies 
inner join Suppliers on Suppliers.supplierid = supplies.supplierid
inner join Products on Products.productid = supplies.productid;
select * from Products28;
--Task11---
update Details set color='Yellow' where weight<15 and color='Red';
--Task12---
select * into Products31 from Products where city like '_o%';
select * from Products31;
--Task13---
update Suppliers set rating=rating+10 where rating > (select AVG(rating) from Suppliers);
select * from Suppliers;
--Task14--
select Supplies.supplierid, name into Suppliers11 from Suppliers inner join Supplies on
Supplies.supplierid =Suppliers.supplierid
where Productid=1; 
select * from Suppliers11;
--Task15--
INSERT INTO Suppliers9 (name) VALUES 
('Robi'),
('Deack');
--Merge 1--
create table  tmp_Details (detailid integer, name varchar(30), color varchar(30), weight integer, city varchar(30));
INSERT INTO tmp_Details (detailid, name, color, weight, city) 
VALUES (1, 'Screw',         'Blue',     13, 'Osaka');
INSERT INTO tmp_Details (detailid, name, color, weight, city) 
VALUES (2, 'Bolt',           'Pink', 12, 'Tokio');
INSERT INTO tmp_Details (detailid, name, color, weight, city) 
VALUES (18, 'Whell-24', 'Red',   14, 'Lviv');
INSERT INTO tmp_Details (detailid, name, color, weight, city) 
VALUES (19, 'Whell-28', 'Pink',     15, 'London');
select * from tmp_Details;
--Merge 2--
merge Details as D using 
(select detailid, name, color, weight, city from tmp_Details) as B
(detailid, name, color, weight, city) on
(D.detailid=B.detailid)
when not matched then insert (detailid, name, color, weight, city)
values (detailid, name, color, weight, city);
select * from Details;

