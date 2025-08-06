## Candy Distributor Sales Analysis
This project analyzes sales and shipment data for a US national candy distributor, covering customer orders, product details, factory locations, and regional targets. Using Power BI and a structured data warehouse, we explore sales trends, product performance, and geospatial patterns from factory to customer delivery. The goal is to uncover actionable insights that help optimize product strategy, enhance regional performance, and support data-driven business decisions.

### Insights and recommendations are provided on the following key areas:

- **Sales Trends:** Analysis of revenue and units sold over time across divisions.

- **Target Achievement:** Comparison of sales against targets by division.

- **Product Performance:** Evaluation of top-selling and high-margin products.

- **Factory Output:** Insight into sales contribution by factory.

- **Geospatial Analysis:** Sales distribution by state and ZIP to identify regional opportunities.

An interactive PowerBI dashboard can be downloaded [here.](https://github.com/dharmeshrohit/Candy-Distributor/blob/main/analysis/doc/Candy%20Distributor%20dashboard.pbix)

The SQL queries utilized to buil data warehouse can be found [here.](https://github.com/dharmeshrohit/Candy-Distributor/tree/main/warehouse/scripts)

The SQL queries utilized to clean, organize, and prepare data for the dashboard can be found [here.](https://github.com/dharmeshrohit/Candy-Distributor/blob/main/warehouse/scripts/gold/ddl_gold.sql)

A comprehensive Analysis Report can be found [here.](https://github.com/dharmeshrohit/Candy-Distributor/blob/main/analysis/doc/Candy%20Distributor%20dashboard.pbix)

## Data Warehouse
The data warehouse was built using a multi-layered approach:

- **Bronze Layer:** Raw ingested files (factories, products, sales, targets, uszips)

- **Silver Layer:** Cleaned and transformed tables for intermediate use

- **Gold Layer:** Analytical views structured as a dimensional model (facts & dimensions)

![Data Architecture](warehouse/docs/data_architecture.png)