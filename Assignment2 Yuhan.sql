--Answer following questions 
--1 What is a result set? 
--The result set is the result of your query. 
--2 What is the difference between Union and Union All? 

--UNION extracts the rows specified in the query, but UNION ALL extracts all the results of the two results, including duplicate rows. 

--3 What are the other Set Operators SQL Server has? 

--INTERSECT, EXCEPT 

--4 What is the difference between Union and Join? 

--Join is used to combine columns from different tables, the union is used to combine rows. 

--5 What is the difference between INNER JOIN and FULL JOIN? 

-- INER JOIN can only find the rows that meet the join criteria, and FULL OUTER JOIN will get the rows that do not meet the join conditions. 

--6 What is difference between left join and outer join 

--Left join is part of outer join, outer join includes left join and right join. 

--7 What is cross join? 

--A cross join is a type of join that returns the Cartesian product of rows from two tables. 

--8 What is the difference between WHERE clause and HAVING clause? 

--The WHERE clause applies to  individual row, while the HAVING clause applies only to groups as a whole. 

--9 Can there be multiple group by columns? 

-- 	A GROUP BY clause can contain two or more columns. 

--Write queries for following scenarios 

--1 How many products can you find in the Production.Product table? 
USE AdventureWorks2019
GO
Select count(*)
From Production.Product

--2 Write a query that retrieves the number of products in the Production.Product table that are included in a subcategory. The rows that have NULL in column ProductSubcategoryID are considered to not be a part of any subcategory. 
USE AdventureWorks2019
GO
Select count(*)
From Production.Product
where ProductSubcategoryID is not null

--3 How many Products reside in each SubCategory? Write a query to display the results with the following titles. 

--ProductSubcategoryID CountedProducts 

-------------------- --------------- 
USE AdventureWorks2019
GO
Select ProductSubcategoryID, COUNT(ProductSubcategoryID) as CountedProducts
From Production.Product
where ProductSubcategoryID is not null
Group by ProductSubcategoryID

--4 How many products that do not have a product subcategory.  
USE AdventureWorks2019
GO
Select count(*)
From Production.Product
where ProductSubcategoryID is null

--5 Write a query to list the sum of products quantity in the Production.ProductInventory table. 
USE AdventureWorks2019
GO
Select *
From Production.ProductInventory

 --6 Write a query to list the sum of products in the Production.ProductInventory table and LocationID set to 40 and limit the result to include just summarized quantities less than 100. 

              --ProductID    TheSum 

-----------        ---------- 
USE AdventureWorks2019
GO
Select ProductID, SUM(Quantity) as TheSum
From Production.ProductInventory
where LocationID = 40
group by ProductID
Having SUM(Quantity) < 100

--7 Write a query to list the sum of products with the shelf information in the Production.ProductInventory table and LocationID set to 40 and limit the result to include just summarized quantities less than 100 

--Shelf      ProductID    TheSum 

---------- -----------        ----------- 
USE AdventureWorks2019
GO
Select Shelf, ProductID, SUM(Quantity) as TheSum
From Production.ProductInventory
where LocationID = 40
group by ProductID,Shelf
having sum(Quantity) < 100

--8 Write the query to list the average quantity for products where column LocationID has the value of 10 from the table Production.ProductInventory table. 
USE AdventureWorks2019
GO
Select AVG(Quantity) as Theavg
From Production.ProductInventory
where LocationID = 10

--9 Write query  to see the average quantity  of  products by shelf  from the table Production.ProductInventory 

--ProductID   Shelf      TheAvg 

----------- ---------- ----------- 
USE AdventureWorks2019
GO
Select Shelf, ProductID, AVG(Quantity) as Theavg
From Production.ProductInventory
Group by ROLLUP(Shelf, ProductID)

--10 Write query  to see the average quantity  of  products by shelf excluding rows that has the value of N/A in the column Shelf from the table Production.ProductInventory 

--ProductID   Shelf      TheAvg 

----------- ---------- ----------- 
USE AdventureWorks2019
GO
Select ProductID, Shelf, AVG(Quantity) as Theavg
From Production.ProductInventory
where LocationID = 10 and Shelf <> 'N/A'
Group by ROLLUP(Shelf, ProductID)
ORDER BY Shelf
--11 List the members (rows) and average list price in the Production.Product table. This should be grouped independently over the Color and the Class column. Exclude the rows where Color or Class are null. 

--Color           	Class 	TheCount   	 AvgPrice 

--------------	- ----- 	----------- 	--------------------- 
USE AdventureWorks2019
GO
Select Color, Class, count(*) as TheCount, AVG(ListPrice) as AvgPrice
From Production.Product
where Class is not null and Color is not null
group by grouping sets ((Color),(Class))
--Joins: 

  --12 Write a query that lists the country and province names from person. CountryRegion and person. StateProvince tables. Join them and produce a result set similar to the following.  

 

--Country                        Province 

