--Answer following questions 

--1 In SQL Server, assuming you can find the result by using both joins and subqueries, which one would you prefer to use and why? 
--It depends on the specific situation. Subqueries can be used to retrieve more accurate results such as a single value or row set, but join clause can only get row set. But in most cases, join clause performs better and searches faster. 

--2 What is CTE and when to use it? 
--CTE is Common Table Expression. It used to create recursive query. When u need to join a same data set multiple times, u can define a CTE. 

--3 What are Table Variables? What is their scope and where are they created in SQL Server? 
--A table variable is a local variable that has some similarities to temp tables. We can define a table variable inside a stored procedure and function. We cannot use it outside of the batch. 

--4 What is the difference between DELETE and TRUNCATE? Which one will have better performance and why? 
--Truncate reseeds identity values, whereas delete doesn't. 
--Truncate removes all records and doesn't fire triggers. 
--Truncate is faster compared to delete because I don��t scan every record before moving on. 

--5 What is Identity column? How does DELETE and TRUNCATE affect it? 
--The identity column is a value generated by the database. TRUNCATE reset identity value to original seed value of table, DELET doesn��t not. 

--6 What is difference between ��delete from table_name�� and ��truncate table table_name��? 
--��Truncate table name�� Cannot rollback. 


--Write queries for following scenarios 
--All scenarios are based on Database NORTHWND. 

--1 List all cities that have both Employees and Customers. 
USE Northwind
GO
SELECT DISTINCT City 
from Customers 
where City in (Select City FROM Employees)

--2 List all cities that have Customers but no Employee. 

--Use sub-query 
USE Northwind
GO
SELECT DISTINCT City
from Customers
where City not in (SELECT City FROM Employees)

--Do not use sub-query 
USE Northwind
GO
SELECT DISTINCT c.City
FROM Customers c
LEFT JOIN Employees e
on c.City = e.City

--3 List all products and their total order quantities throughout all orders. 
USE Northwind
GO
SELECT DISTINCT c.CustomerID, c.ContactName, c.CompanyName, SUM(od.Quantity) as ODQTY
FROM Customers c
LEFT JOIN Orders o
on c.CustomerID = o.CustomerID
LEFT JOIN [Order Details] od
on o.OrderID = od.OrderID
group by c.CustomerID, c.ContactName, c.CompanyName
order by ODQTY DESC

--4 List all Customer Cities and total products ordered by that city. 
USE Northwind
GO
SELECT c.City, SUM(od.Quantity) as ODQTY
FROM Customers c
LEFT JOIN Orders o
on c.CustomerID = o.CustomerID
LEFT JOIN [Order Details] od
on o.OrderID = od.OrderID
GROUP BY c.City
order by ODQTY

--5 List all Customer Cities that have at least two customers. 

--Use union 
USE Northwind
GO
SELECT c.City
from Customers c
group by c.City 
having COUNT(c.City) > 2
UNION
SELECT u.City
from Customers u
group by u.City 
having COUNT(u.City) >= 2

--Use sub-query and no union 
USE Northwind
GO
SELECT DISTINCT c.City
from Customers c
where c.City in (
SELECT u.city 
From Customers u
Group by u.City
having COUNT(u.City)>=2)

--6 List all Customer Cities that have ordered at least two different kinds of products. 
USE Northwind
GO
SELECT  c.City
from Orders o
join Customers c
On o.CustomerID = c.CustomerID
JOIN [Order Details] od
on o.OrderID = od.OrderID
Group by c.City, od.ProductID
having COUNT(od.ProductID)>2

--7 List all Customers who have ordered products, but have the ��ship city�� on the order different from their own customer cities. 
USE Northwind
GO
SELECT *
FROM Customers c
where c.City not in (
SELECT o.ShipCity
From Orders o
join Customers c
on o.ShipCity = c.City
)

--8 List 5 most popular products, their average price, and the customer city that ordered most quantity of it. 

--9 List all cities that have never ordered something but we have employees there. 
--Use sub-query 
USE Northwind
GO
SELECT distinct e.City
From Employees e
where e.City not in(
Select c.City
From Orders o
join Customers c
on o.CustomerID = c.CustomerID)

--Do not use sub-query 
USE Northwind
GO
SELECT distinct e.City
From Employees e
left Join Customers c
on e.City = c.City
where c.City is null

--10 List one city, if exists, that is the city from where the employee sold most orders (not the product quantity) is, and also the city of most total quantity of products ordered from. (tip: join  sub-query) 
USE Northwind
GO
SELECT*
from (
Select Top 1 e.City, count(o.OrderID) as CountOrder
from Employees e
join Orders o
on e.EmployeeID = o.EmployeeID
group by e.City) T1
join (
SELECT Top 1 c.City, count(od.Quantity) as countquantity
fROM [Order Details] od
join Orders d
on od.OrderID = d.OrderID
join Customers c
on c.CustomerID = d.CustomerID
group by c.City) T2
on T1.City = T2.City
-- Not sure why nothing return

--11. How do you remove the duplicates record of a table? 
--Find duplicates row by Group by clause and use DELET clause to delet it.
--12. Sample table to be used for solutions below- Employee (empid integer, mgrid integer, deptid integer, salary money) Dept (deptid integer, deptname varchar(20)) 
-- Find employees who do not manage anybody. 
USE Northwind
GO
SELECT deptname, empid, salary
From (
Select d.deptname, e.empid, e.salary, rank()OVER (PARTITION BY e.deptid Order by e.salary desc) AS rnk
from Dept.d, Employee e
where d.deptid = e.deptid
)
where rnk <=3
Order by deptname,rnk

--13. Find departments that have maximum number of employees. (solution should consider scenario having more than 1 departments that have maximum number of employees). Result should only have - deptname, count of employees sorted by deptname. 
-- Sorry i dont know the answer
--14. Find top 3 employees (salary based) in every department. Result should have deptname, empid, salary sorted by deptname and then employee with high to low salary. 
USE Northwind
GO
SELECT deptname, empid, salary
from (
Select d.deptname, e.empid, e.salary, rank() OVER (PARTITION BY e.deptid ORDER BY e.salary DESC) as rnk
FROM Dept d, Employee e
WHERE d.deptid = e.deptid)
where rnk <=3
order by deptname, rnk

--GOOD  LUCK. 