# README


# contoso

Contoso is a synthetic dataset containing sample sales transaction data
for the fictional “Contoso” company. It includes various supporting
tables for business intelligence, such as customer, store, product, and
currency exchange data.

The package comes with the following datasets:

- **sales**:
  - Contains information about sales transactions, including the total
    sales amount, customer, store, and product involved. This also has
    calculated column for gross_revenue, net_revenue, margin, and cogs.

  - This is created via a series of joins from the below tables and
    great starting place for your analytics
- **customer**:
  - Contains details about customers, such as customer key, name,
    address, and demographic information.
- **store**:
  - Contains information about stores, including store key, name,
    location, and related details.
- **product**:
  - Contains information about products, such as product key, name,
    category, and price.
- **fx**:
  - Contains foreign exchange rate data, mapping currency pairs to their
    exchange rates on specific dates.
- **date**:
  - Contains date-related information, including date, week, month,
    quarter, and year for use in time-based analysis.
- **orders**:
  - Contains information about individual orders, including order key,
    customer key, order date, and store information.
- **orderrows**:
  - Contains detailed line items for each order, including product key,
    quantity, and price for each item in the order.

  You can either load the datasets directly or use the function
  `create_contoso_duckdb()` to create a DuckDB database that contains
  all of the tables.

The Contoso dataset is a fictional set of data created by Microsoft. It
is commonly used for educational and demonstration purposes to showcase
various features of data analysis, business intelligence tools, and data
processing techniques

This dataset is perfect for practicing time series analysis, financial
modeling, or any business intelligence-related tasks.

Using view, you can see the columns’ label using the
[labelled](https://larmarange.github.io/labelled/index.html)
package.[^1]

The data is sourced from the
[sqlbi](https://github.com/sql-bi/Contoso-Data-Generator-V2-Data/releases/tag/ready-to-use-data)
github site

## Dataset overview

![Contoso Overview](fig/contoso_schema.svg)

The relationship keys that join each of the tables are listed below.

| sales         | customer     | product     | store     | order        | orderrows   | fx            |
|---------------|--------------|-------------|-----------|--------------|-------------|---------------|
| order_key     |              |             |           | order_key    | order_key   |               |
| customer_key  | customer_key |             |           | customer_key |             |               |
| store_key     |              |             | store_key | store_key    |             |               |
| product_key   |              | product_key |           |              | product_key |               |
| currency_code |              |             |           |              |             | from_currency |

## Installation

You can install the development version of contoso from
[GitHub](https://github.com/alejandrohagan/contoso) with:

``` r
# install.packages("pak")
pak::pak("alejandrohagan/contoso")
```

## Example

Example of how to create a duckdb database with Contoso tables loaded is
below:

``` r
library(contoso)

# Create a DuckDB database containing Contoso datasets and assign it to a list
contoso_db <- create_contoso_duckdb(dir = "temp",size="10K")

# Access the sales dataset from the list of database tables
sales_data <- contoso_db$sales
```

[^1]: Inspiration from [Crystal
    Lewis](https://cghlewis.com/blog/dict_clean/) excellent blog post
