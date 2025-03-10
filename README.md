
# contoso

<!-- badges: start -->
<!-- badges: end -->

Contoso is a synthetic dataset containing sample sales transaction data for the fictional "Contoso" company. It includes various supporting tables for business intelligence, such as customer, store, product, and currency exchange data.

You can either load the datasets directly or use the function `create_contonso_duckdb()` to create a DuckDB database that contains the following tables:

-   sales
-   customer
-   store
-   product
-   fx
-   date
-   order
-   orderrows

This dataset is perfect for practicing time series analysis, financial modeling, or any business intelligence-related tasks.

## Installation

You can install the development version of contoso from [GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("alejandrohagan/contonso")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(contoso)

# Create a DuckDB database containing Contoso datasets
contoso_db <- create_contonso_duckdb(dir = "temp")

# Access the sales dataset from the database
sales_data <- contoso_db$sales

```

## Features

-   Realistic Sales Data: Simulates a variety of sales transactions, customer details, store locations, and product information.
-   Multiple Data Tables: Supports multiple tables like sales, customers, store details, product catalog, exchange rates, and time-series information.
-   Easy-to-Use: Load and use data directly or create a full DuckDB database for seamless analysis with create_contoso_database().
