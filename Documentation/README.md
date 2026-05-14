# 📊 AdventureWorks Internet Sales Analytics — End-to-End Business Intelligence Project

> **Analyst:** Adham | Data Analyst  
> **Stakeholder:** Ahmed — Sales Manager  
> **Delivery:** Interactive Power BI Sales Dashboard  
> **Data Source:** Microsoft AdventureWorks DW 2019  
> **Analysis Window:** 2019 – 2021 (2-Year Rolling + Budget Comparison)

---

## 🔗 Quick Navigation

| Document | Description | Link |
|----------|-------------|------|
| 📋 Analytical Methodology | Step-by-step breakdown of the analyst's thought process, decisions, and SQL iteration logic | [📖 View steps.md](./steps.md) |
| 📊 Sales Overview Dashboard | Interactive Power BI dashboard file | [📈 Open Dashboard](./Sales%20Overview%20Dashboard.pbix) |
| 🎨 Project Presentation | Executive presentation slides summarizing the full engagement | [🖥️ View Presentation](./Sales%20Overview%20Presentation.pptx) |

---

## 🧭 Project Overview

This project represents a full-cycle, enterprise-grade Business Intelligence engagement — from raw stakeholder communication through to a fully interactive Power BI dashboard. It was initiated in direct response to a formal business request from the Sales Manager, who identified a critical gap between the organization's existing static reporting infrastructure and the dynamic, filterable visual intelligence required by the modern sales force.

The analyst translated an informal business conversation into a structured demand overview, engineered the underlying data model in SQL Server against the AdventureWorks Data Warehouse, authored a suite of precision SQL queries to extract and cleanse dimensional and fact data, and delivered a polished Power BI dashboard enabling performance tracking across products, customers, and time — benchmarked against the 2021 sales budget.

---

## 🗂️ Repository Structure

