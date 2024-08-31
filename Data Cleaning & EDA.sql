                                   --Data Cleaning 

--01.Establish the relationship between the tables 

ALTER TABLE OrdersList
ALTER COLUMN ORDERID VARCHAR(150) NOT NULL;

ALTER TABLE OrdersList
ADD CONSTRAINT PK_ORDERID PRIMARY KEY (ORDERID);

ALTER TABLE EachOrderBreakdown
ALTER COLUMN ORDERID VARCHAR(150) NOT NULL

ALTER TABLE EachOrderBreakdown
ADD CONSTRAINT FK_ORDERID FOREIGN KEY (ORDERID) REFERENCES OrdersList (ORDERID);


--2. Split City State Country into 3 individual columns namely ‘City’, ‘State’, ‘Country’. 

 ALTER TABLE OrdersList 
    ADD City Varchar(50),
    State Varchar(80),
	Country Varchar(100);

UPDATE OrdersList
SET COUNTRY= PARSENAME( REPLACE([City State Country],',','.'),1),
    State= PARSENAME( REPLACE([City State Country],',','.'),2),
	City= PARSENAME( REPLACE([City State Country],',','.'),3);


alter table OrdersList
drop column [City State Country];


/*3. Add a new Category Column using the following mapping as per the first 3 characters in the 
Product Name Column:  
a. TEC- Technology 
b. OFS – Office Supplies 
c. FUR - Furniture */

ALTER TABLE EachOrderBreakdown
ADD CATEGORY VARCHAR(50)

UPDATE EachOrderBreakdown
SET CATEGORY = CASE WHEN ProductName LIKE 'OFS%' THEN 'Office Supplies'
                    WHEN ProductName LIKE 'FUR%' THEN 'Furniture'
					WHEN ProductName LIKE 'TECH%' THEN 'Technology'
					END;
--4.Delete the first 4 characters from the ProductName Column. 

UPDATE EachOrderBreakdown
SET ProductName = SUBSTRING(ProductName,CHARINDEX('-',ProductName)+1,LEN(ProductName))

--5.Remove duplicate rows from EachOrderBreakdown table, if all column values are matching

WITH T1 AS (
SELECT *
       ,ROW_NUMBER() OVER (PARTITION BY ORDERID,PRODUCTNAME,DISCOUNT,SALES,PROFIT,QUANTITY,SUBCATEGORY,CATEGORY ORDER BY ORDERID) AS RN
FROM EachOrderBreakdown)

DELETE 
FROM T1
WHERE RN>1



                                          --Data Exploration--

--1.List the top 10 orders with the highest sales from the EachOrderBreakdown table.

SELECT TOP 10 OrderID
      ,SUM(Sales) AS TOTAL_SALES
FROM EachOrderBreakdown
GROUP BY OrderID
ORDER BY TOTAL_SALES DESC;

--2. Show the number of orders for each category in the EachOrderBreakdown table.

SELECT CATEGORY
       ,COUNT(OrderID) AS NO_OF_ORDERS
FROM EachOrderBreakdown
GROUP BY CATEGORY
ORDER BY 2 DESC;

--3. Find the total profit for each sub-category in the EachOrderBreakdown table. 

SELECT SubCategory
       ,SUM(Profit) AS TOTAL_PROFIT
FROM EachOrderBreakdown
GROUP BY SubCategory
ORDER BY 2 DESC;

--4. Identify the customer with the highest total sales across all orders. 

SELECT O.CustomerName
       ,SUM(E.Sales) AS TOTAL_SALES
FROM OrdersList O
JOIN EachOrderBreakdown E
ON O.OrderID = E.OrderID
GROUP BY O.CustomerName
ORDER BY 2 DESC;

--5. Find the month with the highest average sales in the OrdersList table.


SELECT DATENAME(MONTH,O.OrderDate) AS MONTH_
       ,AVG(E.Sales) AS TOTAL_SALES
FROM OrdersList O
JOIN EachOrderBreakdown E
ON O.OrderID = E.OrderID
GROUP BY DATENAME(MONTH,O.OrderDate)
ORDER BY 2 DESC;

--6. Find out the average quantity ordered by customers whose first name starts with an alphabet 's'?

SELECT O.CustomerName
       ,AVG(E.Quantity) AS TOTAL_SALES
FROM OrdersList O
JOIN EachOrderBreakdown E
ON O.OrderID = E.OrderID
WHERE O.CustomerName LIKE 's%'
GROUP BY O.CustomerName
ORDER BY 2 DESC;

--7. Find out how many new customers were acquired in the year 2014?
WITH T1 AS (
SELECT CustomerName
       ,MIN(OrderDate) AS NEW_CUST
FROM OrdersList
GROUP BY CustomerName
HAVING MIN(YEAR(ORDERDATE))='2014')

SELECT 'new customers were acquired in the year 2014' AS [2014], COUNT(CustomerName) AS TOTAL_CUST
FROM T1

--8. Calculate the percentage of total profit contributed by each sub-category to the overall profit. 

SELECT SubCategory
       ,SUM(Profit) AS TOTAL_PROFIT
	   ,FORMAT(SUM(Profit)/(SELECT SUM(Profit) FROM EachOrderBreakdown),'P') AS CONTRIBUTION
FROM EachOrderBreakdown
GROUP BY SubCategory
ORDER BY 3 DESC;

--9. Find the average sales per customer, considering only customers who have made more than one order. 

SELECT CustomerName
       ,AVG(Sales) AS AVG_SALES
FROM OrdersList O
JOIN EachOrderBreakdown E
ON O.OrderID = E.OrderID
GROUP BY CustomerName
HAVING COUNT(O.OrderID)>1

/*10. Identify the top-performing subcategory in each category based on total sales. Include the sub
category name, total sales, and a ranking of sub-category within each category.*/

WITH T1 AS (
SELECT CATEGORY
      ,SubCategory
	  ,SUM(Sales) AS TOTAL_SALES
	  ,ROW_NUMBER() OVER (PARTITION BY CATEGORY ORDER BY SUM(SALES) DESC) AS RN
FROM EachOrderBreakdown
GROUP BY CATEGORY,SubCategory)

SELECT *
FROM T1
WHERE RN =1