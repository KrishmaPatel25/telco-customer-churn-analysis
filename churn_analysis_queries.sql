#Ranking Payment Methods by Total Revenue
SELECT 
PaymentMethod,
ROUND(SUM(TotalCharges), 2) AS total_revenue,
ROUND(AVG(MonthlyCharges), 2) AS avg_monthly_revenue
 FROM `capstone-project-498416.Customer_churn_analysis.telco_churn` 
 GROUP BY PaymentMethod
 ORDER BY total_revenue DESC;

#Analyzing Churn by "Internet Service" type
 SELECT
 InternetService,
 COUNT(*) AS total_customers,
 COUNTIF(Churn IS true) AS churned_customers,
 ROUND(COUNTIF(Churn IS true)*100/ COUNT(*), 2) AS churn_rate_percentage
 FROM `capstone-project-498416.Customer_churn_analysis.telco_churn`
 GROUP BY InternetService
 ORDER BY churn_rate_percentage DESC;

 --Finding null value
 SELECT 
 col_name, 
  COUNT(*) AS null_count
 FROM `capstone-project-498416.Customer_churn_analysis.telco_churn` AS t,
 UNNEST(REGEXP_EXTRACT_ALL(TO_JSON_STRING(t), r'"([^"]+)":null')) AS col_name
GROUP BY col_name
ORDER BY null_count DESC;

--Connecting the Dots: The Hidden Narrative
/*fibre optic has highest churn rate percentage and electronic checks have highest monthly avg cost of $76.26 which means Fiber 

Optic is a premium, high-speed service, which means it costs more money.
High costs drive up the monthly bill, pushing those customers into that high-average $76+ tier.

Because many of those customers are paying manually via Electronic Check, they face "sticker shock" every single month when they look at their high bill and physically have to process the payment.

This combination of high cost and manual friction is causing them to abandon ship at a massive 41% clip*/

## To check the above theory we will perform a query to check Fiber Optic users who use Electronic Checks churn faster than Fiber Optic users who use automatic credit cards
SELECT 
    InternetService,
    PaymentMethod,
    COUNT(*) AS total_customers,
    COUNTIF(Churn = true) AS churned_customers,
    ROUND(COUNTIF(Churn = true) * 100.0 / COUNT(*), 2) AS churn_rate_percentage
FROM `capstone-project-498416.Customer_churn_analysis.telco_churn`
WHERE InternetService = 'Fiber optic'
GROUP BY InternetService, PaymentMethod
ORDER BY churn_rate_percentage DESC;

/*after performing the querry we discovered that Let's look at the incredible contrast you just uncovered:
The High-Risk Combo: Fiber Optic + Electronic Check = 53.23% Churn
The Low-Risk Combo: Fiber Optic + Credit Card (automatic) = 25.29% Churn */
