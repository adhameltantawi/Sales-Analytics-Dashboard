# 📊 AdventureWorks Internet Sales Analytics — End-to-End Business Intelligence Project

> **Analyst:** Adham | Data Analyst  
> **Stakeholder:** Ahmed — Sales Manager  
> **Delivery:** Interactive Power BI Sales Dashboard  
> **Data Source:** Microsoft AdventureWorks DW 2019  
> **Analysis Window:** 2019 – 2021 (2-Year Rolling + Budget Comparison)

---

## 🧭 Project Overview

This project represents a full-cycle, enterprise-grade Business Intelligence engagement — from raw stakeholder communication through to a fully interactive Power BI dashboard. It was initiated in direct response to a formal business request from the Sales Manager, who identified a critical gap between the organization's existing static reporting infrastructure and the dynamic, filterable visual intelligence required by the modern sales force.

The analyst translated an informal business conversation into a structured demand overview, engineered the underlying data model in SQL Server against the AdventureWorks Data Warehouse, authored a suite of precision SQL queries to extract and cleanse dimensional and fact data, and delivered a polished Power BI dashboard enabling performance tracking across products, customers, and time — benchmarked against the 2021 sales budget.

---

## 🗂️ Repository Structure

```
📁 AdventureWorks-Internet-Sales-Analytics/
│
├── 📄 README.md                          ← Project overview, structure & documentation (this file)
├── 📄 steps.md                           ← Analyst's documented thought process & methodology
│
├── 💾 AdventureWorksDW2019.bak           ← Primary Data Warehouse backup (SQL Server restore)
├── 💾 AdventureWorksLT2019.bak           ← Lightweight transactional DB backup (supplementary)
│
├── 📑 Business Request after highlights.pdf   ← Annotated stakeholder email with key requirements highlighted
├── 📑 Business Demand Overview.pdf            ← Structured BDO document with user stories
│
├── 🗄️ SQLQuery1.sql                      ← AdventureWorksUpdate stored procedure (date normalization)
│
├── 🗄️ DIM-Calendar-v2.sql               ← Cleansed Date Dimension query
├── 📊 DIM-Calendar-v2.csv               ← Exported Calendar dimension dataset
│
├── 🗄️ DM_customers.sql                  ← Cleansed Customer Dimension query
├── 📊 DM_customers.csv                  ← Exported Customer dimension dataset
│
├── 🗄️ DM_Products.sql                   ← Cleansed Product Dimension query (with Sub/Category joins)
├── 📊 DM_Products.csv                   ← Exported Product dimension dataset
│
├── 🗄️ FACT_InternetSales.sql            ← Cleansed Internet Sales Fact Table query
├── 📊 FACT_InternetSales.csv            ← Exported Internet Sales fact dataset
│
└── 📈 Sales Overview Dashboard.pbix     ← Final Power BI interactive dashboard
```

---

## 🎯 Business Objectives

The project was scoped around four formally defined user stories, each mapped to a measurable acceptance criterion:

| # | Role | Requirement | Business Value | Acceptance Criterion |
|---|------|-------------|----------------|----------------------|
| 1 | Sales Manager | Dashboard overview of Internet Sales | Identify best-performing customers and products | Power BI dashboard refreshed daily |
| 2 | Sales Representative | Detailed Internet Sales view per Customer | Monitor high-value customers and identify upsell opportunities | Dashboard with customer-level filtering |
| 3 | Sales Representative | Detailed Internet Sales view per Product | Track top-performing products | Dashboard with product-level filtering |
| 4 | Sales Manager | Sales performance over time vs. budget | Measure actuals against financial targets | Dashboard with KPIs and budget comparison graphs |

---

## 🛠️ Technology Stack

| Layer | Technology |
|-------|------------|
| Data Warehouse | Microsoft SQL Server + AdventureWorks DW 2019 |
| Query Language | T-SQL (Transact-SQL) |
| Data Modeling | Star Schema (Fact + Dimensions) |
| BI & Visualization | Microsoft Power BI Desktop |
| Budget Integration | Microsoft Excel (2021 Sales Budget) |
| Version Control | Git / GitHub |

---

## 🗃️ Data Model

The analytical model follows a **Star Schema** architecture, with one central fact table and three supporting dimension tables:

```
          DIM_Calendar
               │
               │ (DateKey)
               │
DIM_Customers ─┼─ FACT_InternetSales ─┬─ DIM_Products
               │                       │
               └───────────────────────┘
                    + Excel Budget Table (imported in Power BI)
```

### Fact Table
**`FACT_InternetSales`** — Core transactional grain containing one row per sales order line, with keys linking to all three dimensions and the `SalesAmount` measure used as the primary KPI.

### Dimension Tables

**`DIM_Calendar`** — Date intelligence dimension with full calendar attributes (Day, Week, Month, Quarter, Year), filtered to the relevant 2-year analysis window (≥ 2019).

**`DIM_Customers`** — Enriched customer dimension combining customer demographics with geographic city data via a LEFT JOIN to `DimGeography`. Gender values are decoded from coded flags to human-readable labels.

