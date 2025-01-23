create database sales;
use sales;
RENAME TABLE `supermarket_sales - sheet1` 
TO `supermarket_sales`;
-- Total Sales per Branch
SELECT Branch, SUM(Total) AS Total_Sales
FROM supermarket_sales
GROUP BY Branch
ORDER BY Total_Sales DESC;
-- Average Ratings per Product Line
SELECT `Product line`, round(AVG(Rating),2) AS Avg_Ratings
FROM supermarket_sales
GROUP BY `Product line`
ORDER BY Avg_Ratings DESC;
-- Gender-wise Sales Analysis
SELECT Gender, round(SUM(Total),2) AS Total_Sales, 
COUNT(`Invoice ID`) AS Total_Transactions
FROM supermarket_sales
GROUP BY Gender
ORDER BY Total_Sales DESC;
-- Top 5 Products by Sales
SELECT `Product line`, round(SUM(Total),2) 
AS Total_Sales
FROM supermarket_sales
GROUP BY `Product line`
ORDER BY Total_Sales DESC
LIMIT 5;
-- Payment Method Distribution
SELECT Payment, COUNT(`Invoice ID`) AS Payment_Count
FROM supermarket_sales
GROUP BY Payment
ORDER BY Payment_Count DESC;
-- Profitability by Branch
SELECT Branch, round(SUM(`gross income`),2)
AS Total_Profit, round(AVG(`gross margin percentage`),2)
 AS Avg_Gross_Margin
FROM supermarket_sales
GROUP BY Branch
ORDER BY Total_Profit DESC;
-- Sales by Customer Type
SELECT `Customer type`, round(SUM(Total),2)
 AS Total_Sales
FROM supermarket_sales
GROUP BY `Customer type`
ORDER BY Total_Sales DESC;
-- Most Profitable Product Line
SELECT `Product line`, round(SUM(`gross income`),2)
 AS Total_Profit
FROM supermarket_sales
GROUP BY `Product line`
ORDER BY Total_Profit DESC;
-- Stored Procedure for Branch-Wise Sales Summary
DELIMITER //
CREATE PROCEDURE 
BranchSalesSummary(IN branch_name VARCHAR(255))
BEGIN
    SELECT Branch, 
		round(SUM(Total),2) AS Total_Sales, 
		round(AVG(Rating),2) AS Avg_Ratings, 
		round(SUM(`gross income`),2) AS Total_Profit
    FROM supermarket_sales
    WHERE Branch = branch_name
    GROUP BY Branch;
END //
DELIMITER ;

-- Call the procedure:
CALL BranchSalesSummary('A'); 
