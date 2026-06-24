/*******************************************************************************
PROJECT: Telco Customer Retention Analysis
DATA SOURCE: IBM Telco Customer Churn Dataset (Sourced via Kaggle)
ENVIRONMENT: Google BigQuery (SQL Workspace), Spreadsheets & Tableau Public
BUSINESS PROBLEM: High-volume customer attrition eroding recurring revenue streams.
*******************************************************************************/

-- =============================================================================
-- SECTION 1: DATA COMPREHENSION & ORIGIN
-- Where did this data come from?
-- The dataset contains 7,043 rows representing individual customer accounts.
-- Each record tracks demographics, subscribed services (Internet, Phone, Security), 
-- billing payment methods, monthly/total charges, and their final Churn status.
-- =============================================================================

-- Step 1.1: Metadata Profiling & Data Cleaning
-- Before diving into analysis, I ran a dynamic script to audit our tables 
-- for null values to ensure structural data integrity.
 SELECT 
 col_name, 
  COUNT(*) AS null_count
 FROM `capstone-project-498416.Customer_churn_analysis.telco_churn` AS t,
 UNNEST(REGEXP_EXTRACT_ALL(TO_JSON_STRING(t), r'"([^"]+)":null')) AS col_name
GROUP BY col_name
ORDER BY null_count DESC;

-- =============================================================================
-- SECTION 2: ISOLATING THE REVENUE ENGINE
-- Business Context: We need to map out where our biggest revenue streams sit.
-- If a high-revenue segment is churning, it threatens the company's financial core.
-- =============================================================================

-- Ranking Payment Methods by Total Revenue
SELECT 
PaymentMethod,
ROUND(SUM(TotalCharges), 2) AS total_revenue,
ROUND(AVG(MonthlyCharges), 2) AS avg_monthly_revenue
 FROM `capstone-project-498416.Customer_churn_analysis.telco_churn` 
 GROUP BY PaymentMethod
 ORDER BY total_revenue DESC;

/* Data Insight: 
   Electronic Check is our massive revenue engine, bringing in over $4.94M. 
   However, it also holds an incredibly high average monthly bill (~$76). 
*/

-- =============================================================================
-- SECTION 3: DETECTING PRODUCT LINE FRICTION
-- Business Context: Next, I evaluated which specific product types are failing 
-- to retain customers at a baseline level.
-- =============================================================================

-- Analyzing Churn by "Internet Service" type
 SELECT
 InternetService,
 COUNT(*) AS total_customers,
 COUNTIF(Churn = true) AS churned_customers,
 ROUND(COUNTIF(Churn IS true)*100/ COUNT(*), 2) AS churn_rate_percentage
 FROM `capstone-project-498416.Customer_churn_analysis.telco_churn`
 GROUP BY InternetService
 ORDER BY churn_rate_percentage DESC;

/* Data Insight: 
   Fiber Optic customers are leaving at a devastating 41.89% rate—
   more than double the churn rate of regular DSL lines.
*/

-- =============================================================================
-- SECTION 4: THE HIDDEN NARRATIVE (Connecting Product & Billing)
-- Executive Summary: Premium Fiber Optic pricing drives bills into the $76+ tier. 
-- When combined with the manual monthly touchpoint of an Electronic Check, 
-- customers experience severe billing friction ("sticker shock") every month.
-- =============================================================================

-- To check the above theory, we will perform a query to check if Fiber Optic users who use Electronic Checks churn faster than Fiber Optic users who use automatic credit cards
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

/* The Core Discovery: 
   After performing the query, we discovered that:
   Fiber Optic + Electronic Check triggers an astronomical 53.23% Churn Rate.
   In contrast, moving those same users to automated billing (Credit Card) 
   slices the churn rate down to 25.29%.
*/

