# 📊 AdventureWorks Internet Sales — Dashboard Insights Report

> **Analyst:** Adham | Data Analyst
> **Stakeholder:** Ahmed — Sales Manager
> **Data Source:** Microsoft AdventureWorks DW 2019
> **Analysis Window:** 2019 – 2021 | **Dashboard Tool:** Microsoft Power BI

---

## 🧭 Executive Summary

The AdventureWorks Internet Sales dashboard reveals a business operating **above its financial targets**, driven almost entirely by a single product category and a concentrated group of high-value customers. Total internet sales reached **$22,194,469** against a budget of **$21,100,000**, yielding a **positive variance of $1,094,469 (+5.19%)**. While this headline figure is encouraging, the analysis surfaces both strategic strengths and areas of risk that demand attention.

---

## 💰 1. Overall Sales Performance vs. Budget

| Metric | Value |
|--------|-------|
| **Total Actual Sales** | $22,194,469 |
| **Budget Target** | $21,100,000 |
| **Variance (Absolute)** | +$1,094,469 |
| **Variance (%)** | +5.19% ✅ |

**Insight:** The business has outperformed its planned revenue target by over $1 million. The upward green indicator on the KPI card signals positive momentum. However, this aggregate number masks important dynamics — the budget overperformance was not uniform across all months, as the trend line analysis reveals significant in-year volatility.

**Risk Flag:** Over-reliance on aggregate KPIs without period-level decomposition can create a false sense of security. A strong year-end may be masking mid-year underperformance.

---

## 📦 2. Product Category Analysis — Critical Concentration Risk

### Revenue by Category

| Category | Sales ($) | Share (%) |
|----------|-----------|-----------|
| **Bikes** | 21,153,936 | **95.31%** |
| **Accessories** | 700,760 | **3.16%** |
| *(Clothing / Other)* | ~339,773 | ~1.53% |

**Insight:** The revenue portfolio is dangerously concentrated in a single category. **Bikes alone account for 95.31% of all internet sales revenue.** Accessories contribute just 3.16%, and all remaining categories are negligible.

**Strategic Implication:** This concentration creates significant business risk. Any disruption to the Bikes category — supply chain issues, market saturation, or competitive pressure — could catastrophically impact total revenue. The Accessories segment, despite its low share, likely carries higher margins and represents an underdeveloped growth vector.

**Recommendation:** Investigate whether Accessories and Clothing are being actively promoted, or if they are simply under-marketed. A deliberate strategy to grow these categories to 10–15% of revenue would meaningfully reduce category risk.

---

## 🏆 3. Top 10 Customers Analysis

### Top Customers by Sales ($)

| Rank | Customer | Sales ($) |
|------|----------|-----------|
| 1 | Jordan Turner | 15,999 |
| 2 | Maurice Shan | 12,910 |
| 3 | Janet Munoz | 12,489 |
| 4 | Lisa Cai | 11,469 |
| 5 | Lacey Zheng | 11,248 |
| 6 | Larry Munoz | 11,068 |
| 7 | Franklin Xu | 10,586 |
| 8 | Ariana Gray | 10,529 |
| 9 | Marco Lopez | 10,468 |
| 10 | Willie Xu | 9,912 |

**Insight:** The top 10 customers show a relatively tight value band — the range between rank 1 ($15,999) and rank 10 ($9,912) is only ~$6,000. This suggests a healthy distribution among top customers with no single extreme outlier dominating.

**Strategic Implication:** Jordan Turner leads with $15,999 — nearly 60% more than the 10th-ranked customer. This customer warrants priority retention attention. The relatively compressed range also indicates that losing any top-10 customer would have a measurable but not catastrophic impact on total revenue.

**Recommendation:** Implement a formal Key Account Management (KAM) programme targeting at minimum the top 10 customers. Track their purchasing frequency, not just total value, to detect early warning signs of churn.

---

## 🥇 4. Top 10 Products Analysis

### Top Products by Sales ($)

| Rank | Product | Sales ($) |
|------|---------|-----------|
| 1 | Mountain-2… (variant) | 1,369,371 |
| 2 | Mountain-2… (variant) | 1,361,093 |
| 3 | Mountain-2… (variant) | 1,337,391 |
| 4 | Mountain-2… (variant) | 1,299,029 |
| 5 | Mountain-2… (variant) | 1,290,768 |
| 6 | Mountain-2… (variant) | 1,255,363 |
| 7 | Road-250 Bl… | 730,038 |
| 8 | Road-250 Re… | 693,911 |
| 9 | Road-250 Bl… | 686,843 |
| 10 | Road-250 Bl… | 617,644 |

**Insight:** The top 10 products are entirely composed of two product families: **Mountain-200** (ranks 1–6) and **Road-250** (ranks 7–10). There is no diversity in product families among the top performers.

**Strategic Implication:** The Mountain-200 family collectively accounts for an enormous proportion of internet sales revenue. Its six variants together represent over $7.9M in sales. This is a flagship product line that must be protected, inventoried carefully, and supported with a structured replacement plan for when it reaches end-of-life.

