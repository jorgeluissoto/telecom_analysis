/* Average tenure in months */
-- 32.4 months 
SELECT 
    AVG(Tenure_in_Months)
FROM
    telecom_customer_churn;

/* Average monthyl revenue */
-- cutomer that churn have a higher Avg. Monthly revenue
SELECT 
    Customer_Status, AVG(Monthly_Charge) AS AvgMonthlyRevenue
FROM
    telecom_customer_churn
GROUP BY Customer_Status
ORDER BY 2 DESC;  

/* Contract type by customer status */
-- Compared to the customers that "stayed", "Joined" and "Churned" have a higher number of customer on month-to-month
-- Contract is key get more customers on 1 or 2 years contract by providing incentives  
SELECT 
    COUNT(DISTINCT Customer_ID), Customer_Status, Contract
FROM
    telecom_customer_churn
GROUP BY 2,3;
 
/* How many customers joined the company during the last quarter? How many customers joined? */
-- 1051 customer joined last quarter 
SELECT 
	-- Age, Tenure_in_Months
	COUNT(Customer_ID) AS NewCustomerThisQuarter
FROM
    telecom_customer_churn
WHERE
    Tenure_in_Months <= 3;

/* What is the customer profile for a customer that churned, joined, and stayed? Are they different? */

-- Average Monthly charge by Customer status
-- Customer that churn have the highest average monthly bill followed by Stayed and Joined
SELECT 
    Customer_Status, AVG(Monthly_Charge) AS AvgMonthlyCharge
FROM
    telecom_customer_churn
GROUP BY Customer_Status
ORDER BY 2 DESC;

-- Total charges by Customer status
-- Our "Stayed" customer spent $13.1M, "Churned" spent $2.8M, "Joined" spent $35k 
SELECT 
    Customer_Status, SUM(Total_Charges) AS TotalCharges
FROM
    telecom_customer_churn
GROUP BY Customer_Status
ORDER BY TotalCharges DESC;

-- Number of referrals by Customer status
-- "Stayed" refered 12,342 customers, "Churned" refered 974 customers, "Joined" refered 431 customers 
SELECT Customer_status, SUM(Number_of_Referrals) AS TotalReferrals
FROM telecom_customer_churn
GROUP BY Customer_Status
ORDER BY TotalReferrals DESC; 

/* What seem to be the key drivers of customer churn? */
-- 841 noted "Competitor" as the reason for leaving. 
SELECT 
    COUNT(Customer_ID) AS NumberofCustomers,
    Churn_Category,
    Customer_Status
FROM
    telecom_customer_churn
WHERE
    Customer_Status = 'Churned'
GROUP BY 2
ORDER BY 1 DESC;

/* Is the company losing high value customers? If so, how can they retain them? */
-- Yes. Our most valuable customer have the highest average monthly charge as well as the highest churn.
-- We can look at offering incentives to drive more people to sign 1 to 2 year contracts since most customers have month to month 

/* What zip code our customer churning in? */
-- 92126, 92117, 92122, 92109, 92028 these zipcode hold a large number of customer that are churning.
-- we can focus our marketing effort in this area 
SELECT 
    Customer_Status, tc.Zip_Code, SUM(population)
FROM
    telecom_customer_churn tc
        LEFT JOIN
    telecom_zipcode_population tp ON tc.Zip_Code = tp.Zip_Code
GROUP BY 1 , 2
ORDER BY 3 DESC;

SELECT *
FROM telecom_customer_churn;

SELECT *
FROM telecom_zipcode_population;
