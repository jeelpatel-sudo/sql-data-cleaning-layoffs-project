**SQL Data Cleaning Project — Global Layoffs Dataset**

This project demonstrates a structured approach to cleaning and preparing raw data using MySQL. The dataset is sourced from Alex The Analyst’s GitHub repository:
Global Layoffs Dataset (https://github.com/AlexTheAnalyst/MySQL-YouTube-Series/blob/main/layoffs.csv). 


**Project Objective :**

The goal of this project was to practice SQL data-cleaning techniques and produce a clean, analysis-ready dataset. The steps include removing duplicates, standardizing data, handling null values, and dropping unnecessary columns.

**Tools and SQL Functions Used**

1. MySQL (Primary database system)
2. Window Functions (ROW_NUMBER)
3. Data Type Conversions (STR_TO_DATE, ALTER TABLE MODIFY)
4. CTEs (Common Table Expressions)
5. Text Standardization Functions (TRIM, LIKE)
6. Joins for Null Replacement
7. Staging Table Creation

**Data Cleaning Workflow**

I followed a clear 4-step plan to clean the layoffs dataset:

**1️ Remove Duplicates**

Created staging tables to protect original data.

Used ROW_NUMBER() window function to flag duplicate rows based on all relevant columns.

Deleted records where row numbers > 1.

**2️ Standardize the Data**

Trimmed whitespace from text fields using TRIM().

Standardized inconsistent categories (e.g., “Crypto”, “United States”).

Cleaned and converted the date column from text to proper MySQL DATE format using STR_TO_DATE.

Ensured all fields followed uniform formatting standards.

**3️ Handle Null and Blank Values**

Identified null or blank values in categorical fields.

Replaced blanks with NULL for consistency.

Used a self-join method to populate missing values based on matching company/location data.

Cleaned accidental duplicated rows by reapplying the row number method.


**4️ Remove Unnecessary Columns and Rows**

Deleted irrelevant columns (row_num, row_num_2).

Removed rows where both layoff metrics were null, meaning no meaningful data remained.

Produced a final cleaned table ready for analysis.


 **Final Result**

The final table is cleaned, consistent, and ready for analysis. This project demonstrates practical SQL skills in handling real-world, imperfect datasets and preparing them for further analysis or reporting.