**Recommendation:** Diversify the product development roadmap. Investigate why no other product family breaks into the top 10, and whether promotional efforts are disproportionately concentrated on Mountain-200 at the expense of other product lines.

---

## 📅 5. Monthly Sales vs. Budget Trend Analysis

Based on the dual-series line chart, the following patterns are observable:

**Key Observations:**
- **Early year (Jan–Feb):** Sales significantly below budget — the teal sales line sits well beneath the black budget line. February appears to be the weakest month.
- **Mid-year (Mar–Jun):** Both lines converge and align closely, suggesting the business found its rhythm and was performing on plan.
- **Summer (Jun–Aug):** Budget line shows relative stability while actual sales begin a measured climb.
- **Late year (Sep–Dec):** Actual sales accelerate sharply above budget, with December appearing to deliver the strongest month of the year — likely driven by seasonal purchasing behaviour around the holidays.

**Insight:** The business has a pronounced back-loaded sales profile. Significant early-year underperformance is offset by strong late-year outperformance. This creates cash flow risk in Q1 and excessive dependence on Q4.

**Recommendation:** Develop Q1 and Q2 promotional strategies (seasonal campaigns, early-purchase incentives, new product launches) to flatten the revenue distribution across months and reduce end-of-year dependency.

---

## 🗺️ 6. Geographic Sales Distribution

The bubble map reveals sales activity concentrated across the continental United States, with cluster density observable in:

- **West Coast** — Notable concentration in California and Pacific Northwest
- **South-Central** — Texas and surrounding states show significant activity
- **North-Central / Midwest** — Multiple mid-sized bubbles visible
- **East Coast** — Present but comparatively thinner distribution

**Insight:** Sales are geographically diverse across the US but appear more concentrated on the western half. Certain eastern and southern markets appear underrepresented relative to their population density and purchasing power.

**Recommendation:** Use the geographic slicer to overlay sales per city with budget allocation per region. Identify markets with high bubble size (strong existing performance) and markets with small or absent bubbles that may represent untapped territory for targeted outreach.

---

## ⚠️ 7. Dashboard Technical Note — Map Visual Retirement

The Power BI map visual currently displays a deprecation warning:

> *"This visual type is being retired soon. Upgrade now to avoid errors."*

**Action Required:** This is a technical debt item that requires prompt attention. The existing Bing Maps visual must be migrated to the Azure Maps visual in Power BI before Microsoft forces the retirement. Failure to act will result in the geographic visualization becoming non-functional, eliminating a key analytical component of the dashboard.

**Priority:** High — address in the next dashboard refresh cycle.

---

## 🎯 8. Strategic Recommendations Summary

| # | Area | Finding | Recommended Action | Priority |
|---|------|---------|-------------------|----------|
| 1 | Revenue Mix | 95.31% of sales from Bikes | Diversify category mix; grow Accessories | 🔴 High |
| 2 | Product Concentration | Top 10 products = 2 families only | Expand product promotion breadth | 🔴 High |
| 3 | Seasonality | Heavy Q4 dependence | Build Q1/Q2 demand-generation campaigns | 🟡 Medium |
| 4 | Customer Retention | Top 10 customers drive significant revenue | Launch Key Account Management programme | 🟡 Medium |
| 5 | Geography | Uneven US geographic distribution | Target underserved eastern/southern markets | 🟡 Medium |
| 6 | Technical — Map | Deprecated visual type warning | Migrate to Azure Maps visual | 🔴 High |
| 7 | Budget vs Actuals | +5.19% above budget overall | Validate whether budget was set conservatively | 🟢 Low |

---

## 📌 Key Metrics at a Glance

```
┌─────────────────────────────────────────────────────┐
│              ADVENTUREWORKS INTERNET SALES           │
│                    2019 – 2021                       │
├──────────────────────┬──────────────────────────────┤
│ Total Sales          │ $22,194,469                  │
│ Budget               │ $21,100,000                  │
│ Variance             │ +$1,094,469 (+5.19%) ✅      │
├──────────────────────┼──────────────────────────────┤
│ Top Category         │ Bikes (95.31%)               │
│ Top Customer         │ Jordan Turner ($15,999)       │
│ Top Product Family   │ Mountain-200                 │
│ Strongest Month      │ December (Year-End Peak)     │
│ Weakest Month        │ February (YTD Low)           │
├──────────────────────┼──────────────────────────────┤
│ Geographic Coverage  │ US-wide, West-concentrated   │
│ Dashboard Status     │ Map visual deprecation ⚠️    │
└──────────────────────┴──────────────────────────────┘
```

---

## 👤 Analyst

**Adham** — Data Analyst
End-to-end BI delivery: requirements gathering → SQL data engineering → dimensional modelling → Power BI dashboard design → insights analysis.

---

*Insights derived from the AdventureWorks Internet Sales Power BI Dashboard. For methodology and SQL documentation, refer to [steps.md](./steps.md). For the full project overview, see [README.md](./README.md).*
