#' @param db_dir "temp" or "in_memory"
#'
#' @param size "10K","100k","1M" or "10M"
#'
#' @title Creates duckdb versions of Contoso datasets
#' @name create_contoso_duckdb
#'
#' @details
#' The [create_contoso_duckdb] function registers the following Contoso datasets as DuckDB tables:
#' - `sales`: Contains sales transaction data.
#' - `product`: Contains details about products, including attributes like product name, manufacturer, and category.
#' - `customer`: Contains customer demographic and geographic information.
#' - `store`: Contains information about store locations and attributes.
#' - `fx`: Contains foreign exchange rate data for currency conversion.
#' - `date`: Contains various date-related information, including day, week, month, and year.
#'
#' You can choose to store the database in memory or in a temporary directory. If you choose "temp", the database will be created in a temporary file on disk. If you choose "in_memory", the database will be created entirely in memory and will be discarded after the R session ends.
#'
#' @return A list of lazy `tbl` objects that are references to the Contoso datasets stored in the DuckDB database. The list contains the following tables:
#' - `sales`
#' - `product`
#' - `customer`
#' - `store`
#' - `fx`
#' @examples
#' # Create a DuckDB version of Contoso datasets stored in memory
#' db_lst <- create_contoso_duckdb(db_dir = "in_memory",size="10K")
#' @export
create_contoso_duckdb <- function(db_dir= c("in_memory"),size="10K"){

  db_dir <-  match.arg(
    arg =db_dir
    ,choices = c("temp","in_memory")
  )

  if(db_dir=="temp"){
    db_dir <-   tempfile()
    con <- suppressWarnings(DBI::dbConnect(duckdb::duckdb(db_dir)))
  }else{
    con <- suppressWarnings(DBI::dbConnect(duckdb::duckdb()))
  }



  path_vec <- c(
    path_10K="https://github.com/sql-bi/Contoso-Data-Generator-V2-Data/releases/download/ready-to-use-data/csv-10k.7z",
    path_100K="https://github.com/sql-bi/Contoso-Data-Generator-V2-Data/releases/download/ready-to-use-data/csv-100k.7z",
    path_1M="https://github.com/sql-bi/Contoso-Data-Generator-V2-Data/releases/download/ready-to-use-data/csv-1m.7z",
    path_10M="https://github.com/sql-bi/Contoso-Data-Generator-V2-Data/releases/download/ready-to-use-data/csv-10m.7z"
  )


  size_choice <- paste0("path_",match.arg(toupper(size),c("10K","100K","1M","10M")))

  # make temp dir

  temp_dir  <- tempdir()
  temp_file <- tempfile()

  # download file

  utils::download.file(url = path_vec[[size_choice]],destfile = temp_file)


  archive::archive_extract(temp_file,dir=temp_dir)


  file_lst <- list.files(temp_dir,pattern = "*.csv")

  valid_names <- c(
    "currencyexchange.csv"
    ,"customer.csv"
    ,"date.csv"
    ,"orderrows.csv"
    ,"orders.csv"
    ,"product.csv"
    ,"sales.csv"
    , "store.csv")

  assertthat::assert_that(all.equal(file_lst,valid_names),msg = "Error in downloading file")

  full_file_path <- list.files(temp_dir,full.names = TRUE,pattern = "*.csv")


  #create sql query

  query <- glue::glue("

-- date
CREATE OR REPLACE TABLE fx AS
SELECT
    Date AS date,
    FromCurrency AS from_currency,
    ToCurrency AS to_currency,
    Exchange AS exchange
FROM read_csv_auto('{full_file_path[1]}');

-- customer

CREATE OR REPLACE TABLE customer AS
SELECT
    CustomerKey AS customer_key,
    GeoAreaKey AS geo_area_key,
    StartDT AS start_dt,
    EndDT AS end_dt,
    Continent AS continent,
    Gender AS gender,
    Title AS title,
    GivenName AS given_name,
    MiddleInitial AS middle_initial,
    Surname AS surname,
    StreetAddress AS street_address,
    City AS city,
    State AS state,
    StateFull AS state_full,
    ZipCode AS zip_code,
    Country AS country,
    CountryFull AS country_full,
    Birthday AS birthday,
    Age AS age,
    Occupation AS occupation,
    Company AS company,
    Vehicle AS vehicle,
    Latitude AS latitude,
    Longitude AS longitude
FROM read_csv_auto('{full_file_path[2]}');

-- date

CREATE OR REPLACE TABLE date AS
SELECT
    Date AS date,
    DateKey AS date_key,
    Year AS year,
    YearQuarter AS year_quarter,
    YearQuarterNumber AS year_quarter_number,
    Quarter AS quarter,
    YearMonth AS year_month,
    YearMonthShort AS year_month_short,
    YearMonthNumber AS year_month_number,
    Month AS month,
    MonthShort AS month_short,
    MonthNumber AS month_number,
    DayofWeek AS day_of_week,
    DayofWeekShort AS day_of_week_short,
    DayofWeekNumber AS day_of_week_number,
    WorkingDay AS working_day,
    WorkingDayNumber AS working_day_number
FROM read_csv_auto('{full_file_path[3]}');

-- orderrows

CREATE OR REPLACE TABLE orderrows AS
SELECT
    OrderKey AS order_key,
    LineNumber AS line_number,
    ProductKey AS product_key,
    Quantity AS quantity,
    UnitPrice AS unit_price,
    NetPrice AS net_price,
    UnitCost AS unit_cost
FROM read_csv_auto('{full_file_path[4]}');


-- orders

CREATE OR REPLACE TABLE orders AS
SELECT
    OrderKey AS order_key,
    CustomerKey AS customer_key,
    StoreKey AS store_key,
    OrderDate AS order_date,
    DeliveryDate AS delivery_date,
    CurrencyCode AS currency_code
FROM read_csv_auto('{full_file_path[5]}');


--- product

CREATE OR REPLACE TABLE product AS
SELECT
    ProductKey AS product_key,
    ProductCode AS product_code,
    ProductName AS product_name,
    Manufacturer AS manufacturer,
    Brand AS brand,
    Color AS color,
    WeightUnit AS weight_unit,
    Weight AS weight,
    Cost AS cost,
    Price AS price,
    CategoryKey AS category_key,
    CategoryName AS category_name,
    SubCategoryKey AS sub_category_key,
    SubCategoryName AS sub_category_name
FROM read_csv_auto('{full_file_path[6]}');

--- sales

CREATE OR REPLACE TABLE sales AS
WITH renamed AS (
    SELECT
        OrderKey AS order_key,
        LineNumber AS line_number,
        OrderDate AS order_date,
        DeliveryDate AS delivery_date,
        CustomerKey AS customer_key,
        StoreKey AS store_key,
        ProductKey AS product_key,
        Quantity AS quantity,
        UnitPrice AS unit_price,
        NetPrice AS net_price,
        UnitCost AS unit_cost,
        CurrencyCode AS currency_code,
        ExchangeRate AS exchange_rate
    FROM read_csv_auto('{full_file_path[7]}')
)
SELECT
    *,
    quantity * unit_price AS gross_revenue,
    quantity * net_price AS net_revenue,
    unit_price - net_price AS unit_discount,
    (unit_price - net_price) * quantity AS discounts,
    unit_cost * quantity AS cogs,
    (quantity * net_price) - (unit_cost * quantity) AS margin,
    ((quantity * net_price) - (unit_cost * quantity)) / quantity AS unit_margin
FROM renamed
;
CREATE OR REPLACE TABLE store AS
SELECT
    StoreKey AS store_key,
    StoreCode AS store_code,
    GeoAreaKey AS geo_area_key,
    CountryCode AS country_code,
    CountryName AS country_name,
    State AS state,
    OpenDate AS open_date,
    CloseDate AS close_date,
    Description AS description,
    SquareMeters AS square_meters,
    Status AS status
FROM read_csv_auto('{full_file_path[8]}');

",.con =con)


DBI::dbExecute(con, query)

sales_db <- dplyr::tbl(con,dplyr::sql("select * from sales"))
product_db <- dplyr::tbl(con,dplyr::sql("select * from product"))
customer_db <- dplyr::tbl(con,dplyr::sql("select * from customer"))
store_db <- dplyr::tbl(con,dplyr::sql("select * from store"))
orders_db <- dplyr::tbl(con,dplyr::sql("select * from orders"))
orderrows_db <- dplyr::tbl(con,dplyr::sql("select * from orderrows"))
fx_db <- dplyr::tbl(con,dplyr::sql("select * from fx"))
date_db <- dplyr::tbl(con,dplyr::sql("select * from date"))


out <- list(
  sales=sales_db
  ,product=product_db
  ,customer=customer_db
  ,store=store_db
  ,fx=fx_db
  ,date=date_db
  ,orders=orders_db
  ,orderrows=orderrows_db
)



return(out)
}