**`DIM_Products`** — Fully resolved product dimension joining `DimProduct` with `DimProductSubcategory` and `DimProductCategory` to expose the complete product hierarchy. Null status values are handled gracefully and labeled as `'Outdated'`.

---

## ⚙️ Setup & Reproduction Instructions

### Prerequisites
- Microsoft SQL Server 2019 or later
- SQL Server Management Studio (SSMS)
- Microsoft Power BI Desktop
- Minimum 8 GB RAM recommended for database restoration

### Step 1 — Restore Databases
Restore both `.bak` files into SQL Server:
```sql
-- Restore AdventureWorksDW2019
RESTORE DATABASE [AdventureWorksDW2019]
FROM DISK = 'path\to\AdventureWorksDW2019.bak'
WITH REPLACE, RECOVERY;

-- Restore AdventureWorksLT2019
RESTORE DATABASE [AdventureWorksLT2019]
FROM DISK = 'path\to\AdventureWorksLT2019.bak'
WITH REPLACE, RECOVERY;
```

### Step 2 — Normalize Dates
Execute `SQLQuery1.sql` against `AdventureWorksDW2019` to run the `AdventureWorksUpdate` stored procedure. This procedure shifts all date values across fact and dimension tables to align the dataset with the current reporting window, ensuring the dashboard reflects up-to-date time intelligence.

### Step 3 — Execute Dimension & Fact Queries
Run the following scripts in sequence and export each result set as the corresponding `.csv` file:

```
DIM-Calendar-v2.sql     →  DIM-Calendar-v2.csv
DM_customers.sql        →  DM_customers.csv
DM_Products.sql         →  DM_Products.csv
FACT_InternetSales.sql  →  FACT_InternetSales.csv
```

### Step 4 — Load Power BI Dashboard
Open `Sales Overview Dashboard.pbix` in Power BI Desktop. Connect or refresh data sources pointing to the exported CSV files and the Excel budget file. All relationships, measures, and visuals are pre-configured.

---

## 📈 Dashboard Capabilities

The delivered Power BI dashboard provides the following analytical capabilities:

- **Sales vs. Budget KPIs** — At-a-glance comparison of actual sales revenue against the 2021 budget target
- **Product Performance Analysis** — Ranked view of top-selling products by revenue, filterable by category and subcategory
- **Customer Intelligence** — Identification of highest-value customers with geographic drill-down to city level
- **Time-Series Trending** — Monthly, quarterly, and annual sales trends across the full two-year analysis window
- **Sales Representative Filtering** — Individual rep-level filtering enabling personalized performance tracking
- **Interactive Cross-Filtering** — All visuals respond dynamically to selections across the report canvas

---

## 📋 SQL Artifacts Summary

| File | Purpose | Key Technique |
|------|---------|---------------|
| `SQLQuery1.sql` | Date normalization stored procedure | Dynamic `DATEADD` with week offset calculation; constraint management |
| `DIM-Calendar-v2.sql` | Date dimension extraction | Column aliasing, `LEFT()` for abbreviated month names, `WHERE CalendarYear >= 2019` |
| `DM_customers.sql` | Customer dimension with geography | `LEFT JOIN` to `DimGeography`; `CASE` statement for gender decoding; name concatenation |
| `DM_Products.sql` | Product dimension with full hierarchy | Chained `LEFT JOIN` to subcategory and category tables; `ISNULL()` for status handling |
| `FACT_InternetSales.sql` | Internet sales fact extraction | Selective column projection; ordered by `OrderDateKey ASC` |

---

## 📌 Key Analytical Decisions

**Why LEFT JOINs over INNER JOINs on dimensions?**  
Preserving all records from the primary dimension tables — even those without matching subcategory or geography keys — ensures no data is silently excluded from the model. Silent row loss in a star schema can distort aggregated KPIs and mislead business decisions.

**Why was gender decoded via a CASE statement?**  
Single-character gender codes (`M`, `F`) are opaque to end-users in Power BI visuals. Transforming them at the SQL layer — rather than in DAX — reduces complexity in the semantic model and improves report maintainability.

**Why filter `CalendarYear >= 2019` in the Calendar dimension?**  
The business requirement explicitly specifies a two-year lookback. Restricting the calendar at the source reduces model size, improves refresh performance, and prevents end-users from accidentally navigating to data outside the defined analytical scope.

**Why use `ISNULL(p.Status, 'Outdated')` on products?**  
Null values in product status create ambiguity in Power BI slicers and visuals. Substituting a meaningful label ensures the dashboard remains interpretable for non-technical stakeholders without requiring additional DAX handling.

---

## 👤 Analyst

**Adham** — Data Analyst  
End-to-end BI delivery across requirements gathering, data engineering, dimensional modeling, SQL development, and Power BI dashboard design.

---

*This project was built following industry-standard BI development practices: beginning with a structured business demand overview, proceeding through disciplined SQL data preparation, and delivering a stakeholder-ready interactive dashboard.*
