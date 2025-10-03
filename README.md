# Layoff Analysis Project (MySQL)

This project analyzes company layoff data using MySQL. It includes the raw database, data cleaning queries, and exploratory analysis.

## 📂 Files

1. **world_layoffs.sql**  
   - Full database export (schema + raw data).  
   - Import this file first into MySQL Workbench.  

2. **DATA_CLEANING.sql**  
   - Queries used to clean and preprocess the raw data.  
   - Run this after importing the database.  

3. **EXPLORATORY_DATA_ANALYSIS.sql**  
   - Queries for exploring patterns and insights in the cleaned data.  
   - Run this after completing the data cleaning stage.  

## How to Use

1. Open **MySQL Workbench** and connect to your server.  
2. Go to **Server → Data Import**.  
3. Select **world_layoffs.sql** to recreate the database.  
4. Run **DATA_CLEANING.sql** in the SQL editor to prepare the data.  
5. Run **EXPLORATORY_DATA_ANALYSIS.sql** to generate insights.  

---

## Tools Used
- MySQL Workbench  
- MySQL Server  

---

## Notes
- The `.sql` files are written for MySQL 8.0.  
- If using another version, adjust syntax if necessary.  
- The order of execution is important: **Database → Cleaning → Analysis**.
