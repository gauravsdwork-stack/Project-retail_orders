# End-to-End Retail Orders Data Analytics ETL Project

This project uses a retail orders dataset from Kaggle and follows an end-to-end ETL and analytics workflow. Python downloads and processes the data, SQL stores and analyzes it, and a Tableau dashboard (added as an extension to the original workflow) makes the results interactive.

## Project structure

retail-orders-etl-project/
├── README.md
├── Project retail_orders.ipynb
├── sql file.sql
├── Retail Sales Dashboard.twb
├── Retail Sales Dashboard.png

## Workflow

1. **Extract — Kaggle API:** Download the retail orders dataset from Kaggle.
2. **Transform — Python and Pandas:** Clean and process the downloaded data in Jupyter Notebook.
3. **Load — SQL database:** Transfer the processed data from Python into the SQL.
4. **Analyze — SQL:** Query the loaded data to answer product, regional, monthly sales, and sub-category profit questions.
5. **Visualize — Tableau:** Connect Tableau to the database and explore the analysis in the dashboard added to this project.

## Analysis questions

- Which 10 products have the highest total sales?
- Which five products have the highest sales in each region?
- How do monthly sales compare between 2022 and 2023?
- Which sub-category had the largest profit change from 2022 to 2023?

The profit comparison is the **absolute change** (`profit in 2023 - profit in 2022`), not percentage growth.

## Project files

- **`Project retail_orders.ipynb`** — Jupyter Notebook for Python/Pandas data preparation and database loading.
- **`sql file.sql`** — SQL queries for the analysis.
- **`Retail Sales Dashboard.twb`** — Tableau workbook with four analysis sheets arranged on an interactive dashboard.
- **`Book1.twb`** — earlier Tableau workbook file.

## Tools

- Kaggle API
- Python, Pandas, and Jupyter Notebook
- SQL database and SQL client
- Tableau Desktop

## Run the project

1. Configure Kaggle API credentials and download the dataset.
2. Use the Jupyter Notebook with Python/Pandas to clean and process the data.
3. Connect the notebook to your SQL database and load the processed data into a database named `retail_db` and a table named `orders`.
4. Run `sql file.sql` against the loaded table. The regional top-five query uses common table expressions and a window function.
5. Open `Retail Sales Dashboard.twb` in Tableau Desktop. If needed, edit the data source connection and refresh the data.

The SQL queries and Tableau workbook expect fields including `product_id`, `region`, `order_date`, `sale_price`, `profit`, and `sub_category`. The raw CSV uses different header names and includes source fields such as `List Price`, `cost price`, `Quantity`, and `Discount Percent`; the transformation step should ensure the loaded table has the fields expected by the SQL and workbook.

## Tableau dashboard

The dashboard was added to the ETL and SQL analysis workflow and contains these views:

- Top 10 highest-revenue products
- Top 5 highest-selling products in each region
- Monthly sales comparison for 2022 and 2023
- Sub-category profit change from 2022 to 2023

Select a mark in a chart to filter the other dashboard sheets. Clear the selection to show all values again. Filter cards are also available for the fields shown on the dashboard.

## Database connection note

The workflow diagram labels the database as **SQL Server**. The current Tableau workbook and SQL script in this project are configured for **MySQL**: the workbook points to `127.0.0.1:3306` and database `retail_db`, and the SQL uses MySQL syntax. If you use Microsoft SQL Server for the project, update the Tableau connection and adapt the SQL queries to SQL Server syntax. Do not commit database passwords or Kaggle API credentials to the repository.

The Tableau workbook stores a database connection rather than a copy of the database. The top-five query uses `ROW_NUMBER()`, which returns at most five products per region; use `RANK()` if ties at fifth place should all be included.