```
📁 NovaMart-Sales-Analytics/
│
├── Data/
│   ├── DIM-Calendar-v2.csv
│   ├── DM_Products.csv
│   ├── DM_customers.csv
│   └── FACT_InternetSales.csv
│
├── SQL/
│   ├── DIM-Calendar-v2.sql
│   ├── DM_Products.sql
│   ├── DM_customers.sql
│   ├── FACT_InternetSales.sql
│   └── SQLQuery1.sql
│
├── Database/
│   ├── AdventureWorksDW2019.bak
│   └── AdventureWorksLT2019.bak
│
├── Documentation/
│   ├── Business Demand Overview.pdf
│   ├── Business Request after highlights.pdf
│   └── README.md
│
├── Dashboard/
│   └── Sales Overview Dashboard.pbix
│
└── Images/
    ├── dashboard-preview.png
    └── dashboard-filters.png
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

## 📈 Sales Overview Dashboard

The delivered Power BI dashboard is a fully interactive, multi-dimensional analytical report designed to serve both executive oversight and individual sales representative accountability. Every visual element traces directly to one of the four formally defined user stories.

> **📷 Dashboard Screenshot — Full Overview**
> 
> ![Sales Overview Dashboard — Full View](./screenshots/dashboard-overview.png)
> *← Replace this placeholder with your exported dashboard screenshot*

---

### 🕐 1. Top Section — Time Intelligence Filters

Two primary time filters are positioned prominently at the top of the dashboard, enabling instant scoping of all downstream visuals to a specific period.

**Year Filter** — A horizontal selector spanning the full analysis window: `2019 · 2020 · 2021`

**Month Filter** — A full twelve-month selector from `Jan` through `Dec`, enabling month-level drill-down without losing year context.

> **📷 Screenshot — Time Filter Bar**
> 
> ![Time Filters](./screenshots/filter-time.png)

---

### 🔽 2. Left Sidebar — Dimensional Slicers

An interactive slicer panel on the left side of the report canvas provides granular filtering across four dimensions, allowing each user to personalize the dashboard view to their specific analytical scope.

| Slicer | Source Dimension | Purpose |
|--------|-----------------|---------|
| **Customer City** | `DIM_Customers` → `Customer City` | Filter by customer geographic location |
| **Sub Category** | `DIM_Products` → `Sub Category` | Filter by product subcategory |
| **Category** | `DIM_Products` → `Product Category` | Filter by top-level product category |
| **Product Name** | `DIM_Products` → `Product Name` | Filter to a specific product |

> **📷 Screenshot — Left Sidebar Slicers**
> 
> ![Dimensional Slicers](./screenshots/filter-sidebar.png)

---

### 📊 3. Main KPI Card — Sales vs. Budget

The headline KPI card is positioned at the top center of the dashboard and provides the single most important business metric at a glance.

It surfaces three values simultaneously:
- **Total Sales** — Actual realized revenue for the selected period
- **Budget** — The planned financial target for the same period
- **Variance** — The absolute and directional difference between actuals and plan

An upward indicator confirms that actual sales have exceeded the budgeted target, giving the Sales Manager an immediate performance signal without needing to interrogate any chart.

> **📷 Screenshot — KPI Card**
> 
> ![Sales vs Budget KPI](./screenshots/kpi-card.png)

---

### 👥 4. Top 10 Customers Analysis

**Visual Type:** Horizontal Bar Chart

This chart ranks the ten highest-revenue-generating customers, displaying customer names alongside their corresponding sales amounts in descending order.

**Business Value:** Enables the Sales Manager to instantly identify which client relationships are driving the most revenue — directly supporting user story #1 (dashboard overview) and user story #2 (customer-level detail for representatives).

> **📷 Screenshot — Top 10 Customers Chart**
> 
> ![Top 10 Customers](./screenshots/chart-top-customers.png)

---

### 📦 5. Top 10 Products Analysis

**Visual Type:** Horizontal Bar Chart

This chart surfaces the ten best-performing products by sales value, providing product names and their respective revenue contributions.

**Business Value:** Satisfies user story #3 — giving sales representatives a clear view of which products to prioritize and which may require attention.

> **📷 Screenshot — Top 10 Products Chart**
> 
> ![Top 10 Products](./screenshots/chart-top-products.png)

---

### 🍩 6. Product Category Distribution

**Visual Type:** Doughnut Chart

This chart visualizes the proportional revenue contribution of each product category (e.g., Bikes, Accessories), displaying both the absolute sales amount and the percentage share of total revenue.

**Business Value:** Provides strategic context — revealing which categories form the revenue backbone of the business versus which represent growth opportunities or underperformers.

> **📷 Screenshot — Category Distribution Chart**
> 
> ![Product Category Distribution](./screenshots/chart-category-donut.png)

---

### 📅 7. Monthly Sales vs. Budget Trend

**Visual Type:** Line Chart (Dual Series)

This chart plots two series across all twelve calendar months — actual monthly sales and the corresponding monthly budget target — enabling direct visual comparison between performance and plan.

**Business Value:** Satisfies user story #4 explicitly. It enables the Sales Manager to detect seasonal patterns, identify months where performance diverged significantly from target, and assess whether the trend is improving or deteriorating across the year.

> **📷 Screenshot — Monthly Trend Line Chart**
> 
> ![Monthly Sales vs Budget](./screenshots/chart-monthly-trend.png)

---

### 🗺️ 8. Geographic Sales Distribution

**Visual Type:** Map Visualization (Bubble Map)

This map plots customer locations geographically, with bubble size proportional to sales volume at each city. It provides an immediate spatial understanding of where revenue is concentrated and where market penetration may be weak.

**Business Value:** Supports territory planning, logistics prioritization, and the identification of high-performing regional markets versus underserved geographies.

> **📷 Screenshot — Geographic Sales Map**
> 
> ![Sales by Customer City Map](./screenshots/map-geographic.png)

---

### 🎯 Dashboard Objective Summary

The dashboard consolidates all analytical capabilities into a single, coherent interface that serves every user story defined in the business demand phase:

- Monitor overall sales performance against budget at a glance
- Identify the top customers and products driving revenue
- Analyze monthly performance trends and detect seasonal patterns
- Understand geographic sales distribution and regional opportunity
- Enable individual sales representative filtering for personal accountability
- Support strategic, data-driven decision-making at every organizational level

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

## 📎 Related Resources

| Resource | Link |
|----------|------|
| 📖 Analytical Methodology (Step-by-Step) | [steps.md](./steps.md) |
| 🖥️ Executive Presentation | [Sales Overview Presentation.pptx](./Sales%20Overview%20Presentation.pptx) |
| 📈 Power BI Dashboard File | [Sales Overview Dashboard.pbix](./Sales%20Overview%20Dashboard.pbix) |

---

*This project was built following industry-standard BI development practices: beginning with a structured business demand overview, proceeding through disciplined SQL data preparation, and delivering a stakeholder-ready interactive dashboard.*
