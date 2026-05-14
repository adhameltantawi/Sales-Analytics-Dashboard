# 🧠 Analytical Methodology & Thought Process

> **Document Type:** Analyst Workflow Journal  
> **Project:** AdventureWorks Internet Sales — Business Intelligence Engagement  
> **Analyst:** Adham | Data Analyst  
> **Philosophy:** Every decision is deliberate. Every query is intentional. Every visual serves the business.

---

## Overview

This document captures the precise analytical thinking behind each phase of the project. It is not merely a list of actions — it is a window into the professional discipline and structured reasoning that separates a data analyst who produces outputs from one who delivers business outcomes.

The workflow follows five distinct phases: **Understand → Define → Prepare → Model → Deliver.**

---

## Phase 1 — Understanding the Business Request

### 1.1 Reading the Stakeholder Communication

The engagement began with a careful reading of the original business request email from Ahmed, the Sales Manager. Before touching a single tool, the first and most critical task of any analyst is to understand what the business actually needs — not just what it says it wants.

The raw communication was reviewed in full (`Business Request.pdf`). Rather than immediately jumping to execution, the analyst paused to identify the signal within the noise — extracting the phrases that carry analytical weight from those that are conversational filler.

**The discipline here:** Most analysts read a stakeholder email and open SQL Server Management Studio within minutes. A senior analyst reads it twice, asks what is not being said, and only then picks up a tool.

### 1.2 Annotating Key Requirements

The business request was annotated with deliberate highlights, surfacing the following analytically significant terms:

| Highlighted Term | Analytical Interpretation |
|-----------------|--------------------------|
| `internet sales reports` | The subject domain — scoped to the Internet Sales channel only |
| `visual dashboards` | Output format — interactive, not static; Power BI is the correct tool |
| `sold of what products` | Dimension requirement — Product dimension needed |
| `which clients` | Dimension requirement — Customer dimension needed |
| `it has been over time` | Time-series analysis — Calendar/Date dimension needed |
| `sales person` | Filtering requirement — data must be filterable at the individual rep level |
| `filter them also` | Confirms need for interactive slicers in the dashboard |
| `budget` | Benchmark requirement — actuals must be compared against a financial target |
| `spreadsheet` | Budget will arrive as an Excel file — a separate data source to integrate |
| `2 years back` | Time scope — analysis window covers the current year plus the prior two years |

This annotation exercise (`Business Request after highlights.pdf`) is not administrative paperwork. It is the foundation of the entire downstream data model. Every dimension table, every measure, every slicer in the final dashboard can be traced back to one of these highlighted terms.

---

## Phase 2 — Defining the Deliverable Formally

### 2.1 Structuring the Business Demand Overview

With the requirements extracted, the analyst translated the informal stakeholder conversation into a formal **Business Demand Overview (BDO)** document. This artifact serves two critical functions: it aligns expectations with the stakeholder before any technical work begins, and it provides a reference specification that governs all subsequent decisions.

**Business Demand Overview — Key Fields:**

- **Reporter:** Ahmed – Sales Manager
- **Value of Change:** Transition from static reports to visual, interactive dashboards; improved sales force follow-up capability
- **Necessary Systems:** Power BI (visualization), CRM System (customer data), SQL Server (data warehouse)
- **Other Relevant Info:** Budget data delivered in Excel format, scoped to 2021

### 2.2 Writing User Stories

The analyst authored four user stories structured in the standard agile format — *"As a [role], I want [demand], so that I [value]"* — each paired with a concrete, testable acceptance criterion.

**Why user stories?**  
User stories prevent scope creep and ensure the technical solution remains anchored to human needs rather than technical capability. They also establish the criteria by which the finished dashboard will be evaluated — making success measurable, not subjective.

| Story | Role | The "So That" — The Real Value |
|-------|------|-------------------------------|
| 1 | Sales Manager | Know which customers and products are actually driving revenue |
| 2 | Sales Representative | Personal accountability — filter to my own book of business |
| 3 | Sales Representative | Product-level insight — know what to push and what is declining |
| 4 | Sales Manager | Financial governance — track actuals vs. the plan that was approved |

---

## Phase 3 — Preparing the Data Environment

### 3.1 Restoring the Databases

Both `AdventureWorksDW2019.bak` and `AdventureWorksLT2019.bak` were restored to SQL Server. The primary analytical database is `AdventureWorksDW2019` — a pre-built data warehouse structured as a star schema, providing dimensional and fact tables purpose-built for business intelligence workloads.

