

--Write queries for following scenarios 

--Using AdventureWorks Database 

--1 Write a query that retrieves the columns ProductID, Name, Color and ListPrice from the Production.Product table, with no filter.  

 USE AdventureWorks2019 

 Go 

 Select ProductID, Name, Color, ListPrice 

 From Production.Product 

 

--2 Write a query that retrieves the columns ProductID, Name, Color and ListPrice from the Production.Product table, the rows that are 0 for the column ListPrice 

USE AdventureWorks2019 

Go 

Select ProductID, Name, Color, ListPrice 

From Production.Product 

where ListPrice != 0 

 

--3 Write a query that retrieves the columns ProductID, Name, Color and ListPrice from the Production.Product table, the rows that are rows that are NULL for the Color column. 

USE AdventureWorks2019 

Go 

Select ProductID, Name, Color, ListPrice 

From Production.Product 

where Color IS NULL 

 

--4 Write a query that retrieves the columns ProductID, Name, Color and ListPrice from the Production.Product table, the rows that are not NULL for the Color column. 

USE AdventureWorks2019 

Go 

Select ProductID, Name, Color, ListPrice 

From Production.Product 

where Color IS NOT NULL 

 

--5 Write a query that retrieves the columns ProductID, Name, Color and ListPrice from the Production.Product table, the rows that are not NULL for the column Color, and the column ListPrice has a value greater than zero. 

USE AdventureWorks2019 

Go 

Select ProductID, Name, Color, ListPrice 

From Production.Product 

where Color IS NOT NULL AND ListPrice > 0 

 

--6 Generate a report that concatenates the columns Name and Color from the Production.Product table by excluding the rows that are null for color. 

USE AdventureWorks2019  

Go  

Select Name, Color 

From Production.Product  

where Color IS NOT NULL 

 

--7 Write a query that generates the following result set  from Production.Product: 

Name And Color 

-------------------------------------------------- 

NAME: LL Crankarm  --  COLOR: Black 

NAME: ML Crankarm  --  COLOR: Black 

NAME: HL Crankarm  --  COLOR: Black 

NAME: Chainring Bolts  --  COLOR: Silver 

NAME: Chainring Nut  --  COLOR: Silver 

NAME: Chainring  --  COLOR: Black 

    ……… 

USE AdventureWorks2019   

 Go   

 Select 'Name: '+ Name + '--Color'+ Color AS 'Name AND Color' 

 From Production.Product   

 where name LIKE 'Chainring%' OR Name Like '%Crankarm'  

 order by ProductID 

--8 Write a query to retrieve the to the columns ProductID and Name from the Production.Product table filtered by ProductID from 400 to 500 

USE AdventureWorks2019  

Go  

Select ProductID, Name 

From Production.Product  

where ProductID between 400 and 500 

 

--9 Write a query to retrieve the to the columns  ProductID, Name and color from the Production.Product table restricted to the colors black and blue 

USE AdventureWorks2019  

Go  

Select ProductID, Name, Color 

From Production.Product  

where Color in ('black', 'blue') 

--10 Write a query to generate a report on products that begins with the letter S.  

USE AdventureWorks2019  

Go  

Select * 

From Production.Product  

where name like 'S%' 

--11 Write a query that retrieves the columns Name and ListPrice from the Production.Product table. Your result set should look something like the following. Order the result set by the Name column.  

  

--Name                                               ListPrice 

-------------------------------------------------- ----------- 

--Seat Lug                                           0,00 

--Seat Post                                          0,00 

--Seat Stays                                         0,00 

--Seat Tube                                          0,00 

--Short-Sleeve Classic Jersey, L                     53,99 

--Short-Sleeve Classic Jersey, M                     53,99 

 

USE AdventureWorks2019  

Go  

Select top 6 Name, ListPrice 

From Production.Product  

where name like 'S%' 

Order by name 

--12 Write a query that retrieves the columns Name and ListPrice from the Production.Product table. Your result set should look something like the following. Order the result set by the Name column. The products name should start with either 'A' or 'S' 

  

--Name                                               ListPrice 

-------------------------------------------------- ---------- 

--Adjustable Race                                    0,00 

--All-Purpose Bike Stand                             159,00 

--AWC Logo Cap                                       8,99 

--Seat Lug                                           0,00 

--Seat Post                                          0,00 

--               ……… 

USE AdventureWorks2019  

Go  

Select top 5 Name, ListPrice 

From Production.Product  

where name like 'S%' or NAME LIKE 'A%' 

Order by name 

--13 Write a query so you retrieve rows that have a Name that begins with the letters SPO, but is then not followed by the letter K. After this zero or more letters can exists. Order the result set by the Name column. 

USE AdventureWorks2019   

Go 

Select [Name] 

from Production.Product 

where [Name] like 'spo[^k]%' 

order by [Name] 

 

--14 Write a query that retrieves unique colors from the table Production.Product. Order the results  in descending  manner 

USE AdventureWorks2019   

Go 

Select distinct Color 

from Production.Product 

order by Color 

 

--15 Write a query that retrieves the unique combination of columns ProductSubcategoryID and Color from the Production.Product table. Format and sort so the result set accordingly to the following. We do not want any rows that are NULL.in any of the two columns in the result. 

USE AdventureWorks2019   

Go 

Select distinct ProductSubcategoryID, Color 

from Production.Product 

WHERE Color is not null and ProductSubcategoryID is not null 

 

--16 Something is “wrong” with the WHERE clause in the following query.  

--We do not want any Red or Black products from any SubCategory than those with the value of 1 in column ProductSubCategoryID, unless they cost between 1000 and 2000. 

  

--Note: 

--The LEFT() function will be covered in a forthcoming module. 

  

  

SELECT ProductSubCategoryID 

      , LEFT([Name],35) AS [Name] 

      , Color, ListPrice  

FROM Production.Product 

WHERE Color IN ('Red','Black')  

      OR ListPrice BETWEEN 1000 AND 2000  

      AND ProductSubCategoryID = 1 

ORDER BY ProductID 

  

SELECT ProductSubCategoryID 

      , LEFT([Name],35) AS [Name] 

      , Color, ListPrice  

FROM Production.Product 

WHERE Color IN ('Red','Black')  

      AND ProductSubCategoryID = 1 

     OR ListPrice BETWEEN 1000 AND 2000 

ORDER BY ProductID 

 

  

 

--GOOD  LUCK. 