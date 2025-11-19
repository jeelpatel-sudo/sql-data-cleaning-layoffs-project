**SQL Data Cleaning Project — Global Layoffs Dataset**

This project showcases my ability to clean, transform, and prepare raw data using MySQL. As my first SQL project, I focused on building a strong foundation in SQL-based data cleaning by following a structured, industry-standard workflow. The dataset used in this project comes from the public repository created by Alex The Analyst:
Dataset Source: Global Layoffs Dataset (CSV file) from GitHub.

Project Objective :

The purpose of this project was to practice and demonstrate essential SQL data-cleaning techniques using MySQL. Employers can use this project to evaluate my ability to:

Work with raw, unstructured data

Identify and remove duplicates

Standardize inconsistent text formats

Convert and validate data types

Handle null or missing values

Create staging tables

Prepare a clean, analysis-ready dataset


This project proves my understanding of real-world data cleaning processes commonly required in analytics and data engineering roles.

Tools & Technologies

MySQL (Primary database system)

Window Functions (ROW_NUMBER)

Data Type Conversions (STR_TO_DATE, ALTER TABLE MODIFY)

CTEs (Common Table Expressions)

Text Standardization Functions (TRIM, LIKE)

Joins for Null Replacement

Staging Table Creation

Data Cleaning Workflow

I followed a clear 4-step plan to clean the layoffs dataset:

1️ Remove Duplicates

Created staging tables to protect original data.

Used ROW_NUMBER() window function to flag duplicate rows based on all relevant columns.

Deleted records where row numbers > 1.

Repeated duplicate removal after discovering duplicate rows introduced during processing.

Key SQL Concepts Used:
ROW_NUMBER(), Partitioning, CTEs, DELETE operations

2️ Standardize the Data

Trimmed whitespace from text fields using TRIM().

Standardized inconsistent categories (e.g., “Crypto”, “United States”).

Cleaned and converted the date column from text to proper MySQL DATE format using STR_TO_DATE.

Ensured all fields followed uniform formatting standards.

Key SQL Concepts Used:
TRIM(), LIKE, UPDATE, STR_TO_DATE(), ALTER TABLE

3️ Handle Null and Blank Values

Identified null or blank values in categorical fields.

Replaced blanks with NULL for consistency.

Used a self-join method to populate missing values based on matching company/location data.

Cleaned accidental duplicated rows by reapplying the row number method.

Key SQL Concepts Used:
Self-JOIN, Conditional UPDATE, NULL handling

4️ Remove Unnecessary Columns and Rows

Deleted irrelevant columns (row_num, row_num_2).

Removed rows where both layoff metrics were null, meaning no meaningful data remained.

Produced a final cleaned table ready for analysis.

Key SQL Concepts Used:
ALTER TABLE DROP COLUMN, DELETE

 Final Result

The cleaned dataset is stored in a finalized staging table, containing standardized, consistent, and duplicate-free records—ready for deeper analysis, dashboards, or machine learning preparation.

This project demonstrates my ability to:

Build a structured data-cleaning workflow

Apply advanced SQL functions

Work independently with real-world, imperfect datasets

Prepare data for professional analysis
