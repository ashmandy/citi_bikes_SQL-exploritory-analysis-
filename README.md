# Citi Bike NYC Trip Analysis — January 2025

## Project Overview
This project analyzes New York City Citi Bike trip data for January 2025 to uncover 
demand patterns, rider behavior differences, and station pressure insights. 
The analysis was self-directed — from data collection to SQL analysis — using 
MySQL in VS Code.

---

## Objectives
1. **Demand Patterns** — Identify peak and off-peak hours across weekdays and weekends
2. **Rider Behavior** — Compare trip duration, popular routes, and round trip habits 
between members and casual riders
3. **Station Demand Pressure** — Identify the busiest departure and arrival stations

---

## Dataset
- **Source:** Citi Bike NYC public trip data (self collected)
- **Time Period:** January 1, 2025 – January 31, 2025
- **Size:** ~1,553,476 total trips across multiple CSV files
- **Tool:** MySQL (VS Code — Database Client extension)

---

## Key Findings

### Demand Patterns
- The busiest hour overall was **5 PM with 139,766 trips**, followed closely by 
the broader afternoon window of 3 PM – 6 PM which consistently produced high 
trip volumes
- Morning commute hours also showed strong demand with **8 AM recording 119,669 trips**
- The quietest hour was **4 AM with only 5,543 trips**
- On **weekdays**, peak demand occurs at **5 PM (114,555 trips)** — consistent 
with evening commute behavior
- On **weekends**, peak demand shifts to **1 PM (31,283 trips)** — suggesting 
leisure and recreational use rather than commuting

### Rider Behavior
- **Members** took significantly more trips — **1,091,409 total** with an average 
trip duration of **~372 minutes**
- **Casual riders** took **109,628 trips** with a slightly shorter average duration 
of **~368 minutes**
- **Round trips** were more common among casual riders at **2.97%** compared to 
members at **1.20%**, suggesting casual riders are more likely to return to their 
starting station — consistent with leisure riding patterns
- Members favored consistent commute routes while casual riders showed more 
varied route usage

### Station Demand
- Analysis identified the top departure and arrival stations by total trip volume
- Station demand was unevenly distributed, with a small number of stations 
accounting for a disproportionate share of traffic

---

## SQL Techniques Used
- Common Table Expressions (CTEs)
- Window functions — `DENSE_RANK()`, `RANK() OVER (PARTITION BY)`
- `TIMESTAMPDIFF()` for trip duration calculation
- `CASE` statements for rider segmentation and round trip classification
- `DAYOFWEEK()` for weekday vs weekend analysis
- `EXTRACT()` for hourly demand breakdown
- Duplicate detection using `COUNT(DISTINCT)`
- Data quality filtering — excluding invalid trips under 60 seconds

---

## Files
| File | Description |
|------|-------------|
| `citibike_analysis.sql` | Full SQL analysis including table design, data cleaning, and all queries |

---

## Dashboard
A Tableau Public dashboard visualizing these findings is currently in progress 
and will be linked here upon completion.

---


## Repository Structure
- `citibike_analysis.sql` — schema definition, data checks, and analysis queries
- `README.md` — project overview and context

---
## Author
**Mandy Langlois**
Aspiring Data Analyst | Google Data Analytics Certificate (2026)