**Why restore, not attach?**  
Backup restoration is the professional-grade approach for environment setup. It ensures a clean, consistent starting state and avoids the file-permission complications associated with direct database attachment. It also mirrors real-world enterprise database deployment practices.

### 3.2 Executing the Date Normalization Stored Procedure

The `AdventureWorksUpdate` stored procedure (`SQLQuery1.sql`) was executed immediately after restoration. This procedure performs a critical but often overlooked operation: it calculates the number of weeks between the dataset's most recent order date and today's date, then shifts all date values across every relevant table by that offset.

**Why is this step non-negotiable?**  
The AdventureWorks dataset was originally populated with historical dates. Without normalization, the dashboard would reflect a time period years in the past, making the "2 years back" analysis window meaningless. The stored procedure ensures the data always appears current relative to today's date — a prerequisite for any time-intelligence calculation in Power BI.

The procedure also manages foreign key constraints with precision: constraints are dropped before bulk date updates and restored afterwards, preventing constraint violation errors while maintaining referential integrity across the schema. A temporary log table (`TempCheckTable`) records before-and-after values for every modified date column, providing an audit trail of the transformation.

### 3.3 Verifying the Date Range

Before writing any production queries, the full `DimDate` table was queried to verify the date normalization succeeded and to inspect the actual range of calendar years present in the dataset:

```sql
SELECT TOP (1000) [DateKey], [FullDateAlternateKey], [CalendarYear], ...
FROM [AdventureWorksDW2019].[dbo].[DimDate]
```

**Why verify before proceeding?**  
Proceeding to write dimensional queries against an unverified date range is a common mistake that leads to silent data quality issues downstream. Confirming the year distribution at this stage ensures the subsequent `WHERE CalendarYear >= 2019` filter will capture the intended analysis window.

---

## Phase 4 — Engineering the Data Model

### 4.1 DIM Calendar — Date Intelligence Layer

**File:** `DIM-Calendar-v2.sql` → `DIM-Calendar-v2.csv`

The calendar dimension was built through a deliberate, iterative process — not written once and submitted.

**Iteration 1:** The full table was queried as-is to understand the available columns and assess which attributes were analytically relevant.

**Iteration 2:** Unnecessary columns were commented out. Spanish and French language variants, fiscal calendar fields, and internal numeric keys irrelevant to the dashboard were suppressed. The analyst renamed columns to business-friendly aliases: `FullDateAlternateKey → Date`, `EnglishDayNameOfWeek → Day`, `EnglishMonthName → Month`, `CalendarYear → Year`.

A derived column was added: `LEFT([EnglishMonthName], 3) AS MonthShort` — providing a compact three-character month abbreviation essential for chart axis labels in Power BI where space is constrained.

**Iteration 3:** The query was reformatted for professional readability — consistent indentation, logical column grouping, and clear commenting conventions.

**Iteration 4:** The `WHERE CalendarYear >= 2019` filter was added. This single line enforces the business requirement for a two-year analysis window and prevents the Power BI model from loading years of irrelevant historical data.

**Design decision — why not filter in Power BI instead?**  
Filtering at the SQL layer reduces the volume of data transferred to Power BI, reduces model memory consumption, and makes the intent explicit and auditable at the data source level — rather than buried in a Power Query step that a future analyst might inadvertently remove.

---

### 4.2 DIM Customers — Enriched Customer Dimension

**File:** `DM_customers.sql` → `DM_customers.csv`

The customer dimension required enrichment beyond the base `DimCustomer` table. The analyst identified that city-level geographic information — critical for the stakeholder's desire to understand "which clients" — resided in a separate `DimGeography` table linked via `GeographyKey`.

**Key engineering decisions:**

**Name concatenation:** `c.FirstName + ' ' + c.LastName AS [Full Name]` — a derived column that reduces the burden on Power BI DAX measures and provides a ready-to-use display field for customer labels in visuals.

**Gender decoding:** A `CASE` statement transforms single-character codes (`M`, `F`) into human-readable labels (`Male`, `Female`, `Unknown`). This transformation at the SQL layer is intentional — it means the Power BI data model receives clean, display-ready values rather than requiring DAX logic to interpret coded fields.

**LEFT JOIN to geography:** Using a `LEFT JOIN` rather than an `INNER JOIN` ensures every customer record is preserved, even if a geography key is missing or unmatched. Silent row exclusion from a customer dimension would cause incorrect customer counts in the final dashboard — an error that would be invisible without careful validation.

**Column suppression:** Numerous columns available in `DimCustomer` — including email, income, education, occupation, phone, and address — were intentionally excluded via comments. These fields are either irrelevant to the sales reporting use case or contain personally identifiable information that should not be surfaced in a shared dashboard environment.

