# Citi Bike SQL Analysis (January Dataset)

## Project Overview
This project analyzes Citi Bike trip data using **MySQL** to examine system demand patterns, rider behavior differences, and station level usage pressure. The analysis emphasizes **query design, data validation, and analytical reasoning** rather than ingestion automation or production pipelines.

The goal of this project is to demonstrate practical SQL skills and real world decision making when working with large, public datasets.

---

## Project Objectives

### 1. Demand Patterns
- What is the typical hourly demand pattern across all days?
- When does the system experience its highest and lowest demand?
- How does demand differ between weekdays and weekends?

### 2. Rider Behavior
- How do casual riders and members differ in average trip duration?
- How does trip duration vary between weekdays and weekends?
- What routes are most frequently used by each rider type?
- Are round trips more common among members or casual riders?

### 3. Station Demand Pressure
- Which stations experience the highest number of departures?
- Which stations experience the highest number of arrivals?

---

## Data Scope
This analysis uses **Citi Bike trip data from January only**.  
The dataset was intentionally scoped to a single month to focus on query structure, analytical clarity, and behavioral comparisons rather than seasonal variation.

Findings reflect winter usage patterns and are not intended to represent full year demand.

---

## Data Access
The raw CSV files used in this analysis are not included in the repository due to file size constraints.

The data is publicly available from the Citi Bike System Data portal:  
https://s3.amazonaws.com/tripdata/index.html

All SQL queries in this repository assume the standard Citi Bike trip data schema and can be executed after downloading and importing the data locally.

---

## Schema & Import Notes
The `CREATE TABLE` statement included in the SQL file reflects the **intended schema design** for this project.

Analysis queries were executed against an existing imported table with equivalent columns and data types. The table was not re-created to avoid CSV re-import issues encountered during initial setup.

This decision prioritizes analytical continuity over schema re-initialization for a portfolio project.

---

## Tools & Techniques
- **MySQL**
- Common Table Expressions (CTEs)
- Window functions (`RANK`, `DENSE_RANK`)
- Date and time functions
- Data quality checks (duplicate detection, validity filtering)

---


## Key Takeaways
- Citi Bike usage follows clear hourly demand patterns with distinct peak and low periods.
- Casual riders and members exhibit different usage behaviors, particularly in trip duration and route frequency.
- Certain stations consistently experience higher departure or arrival pressure, indicating potential operational bottlenecks.

---

## Repository Structure
- `citibike_analysis.sql` — schema definition, data checks, and analysis queries
- `README.md` — project overview and context

---
