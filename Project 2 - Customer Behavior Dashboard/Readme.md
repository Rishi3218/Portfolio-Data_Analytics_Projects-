# 🧠 Customer Shopping Behavior Analytics  
### End-to-End Customer Insights | Python • SQL • Power BI

---

## 🚀 Project Summary
This project delivers a **full-cycle customer behavior analysis**, transforming raw transactional data into **actionable business intelligence**.

Using **Python for data preparation**, **SQL for structured business analysis**, and **Power BI for executive reporting**, the project uncovers how customers spend, what drives repeat purchases, how subscriptions impact revenue, and where businesses should focus to maximize long-term value.

This is a **decision-support analytics project**.

---

## 🎯 Business Problem
Retail businesses often collect massive amounts of customer data but struggle to answer questions like:

- Who are our **most valuable customers**?
- Do **subscriptions actually increase revenue**, or just volume?
- Which **age groups and product categories** drive growth?
- Are discounts creating loyalty — or dependency?
- How should marketing and loyalty budgets be allocated?

This project answers those questions with evidence.

---

## 📊 Dataset Overview
- **Transactions:** 3,900 customer purchases  
- **Features:** 18 columns  
- **Data Domains:**
  - Customer demographics (age, gender, subscription status)
  - Purchase behavior (category, amount, frequency, discounts)
  - Engagement signals (review ratings, shipping preferences)

**Data challenges addressed:**
- Missing review ratings (handled using category-level medians)
- Redundant fields identified and removed
- Feature engineering for age groups, purchase frequency, and segmentation

---

## 🔬 Analytical Workflow

### 1️⃣ Data Cleaning & Feature Engineering (Python)
- Data validation and profiling using pandas
- Missing value imputation using **business-aware logic**
- Column standardization (snake_case)
- Engineered features:
  - `age_group`
  - `purchase_frequency_days`
- Verified and removed redundant indicators

➡ Cleaned data was then loaded into **PostgreSQL** for scalable analysis.

---

### 2️⃣ Business Analysis (SQL)
Key analytical questions answered:

- Revenue comparison by **gender**
- Spending behavior of **discount users**
- **Subscribers vs non-subscribers**: spend, revenue, volume
- Shipping type impact on average order value
- **Top-rated products** and discount-dependent items
- Customer segmentation:
  - New
  - Returning
  - Loyal
- Relationship between **repeat purchases and subscription adoption**
- Revenue contribution by **age group**

Each query was written to answer a **business decision**, not just return numbers.

---

### 3️⃣ Executive Dashboard (Power BI)
An interactive dashboard built for **non-technical stakeholders**, featuring:

- High-level KPIs:
  - Number of customers
  - Average purchase amount
  - Average review rating
- Customer subscription distribution
- Revenue & sales by:
  - Product category
  - Age group
- Advanced slicers:
  - Gender
  - Subscription status
  - Category
  - Shipping type

The dashboard is designed for **self-service exploration**, not static reporting. <br> <br>
<img src="https://github.com/Rishi3218/Portfolio-Data_Analytics_Projects-/blob/main/Project%202%20-%20Customer%20Behavior%20Dashboard/Dashboard.png" width="800">

---

## 🧠 Key Insights
- Subscribers generate **higher total revenue**, even with similar average spend
- Loyal customers dominate the customer base — strong retention opportunity
- Certain products rely heavily on discounts, signaling **margin risk**
- Younger and middle-aged customers drive the majority of revenue
- Express shipping users show higher average purchase values

---

## 📌 Business Recommendations
- **Strengthen subscription programs** with exclusive benefits
- Introduce **tiered loyalty rewards** to convert returning users into loyal customers
- Rebalance discount strategies to protect margins
- Prioritize marketing on **high-revenue age segments**
- Promote top-rated products to reinforce trust and conversion

These recommendations are **data-backed**, not assumptions.

---

## 🛠 Tools & Skills Demonstrated
- Python (pandas, EDA, data cleaning)
- PostgreSQL (analytical SQL, segmentation logic)
- Power BI (data modeling, DAX, dashboard design)
- Business analytics & stakeholder thinking
- End-to-end BI workflow execution

---

This project reflects **professional analytical discipline**, not academic exercises.

---

## 📬 Contact
If you're seeking a data analyst who blends **technical skill with business clarity**, this project reflects how I approach problems.
<rishisharma3218@gmail.com>

---

**Data tells stories.  
This project turns those stories into strategy.**
