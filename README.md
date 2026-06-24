# telco-customer-churn-analysis
An end-to-end data analytics project using SQL, Excel, and Tableau to isolate high-revenue customer churn trends.
# Telco Customer Retention Analysis: High-Revenue Friction Points

## 🔗 Project Links
* [Interactive Tableau Dashboard](https://public.tableau.com/views/TelcoCustomerRetentionAnalysisHigh-RevenueFrictionPoints/TelcoCustomerRetentionAnalysisHigh-RevenueFrictionPoints?:language=en-GB&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)
* [SQL Code Repository] [churn_analysis_queries.sql](https://github.com/KrishmaPatel25/telco-customer-churn-analysis/blob/a73e51d74aec584ccfbc1811932a2b5bdab83623/churn_analysis_queries.sql)

## 📌 Project Overview
This end-to-end project utilizes the industry-standard **IBM Telco Customer Churn dataset from Kaggle**. The raw dataset represents 7,043 unique telecommunications accounts. By ingesting this data into **Google BigQuery**, executing targeted SQL analysis, and normalizing metrics in Excel, I isolated critical billing friction points impacting top-line recurring revenue.

## 📈 Key Discoveries
* **The Revenue Engine:** Electronic Check is the highest-grossing payment method, bringing in over **$4.94M** in total revenue.
* **The Baseline Leak:** Fiber Optic internet customers exhibit an alarming baseline churn rate of **41.89%**—more than double that of DSL.
* **The Smoking Gun:** Multi-dimensional analysis isolated that Fiber Optic customers paying via Electronic Check experience a staggering **53.23% churn rate**, representing a massive revenue leakage point for the business compared to automatic credit card users (**25.29%**).

## 🛠️ Tools & Technologies Used
* **SQL (Google BigQuery):** Advanced data profiling, null-value metadata filtering, and multi-conditional aggregation logic.
* **Excel / CSV:** Data cleaning, table division, and structural verification.
* **Tableau Public:** Advanced dashboard building, color-contrast engineering, and interactive metric delivery.

## 💡 Proposed Business Solutions
To combat the massive **53.23% churn rate** identified at the intersection of Fiber Optic services and Electronic Check payments, the following interventions are recommended:

1. **Incentivize Auto-Pay Migration:** Implement a one-time invoice credit (e.g., $5 to $10) for existing Electronic Check users who transition to automatic credit card or bank transfer billing. Over time, reducing manual billing touchpoints mitigates monthly "sticker shock."
2. **Targeted Billing UX Audits:** Investigate the digital Electronic Check payment pathway for technical friction, clear pricing, transparent breakdowns, or hidden transaction fees that could be triggering frustration at the exact moment of payment.
3. **Proactive Retention Offers:** Deploy automated, proactive email/SMS discount campaigns or customer satisfaction check-ins exclusively targeting high-value Fiber Optic lines currently utilizing manual payment methods before their billing cycle completes.

## 🧠 My Analytical Process
I built this project because I wanted to dig past surface-level metrics. Initially, looking at just the billing revenue or just the general internet churn rates didn't show the full picture. By using SQL subqueries to break the data down further, I found that the real issue wasn't the product itself, but a combination of premium pricing mixed with high-friction manual payment methods.
