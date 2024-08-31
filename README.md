
# Superstore Data Analysis - SQL Portfolio Project

## Project Overview

This project demonstrates the use of SQL for data cleaning, exploration, and analysis on a Superstore dataset. The project is divided into three major sections:

1. **Data Cleaning:** Preparing the data for analysis by performing necessary transformations.
2. **Data Exploration (Beginner to Advanced):** Extracting insights from the data using SQL queries.
3. **Advanced Analysis:** Identifying key patterns and trends in the data.

## Project Structure

- **`Data Cleaning.sql`**: SQL scripts used for cleaning and transforming the data.
- **`Data Exploration - Beginner.sql`**: SQL queries for basic data exploration.
- **`Data Exploration - Intermediate.sql`**: SQL queries for intermediate-level data exploration.
- **`Data Exploration - Advanced.sql`**: SQL queries for advanced-level data exploration.

## Data Cleaning Steps

1. **Establish Relationships**: Relationships between tables are established as per the ER diagram.
2. **Splitting Columns**: The `CityStateCountry` column is split into three individual columns: `City`, `State`, and `Country`.
3. **Category Mapping**: A new `Category` column is added based on the first three characters of the `ProductName` column:
   - `TEC`: Technology
   - `OFS`: Office Supplies
   - `FUR`: Furniture
4. **Trimming Product Names**: The first 4 characters of the `ProductName` column are removed.
5. **Removing Duplicates**: Duplicate rows in the `EachOrderBreakdown` table are removed.
6. **Handling Missing Values**: Blanks in the `OrderPriority` column in the `OrdersList` table are replaced with `NA`.

## Data Exploration

### Beginner Level
1. **Top 10 Orders by Sales**: List the top 10 orders with the highest sales from the `EachOrderBreakdown` table.
2. **Orders per Category**: Show the number of orders for each product category.
3. **Total Profit per Sub-Category**: Find the total profit for each sub-category.

### Intermediate Level
1. **Top Customer by Sales**: Identify the customer with the highest total sales across all orders.
2. **Best Month for Sales**: Find the month with the highest average sales in the `OrdersList` table.
3. **Average Quantity by Customers (with First Name Starting with 'S')**: Calculate the average quantity ordered by customers whose first name starts with 'S'.

### Advanced Level
1. **New Customers in 2014**: Determine how many new customers were acquired in the year 2014.
2. **Profit Contribution by Sub-Category**: Calculate the percentage of total profit contributed by each sub-category.
3. **Average Sales per Customer (with Multiple Orders)**: Find the average sales per customer, considering only those who have made more than one order.
4. **Top Performing Sub-Category by Category**: Identify the top-performing sub-category in each category based on total sales, including sub-category name, total sales, and ranking within each category.

## Requirements
- MySQL or SQL Server
- Basic understanding of SQL

## How to Use
1. Clone this repository to your local machine.
2. Import the Superstore dataset into your SQL environment.
3. Execute the SQL scripts provided in each section to perform the respective analyses.

## Conclusion
This project showcases how SQL can be leveraged to clean, explore, and analyze data, helping to uncover meaningful insights and trends within a dataset. It serves as a strong foundation for anyone looking to demonstrate their SQL skills in a data-driven project.
