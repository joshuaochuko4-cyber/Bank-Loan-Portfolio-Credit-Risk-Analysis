# Bank-Loan-Portfolio-Credit-Risk-Analysis
# Bank Loan Portfolio & Credit Risk Analysis

## 📊 Project Overview

This project analyzes the **Home Credit Default Risk dataset** to understand loan portfolio performance, credit exposure, and observed repayment difficulty.

The analysis follows a complete data analytics workflow:

**Data Understanding → Cleaning → SQL Analysis → Power BI → Insights → Decision Support**

The final deliverable is a **4-page Power BI dashboard** covering portfolio performance, risk segmentation, customer characteristics, and management insights.

---

## 🎯 Business Problem

Financial institutions need to understand where credit exposure is concentrated and which customer segments show higher levels of observed repayment difficulty.

This project aims to answer questions such as:

- How large is the loan portfolio?
- Where is credit exposure concentrated?
- What percentage of applications show repayment difficulty?
- How does repayment difficulty vary across income, education, housing, gender, and regional segments?
- How does loan burden relate to repayment difficulty?
- Which areas may require closer monitoring?

The goal is to transform raw loan application data into insights that can support **portfolio monitoring, risk segmentation, and management decision-making**.

---

## 📁 Data

The project uses the **Home Credit Default Risk** dataset from Kaggle.

- **307,511 loan applications**
- **122 original columns**
- Application, financial, employment, demographic, regional, and external risk-related information

Key fields include:

`TARGET`, `AMT_CREDIT`, `AMT_INCOME_TOTAL`, `AMT_ANNUITY`, `NAME_CONTRACT_TYPE`, `NAME_INCOME_TYPE`, `NAME_EDUCATION_TYPE`, `NAME_HOUSING_TYPE`, `REGION_RATING_CLIENT`, `EXT_SOURCE_2`, `EXT_SOURCE_3`, and `ORGANIZATION_TYPE`.

`TARGET` represents repayment outcome:

- `0` = No repayment difficulty observed
- `1` = Repayment difficulty observed

**Source:** [Home Credit Default Risk – Kaggle](https://www.kaggle.com/competitions/home-credit-default-risk/data)

> Monetary values are retained in the units provided by the original dataset and are not interpreted as Nigerian Naira.

---

## 🧹 Data Cleaning & Preparation

The data was cleaned and prepared before analysis, including:

- Data type validation
- Missing-value assessment
- Duplicate and ID validation
- Handling special values such as `DAYS_EMPLOYED = 365243`
- Creation of analytical fields
- Ratio calculations
- Risk-status classification
- Loan-to-income and external risk-score banding

Derived metrics included:

- **Loan-to-Income**
- **Annuity-to-Income**
- **Credit-to-Goods-Price**
- **Employment Years**
- **Risk Status**
- **Loan-to-Income Bands**
- **External Risk Score Bands**

Missing values were not blindly replaced with zero because missing and zero have different analytical meanings.

---

## 🔎 Analysis

### SQL Server

SQL Server was used to investigate portfolio and risk questions using:

- Aggregations
- `GROUP BY`
- `CASE WHEN`
- CTEs
- Subqueries
- Window functions
- `RANK()`
- Segmentation
- Exposure analysis
- Top-N analysis

### Power BI

Power BI was used to create DAX measures and an interactive dashboard containing:

**Page 1 — Executive Overview**
- Portfolio KPIs
- Applications by loan type
- Repayment difficulty by income type
- Regional risk patterns
- Credit exposure by loan type

**Page 2 — Credit Risk & Repayment Analysis**
- Repayment difficulty KPIs
- Education and housing analysis
- Loan-to-income analysis
- Gender comparison
- External risk-score analysis

**Page 3 — Portfolio & Customer Profile**
- Credit exposure
- Income and education distribution
- Organization-level exposure
- Family status
- Average credit by loan type

**Page 4 — Management Summary**
- Key portfolio findings
- Risk signals
- Exposure concentration
- Areas for management attention

---

## 📈 Key Findings

- **307,511** total applications
- **184.21B** total credit exposure
- **24,825** applications with observed repayment difficulty
- **8.07%** observed repayment difficulty rate
- **13.85B** credit exposure associated with repayment-difficulty applications
- **7.52%** of total credit exposure associated with repayment-difficulty applications
- Cash loans represent the majority of applications and credit exposure.

The analysis also identified differences in observed repayment difficulty across **income type, education, housing type, gender, region rating, loan burden, and external risk-score segments**.

Small customer segments were treated cautiously because high percentages from very small populations may not be representative.

---

## 💡 Business Value

The cleaned and analyzed data provides a structured basis for:

- Monitoring portfolio performance
- Understanding credit exposure concentration
- Identifying segments with higher observed repayment difficulty
- Comparing customer and loan characteristics
- Supporting targeted risk investigation
- Improving management reporting
- Providing a foundation for further credit-risk modeling

The project demonstrates how raw financial data can be transformed into **clear, business-focused insights rather than simply visualized**.

---

## 🛠️ Tools

**SQL Server | T-SQL | Power BI | DAX | Power Query | Excel**

---

## 🔄 Workflow

**Raw Data → Cleaning → Feature Engineering → SQL Analysis → Risk Segmentation → DAX Measures → Power BI Dashboard → Business Insights**

---

## 👤 Author

**Isah Joshua Ochuko**  
Data Analyst | SQL • Power BI • Excel • Python

📧 joshuaochuko4@gmail.com  
🔗 Portfolio: https://joshuaochuko.my.canva.site  
🐙 GitHub: https://github.com/joshuaochuko4-cyber
