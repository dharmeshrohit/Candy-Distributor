# Data Catalog for Gold Layer

## Overview
The Gold Layer is the business-level data representation, structured to support analytical and reporting use cases. It consists of **dimension tables** and **fact tables** for specific business metrics.

---
### **1. gold.dim_products**
- **Purpose:** Stores details about products, including pricing, cost, and manufacturing attributes.
- **Columns:**

| Column Name   | Data Type | Description                                                 |
| ------------- | --------- | ----------------------------------------------------------- |
| product\_id   | INT (PK)  | Unique identifier for each product.                         |
| product\_name | NVARCHAR  | Name or description of the product.                         |
| division      | NVARCHAR  | Business division or category to which the product belongs. |
| unit\_price   | DECIMAL   | Selling price per unit of the product.                      |
| unit\_cost    | DECIMAL   | Cost incurred per unit for the product.                     |
| factory       | NVARCHAR  | Factory or manufacturing unit producing the product.        |
| target        | DECIMAL   | Target sales or revenue goal associated with the product.   |

---

### **2. gold.dim_location**
- **Purpose:** Stores customer-related location and demographic information based on ZIP codes.
- **Columns:**

| Column Name  | Data Type | Description                                                    |
| ------------ | --------- | -------------------------------------------------------------- |
| customer\_id | INT (PK)  | Unique identifier linking to the customer in sales fact table. |
| zip          | NVARCHAR  | ZIP code of the customer location.                             |
| latitude     | DECIMAL   | Latitude coordinate of the location.                           |
| longitude    | DECIMAL   | Longitude coordinate of the location.                          |
| city         | NVARCHAR  | City name where the customer resides.                          |
| state\_name  | NVARCHAR  | State name corresponding to the customer's location.           |
| zcta         | NVARCHAR  | ZIP Code Tabulation Area (US census grouping of ZIP codes).    |
| population   | INT       | Population of the area defined by the ZIP code.                |
| density      | DECIMAL   | Population density of the area (people per sq. km).            |
| county\_fips | NVARCHAR  | Federal Information Processing Standard code for the county.   |
| country      | NVARCHAR  | Country of residence.                                          |
| region       | NVARCHAR  | Geographic region classification.                              |
| imprecise    | BIT       | Indicates if location details are approximate.                 |
| military     | BIT       | Flag to identify military addresses.                           |
| timezone     | NVARCHAR  | Time zone of the location.                                     |

---

### **3. gold.fact_sales**
- **Purpose:** Stores transactional sales data linking customers and products for analytics and reporting.
- **Columns:**

| Column Name   | Data Type | Description                                                     |
| ------------- | --------- | --------------------------------------------------------------- |
| order\_id     | INT (PK)  | Unique identifier for each sales order.                         |
| customer\_id  | INT (FK1) | Links to **gold.dim\_location.customer\_id**.                   |
| product\_id   | INT (FK2) | Links to **gold.dim\_products.product\_id**.                    |
| order\_date   | DATE      | Date when the order was placed.                                 |
| ship\_date    | DATE      | Date when the order was shipped.                                |
| ship\_mode    | NVARCHAR  | Mode of shipment (e.g., Standard, Express).                     |
| product\_name | NVARCHAR  | Name of the product ordered (denormalized for quick reporting). |
| division      | NVARCHAR  | Business division/category of the product (denormalized).       |
| sales         | DECIMAL   | Total sales value for the order line.                           |
| units         | INT       | Quantity of units sold.                                         |
| gross\_profit | DECIMAL   | Profit for the order line (sales – cost).                       |
| cost          | DECIMAL   | Total cost for the order line.                                  |
| target        | DECIMAL   | Target sales value for the order line.                          |

