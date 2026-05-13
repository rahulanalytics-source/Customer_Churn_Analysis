--1. Who are the top 10 customers by total revenue?
SELECT 
    CustomerID,
    ROUND(SUM(Quantity * UnitPrice)::numeric, 2) AS TotalRevenue
FROM onlineretail
GROUP BY CustomerID
ORDER BY TotalRevenue DESC
LIMIT 10;

--2. Which customers placed the most orders?
SELECT
    CustomerID,
    COUNT(DISTINCT InvoiceNo) AS TotalOrders
FROM onlineretail
GROUP BY CustomerID
ORDER BY TotalOrders DESC
LIMIT 10;

--3. Which customers purchased only once?
SELECT 
    CustomerID,
    COUNT(DISTINCT InvoiceNo) AS TotalOrders
FROM onlineretail
GROUP BY CustomerID
HAVING COUNT(DISTINCT InvoiceNo) = 1;

--4. Which products generate the highest revenue?
SELECT 
    StockCode,
    Description,
    ROUND(SUM(Quantity * UnitPrice)::numeric, 2) AS ProductRevenue
FROM onlineretail
GROUP BY StockCode, Description
ORDER BY ProductRevenue DESC
LIMIT 10;

--5. Which products are sold the most by quantity?
SELECT 
    StockCode,
    Description,
    SUM(Quantity) AS TotalUnitsSold
FROM onlineretail
GROUP BY StockCode, Description
ORDER BY TotalUnitsSold DESC
LIMIT 10;

--6. Which countries generate the highest revenue?
SELECT 
    Country,
    ROUND(SUM(Quantity * UnitPrice)::numeric, 2) AS CountryRevenue
FROM onlineretail
GROUP BY Country
ORDER BY CountryRevenue DESC;

--7. What is the monthly sales trend over time?

SELECT 
    TO_CHAR(
        TO_TIMESTAMP(invoicedate, 'DD-MM-YYYY HH24:MI'),
        'YYYY-MM'
    ) AS Month,

    ROUND(SUM(quantity * unitprice)::numeric, 2) AS MonthlyRevenue

FROM onlineretail

GROUP BY Month
ORDER BY Month;

--8. What is the average order value for each customer?
SELECT 
    CustomerID,
    ROUND(
        (
            SUM(Quantity * UnitPrice) /
            COUNT(DISTINCT InvoiceNo)
        )::numeric,
        2
    ) AS AvgOrderValue
FROM onlineretail
GROUP BY CustomerID
ORDER BY AvgOrderValue DESC;

--9. Which customers have been inactive for the longest time?
SELECT 
    CustomerID,
    MAX(InvoiceDate) AS LastPurchaseDate
FROM onlineretail
GROUP BY CustomerID
ORDER BY LastPurchaseDate ASC;

--10. Which countries have the highest average customer spending?
SELECT 
    Country,
    ROUND(
        (
            SUM(Quantity * UnitPrice) /
            COUNT(DISTINCT CustomerID)
        )::numeric,
        2
    ) AS AvgCustomerSpend
FROM onlineretail
GROUP BY Country
ORDER BY AvgCustomerSpend DESC;