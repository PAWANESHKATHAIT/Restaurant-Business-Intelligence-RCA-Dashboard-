# Restaurant Business Intelligence & RCA Dashboard

An end-to-end Business Intelligence project that ingests raw restaurant business, ads, and customer data, cleans it using SQL, and powers an automated **Root Cause Analysis (RCA) engine** in Power BI — flagging *why* an outlet's sales are declining and recommending corrective action, not just reporting the numbers.

Built as a portfolio project simulating a real restaurant analytics platform (Swiggy/Zomato-style), covering the full pipeline: raw data → database → SQL cleaning → DAX-powered BI dashboard.

---

## What this project does

- Tracks daily sales, orders, ad performance, and customer behavior across 100+ outlets
- Cleans messy, real-world-style data (duplicates, inconsistent formats, missing values) using SQL
- Powers a dynamic **Current vs. Comparison period** analysis — pick any two date ranges and instantly compare performance
- Automatically generates a **plain-English RCA summary** per outlet: what changed, by how much, and why
- Surfaces **actionable recommendations** (pricing, ad targeting, menu/portion checks) based on which metrics declined
- Breaks down the full conversion funnel: Impressions → Menu Opens → Cart Builds → Orders (I2M%, M2C%, C2O%, M2O%)
- Analyzes ad campaign ROI by Product Type and Segment

---

## Project Structure

| File | Purpose |
|---|---|
| `Business_Performance.csv` | Raw daily business data per outlet (sales, orders, ratings, funnel metrics, mealtime split, etc.) |
| `Ads_Performance.csv` | Raw daily ad campaign data per outlet (campaign, product type, segment, spend, sales) |
| `Customer_Master.csv` | Raw customer-level reference data |
| `Source.py` | Extracts data from the source Excel/CSV files and loads it into the MySQL database |
| `CreateTable.sql` | Creates the staging tables in the database that hold the raw, unprocessed data |
| `DataCleaning.sql` | Cleans the staged data using SQL — removes duplicates, standardizes formats, drops unusable columns — and produces the final analysis-ready tables |
| `Restaurant RCA.pbix` | The Power BI dashboard: data model, DAX measures, and the RCA report pages |

---

## Data Pipeline

```
Raw CSV files
     │
     ▼
Source.py  ───────────►  MySQL (staging tables, via CreateTable.sql schema)
     │
     ▼
DataCleaning.sql  ─────►  Clean, typed, deduplicated tables
     │
     ▼
Restaurant RCA.pbix  ──►  Power BI data model + DAX + RCA dashboard
```

1. **`Source.py`** reads the raw data files and loads them into MySQL using a bulk import process.
2. **`CreateTable.sql`** defines the staging schema — every column is loaded as text first, so the import never fails on messy/inconsistent source data.
3. **`DataCleaning.sql`** transforms the staged data: removes duplicate records, standardizes date formats, casts columns to proper types, and drops unusable placeholder columns — producing clean tables ready for analysis.
4. **`Restaurant RCA.pbix`** connects directly to the clean MySQL tables and contains the full data model, 50+ DAX measures, and the report pages.

---

## Dashboard Pages

**Restaurant RCA** — Outlet-level summary and automated root-cause narrative
- Filterable by Outlet, Current Period, and Comparison Period
- Auto-generated summary of what changed (sales, orders, funnel, mealtime, ads) and by how much
- Auto-generated action points tied to the specific metrics that declined

**Ads Performance** — Campaign-level breakdown
- ROI and performance by Outlet, Product Type, and Segment
- Period-over-period change tracking

---

## Key Metrics & DAX Logic

- **Funnel conversion:** I2M% (Impressions→Menu Opens), M2C% (Menu Opens→Cart Builds), C2O% (Cart Builds→Orders), M2O% (Menu Opens→Orders)
- **Sales & Ops:** Sales, Orders, AOV, Online%, Average Rating, KPT, Discount%
- **Ads:** Ad Spend, Ad Sales, ROI
- **Mealtime breakdown:** Breakfast, Lunch, Snacks, Dinner, Late Night orders
- All measures follow a **Current / Comparison / % Change** pattern using two disconnected date tables, allowing fully dynamic period-over-period analysis from report-level slicers.

---

## Tech Stack

- **Database:** MySQL
- **Data Loading:** Python
- **Data Cleaning:** SQL
- **Visualization & Modeling:** Power BI, DAX

---

## Notes

This project uses synthetic/sample data generated to reflect realistic restaurant business patterns (seasonality, weekend/festival effects, complaint-to-rating correlation, ad spend-to-sales relationships) for demonstration purposes.