---------                          ---------------------- 
USE AdventureWorks2019
GO
SELECT DISTINCT c.Name as Country, s.Name as Province
from Person.StateProvince s
join Person.CountryRegion c
on s.CountryRegionCode = c.CountryRegionCode

--13 Write a query that lists the country and province names from person. CountryRegion and person. StateProvince tables and list the countries filter them by Germany and Canada. Join them and produce a result set similar to the following. 

 

--Country                        Province 

---------                          ---------------------- 
USE AdventureWorks2019
GO
SELECT DISTINCT c.Name as Country, s.Name as Province
from Person.StateProvince s
join Person.CountryRegion c
on s.CountryRegionCode = c.CountryRegionCode
where c.Name = 'Germany' or c.Name = 'cannada'

--        Using Northwnd Database: (Use aliases for all the Joins) 

--14 List all Products that has been sold at least once in last 25 years. 
USE Northwind
GO
Select distinct p.ProductName
from Products p
join [Order Details] o
on p.ProductID = o.ProductID
join Orders r
on r.OrderID = o.OrderID
where r.OrderDate between '1996-8-17' and '2021-8-17'

--15 List top 5 locations (Zip Code) where the products sold most. 
USE Northwind
GO
Select top 5 ShipPostalCode
from Orders
Group by ShipPostalCode
order by count(ShipPostalCode) desc

--16 List top 5 locations (Zip Code) where the products sold most in last 25 years. 
USE Northwind
GO
Select top 5 ShipPostalCode
from orders
where OrderDate between '1996-08-17' and '2021-08-17'
group by ShipPostalCode
order by count(ShipPostalCode) desc

--17 List all city names and number of customers in that city.      
USE Northwind
GO
Select City, count(ContactName) as 'Number of customers for city'  
from Customers
group by City
 
--18 List city names which have more than 2 customers, and number of customers in that city  
USE Northwind
GO
Select City, count(ContactName) as 'Number of customers for city'  
from Customers
group by City
having count(ContactName) > 10

--19 List the names of customers who placed orders after 1/1/98 with order date. 
USE Northwind
GO
SELECT distinct c.ContactName
from Orders o
join Customers c
on o.CustomerID = c.CustomerID
where OrderDate between '1998-01-01' and '2021-8-17'

--20 List the names of all customers with most recent order dates  
-- Sorry i dont know the answer for this question
--21 Display the names of all customers  along with the  count of products they bought  
USE Northwind
GO
SELECT c.ContactName, count(c.ContactName)
from Orders o
join Customers c
on o.CustomerID = c.CustomerID
group by c.ContactName 
order by count(c.ContactName) desc

--22 Display the customer ids who bought more than 100 Products with count of products. 
USE Northwind
GO
SELECT c.ContactName, sum(r.Quantity)
from Orders o
join Customers c
on o.CustomerID = c.CustomerID
join [Order Details] r
on r.OrderID = o.OrderID
group by c.ContactName
having sum(r.Quantity) > 100
order by sum(r.Quantity) desc

--23 List all of the possible ways that suppliers can ship their products. Display the results as below 

--Supplier Company Name   	Shipping Company Name 

---------------------------------            ---------------------------------- 
USE Northwind
GO
SELECT u.CompanyName, s.CompanyName
from Shippers s
cross join Suppliers u

--24 Display the products order each day. Show Order date and Product Name. 
USE Northwind
GO
SELECT distinct d.OrderID, p.ProductName
FROM Products p
join [Order Details] o
on p.ProductID = o.ProductID
join Orders d
on d.OrderID = o.OrderID

--25 Displays pairs of employees who have the same job title. 
USE Northwind
GO
SELECT *
from Employees e
join Employees m
on e.Title = m.Title

--26 Display all the Managers who have more than 2 employees reporting to them. 
USE Northwind
GO
SELECT e.EmployeeID, e.LastName, e.FirstName, e.Title
from Employees e
join Employees m
on e.EmployeeID = m.ReportsTo
where e.Title like '%manager%'
group by e.EmployeeID, e.FirstName, e.LastName, e.Title
having count(e.ReportsTo) > 2

--27 Display the customers and suppliers by city. The results should have the following columns 

--City  

--Name  

--Contact Name, 

--Type (Customer or Supplier) 
USE Northwind
GO
SELECT City, ContactName,'Customers' as Type
from Customers
union 
select City, ContactName, 'Supplier' as Type
from Suppliers

-- 28. Have two tables T1 and T2 

--F1.T1 

--F2.T2 

--1 

--2 

--2 

--3 

--3 

--4 
-- Select *
-- from F1 join F2
-- on F1.T1 = F2.T2
--output 
--2  3
 

--Please write a query to inner join these two tables and write down the result of this query. 

-- 29. Based on above two table, Please write a query to left outer join these two tables and write down the result of this query. 
-- Select * 
-- from F1 
-- right join F2
-- on F1.T1 = F2.T2
--output 2   2
--       3   3
--      null 4
 

--GOOD  LUCK. 