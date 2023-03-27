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

SELECT *
FROM telecom_customer_churn;

SELECT *
FROM telecom_zipcode_population;