---

### 4.3 DIM Products — Full Product Hierarchy

**File:** `DM_Products.sql` → `DM_Products.csv`

The product dimension required resolving a three-level hierarchy: Product → Subcategory → Category. This hierarchy is stored across three separate tables in the data warehouse (`DimProduct`, `DimProductSubcategory`, `DimProductCategory`) and must be joined explicitly.

**Key engineering decisions:**

**Chained LEFT JOINs:** Two sequential LEFT JOINs resolve the complete hierarchy. The first join connects `DimProduct` to `DimProductSubcategory` via `ProductSubcategoryKey`. The second connects to `DimProductCategory` via `ProductCategoryKey` from the subcategory table. This pattern is a foundational technique in dimensional modeling and must be executed in the correct sequence to avoid Cartesian products.

**`ISNULL` for product status:** `ISNULL(p.Status, 'Outdated') AS [Product Status]` — null values in the status column represent products that have been discontinued without a formal status code. Rather than allowing nulls to appear as blank values in Power BI slicers (which creates a confusing "(Blank)" option for users), the analyst substitutes the contextually accurate label `'Outdated'`. This is data stewardship, not just coding.

**Product description inclusion:** The `EnglishDescription` field was retained to enable tooltip or drill-through functionality in Power BI — providing product context directly within the dashboard without requiring users to consult an external catalog.

---

### 4.4 FACT Internet Sales — Core Transactional Grain

**File:** `FACT_InternetSales.sql` → `FACT_InternetSales.csv`

The fact table is the analytical heart of the model. It was extracted with precision — retaining only the keys necessary to join to all three dimensions and the single measure (`SalesAmount`) that drives the dashboard KPIs.

**Key engineering decisions:**

**Minimal column projection:** Of the many columns available in `FactInternetSales`, only those with direct analytical utility were selected: the three date keys (`OrderDateKey`, `DueDateKey`, `ShipDateKey`), the two dimension keys (`ProductKey`, `CustomerKey`), the order identifier (`SalesOrderNumber`), and the measure (`SalesAmount`). Every commented-out column represents a deliberate exclusion — not an oversight.

**Three date keys retained:** All three date keys were preserved, giving Power BI the flexibility to analyze sales by order date (when the sale was made), due date (when payment was expected), and ship date (when the product was dispatched). This supports more nuanced operational analyses beyond simple order volume.

**`ORDER BY OrderDateKey ASC`:** Sorting the fact table chronologically at the SQL layer is a best practice that improves readability during validation and can marginally improve compression in columnar storage formats.

---

## Phase 5 — Dashboard Delivery

### 5.1 Loading Data into Power BI

The four exported CSV files were imported into Power BI Desktop alongside the Excel budget file. Relationships were established between the fact table and each dimension using the shared key columns, replicating the star schema from the data warehouse within the Power BI semantic model.

The Excel budget file was integrated as a separate table and connected to the date dimension, enabling budget-vs-actual comparisons across any time granularity available in the calendar dimension.

### 5.2 Dashboard Design Principles

The dashboard was designed around the four user stories defined in Phase 2, ensuring every visual element has a direct traceability to a stated business requirement. Visuals without a corresponding user story were not included — dashboard real estate is finite and every element must earn its place.

**Sales Manager view (Stories 1 & 4):** High-level KPI cards showing total sales vs. budget, supported by a trend line enabling period-over-period comparison.

**Sales Representative view (Stories 2 & 3):** Detailed breakdown tables and charts filterable by customer and by product, enabling each representative to focus exclusively on their own domain.

**Shared filtering capability:** Slicers for sales representative, product category, and time period are available across the report, fulfilling the explicit requirement that data be filterable at the individual level.

---

## Summary of Analytical Principles Applied

| Principle | Application in This Project |
|-----------|----------------------------|
| **Requirements first, tools second** | BDO and user stories were completed before any SQL was written |
| **Trace every decision to the business** | Each column inclusion or exclusion maps to a specific user story |
| **Transform at the source** | Gender decoding, name concatenation, and status labeling done in SQL — not in DAX |
| **Preserve referential integrity** | LEFT JOINs used throughout to prevent silent row exclusion |
| **Validate before proceeding** | Date range verification performed before dimensional queries were written |
| **Iterate deliberately** | Calendar query evolved through four documented iterations — not written once |
| **Document everything** | Every SQL file includes comments explaining intent, not just syntax |

---

*A great data analyst does not simply answer the question that was asked. They understand why the question was asked, verify that answering it will deliver the intended value, and then engineer the most robust, maintainable path to that answer.*
