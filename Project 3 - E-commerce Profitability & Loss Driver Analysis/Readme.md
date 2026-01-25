# E-commerce Profitability & Loss Driver Analysis
### Diagnosing Margin Erosion and Identifying Actionable Business Levers

--- 

## 📌 Project Overview

Revenue growth does not guarantee profitability.

This Project analyzes an e-commerce business experiencing **persistent profit decline despite stable or growing revenue**.

The analysis focus on **profitability**, and is designed to mirror decision-making scenarios faced by e-commerce leadership teams.

---

## Business Problem

The business faced the following challenges :

- Revenue trends appeared healthy, yet overall profit continued to decline
- Leadership lacked visibility into **which orders, products, or behaviors were structurally unprofitable**
- Aggregate dashboards masked loss drivers instead of exposing them
- No clear framework existed to distinguish **temporary losses** from *systematic margin erosion*

Without analysis, the business risked **scaling losses along with profit**

---

## 🎯 Why This Project Matters

In e-commerce, profit leakage often hides beneath high-level KPIs.

Decisions based solely on revenue, GMV, or average margins can create **false confidence** leading to :<br>

- Aggressive discounting that destroys contribution margin
- Expansion of unprofitable product lines
- Growth strategies that amplify losses instead of returns

This project demonstrates how **order-level profitability analysis** can prevent those failures and guide smart commercial decisions.

---

## 📊Dataset & Grain

- **Data grain:** Order-item level
(Each row represents one product within one customer order)
- **Why this Grain matters:** Enables accurate calculation of margin, discount impact, cost allocation, and loss drivers.

- **Dataset type:** Synthetic dataset designed to replicate real e-commerce complexity.

- **Key fields include:** Order details, product attributes, pricing, cost, discounts, and derived margin metrics.

This level of granularity is essential for **trustworthy profitability analysis**.

---

## 🔍 Analytical Workflow

This project followed a structured, production-style workflow:

1. **Data ingestion and cleaning** using Python (Pandas)
2. **Data validation and integrity checks** using SQL (PostgreSQL)
3. **Exploratory Data Analysis (EDA)** to surface patterns and anomalies
4. **KPI definiton and reconciliation** to ensure metric accuracy
5. **Loss driver segmentation** by pricing, cost, category, and order behavior
6. **Dashboard development** for stakeholder consumption
7. **Business recommendation Development** grounded in quantified insights

Each step was designed to reduce risk and increase confidence in conclusions.

---

## 🧹Data Ingestiong and Cleaning

- Data Ingestion <br><br> <img src="https://github.com/Rishi3218/Portfolio-Data_Analytics_Projects-/blob/main/Project%203%20-%20E-commerce%20Profitability%20%26%20Loss%20Driver%20Analysis/Images/Data%20ingestion.png" width="600">

- Checking Duplicates <br><br> <img src="https://github.com/Rishi3218/Portfolio-Data_Analytics_Projects-/blob/main/Project%203%20-%20E-commerce%20Profitability%20%26%20Loss%20Driver%20Analysis/Images/Checking%20duplicates.png" width="600">

## ✅ Data Validation & Integrity Checks

To ensure analytical accuracy, multiple validation checks were performed:

- Duplicate record checks
- Null and missing value analysis
- Zero and negative quantity validation
- Revenue vs cost reconciliation
- Margin sanity checks at order and item levels
- Cross-Validation between Python and SQL outputs

Only **Validated and reconciled data** was used for final insights and dashboard.

---

## 📈 Key Insights

The analysis revealed several critical findings:

- **Pricing and cost-related drivers account for approximately $33M in total losses**, far exceeding other loss drivers.
- Loss concentration varies significantly by product category
- A structural 30% of orders Operate at low margins.
- Overall margin trend is stuck between 42-44 %.
- Negative correlation between discounting and profitability.

These insights shifted the narrative from "cost-control" to **pricing and margin discipline**.

---

## 💡Business Recommendations

Based on the findings, the following actions are recommended:

- Introduce **Discount Guardrails** to Protect Margins
- Prioritize Pricing and Cost Review to Address Major Loss Drivers
- Address Structural Low-Margin Orders 
- Apply category-Specific Profitability Startegies


---

## 📊 Dashboards and Reporting

The project includes interactive dashboards designed for different stakeholders needs:

- **Executive Overview Dashboard**<br>
High-Level KPIs: Revenue, profit, margin trends

- **Risk Monitoring Dashboard**<br>
Early warning signals for margin erosion and loss drivers

- **Loss Control Dashboard**<br>
Product, category, and driver-level loss analysis

Dashboards were built with decision-making speed and clarity in mind.

---

## 🔨Tech Stack

- **Excel** (initial data familiarization, quick explorations, sanity checks, and early issue detection)
- **Python** (Pandas, NumPy, Matplotlib) for data cleaning, EDA, and analysis
- **SQL** (data validation, reconciliation, KPI calculation)
- **Power BI** (interactive dashboards and stakeholder reporting)
- **Jupyter Notebook** (analysis documentation)
- **GitHub** (version control and project communication)


---

## ⭐ What Makes This Project Stand Out

- Strong focus on **profitability over vanity metrics**
- Emphasis on **data validation and trust**
- Business-first analytical framing
- End-to-end ownership from raw data to recommendations
- Insights designed to **drive real decisions**, not just visuals

## 📌 Final Note

This project reflects how data analysts operate in real business environments:
- Diagnosing problems
- Validating data
- Quantifying impact
- Supporting decisions with evidence

It is designed to showcase **analytical rigor, business thinking, and practical execution**.
