#' @param db_dir "temp" or "in_memory"
#'
#' @param size "100k","1M" or "10M"
#'
#' @title Creates duckdb versions of Contoso datasets
#' @name create_contoso_duckdb
#'
#' @details
#' The [create_contonso_duckdb] function registers the following Contoso datasets as DuckDB tables:
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
#' - `store`
#' - `orderrows`
#' - `date`
#' @examples
#' # Create a DuckDB version of Contoso datasets stored in memory
#' create_contoso_duckdb(db_dir = "in_memory",size="100K")
#' @export
create_contoso_duckdb <- function(db_dir= c("in_memory"),size="100K"){

  db_dir <-  rlang::arg_match(
    arg =db_dir
    ,values = c("temp","in_memory")
    ,multiple = FALSE
  )
  size <- "1M"
  assertthat::assert_that(is.character(size))
  size <- stringr::str_to_lower(size)
  size_vec <- rlang::arg_match(size,values=c("100k","1m","10m"))



  if(db_dir=="temp"){
    db_dir <-   tempfile()
    con <- suppressWarnings(DBI::dbConnect(duckdb::duckdb(db_dir)))
  }else{
    con <- suppressWarnings(DBI::dbConnect(duckdb::duckdb()))
  }


  #attach motherduck database

DBI::dbExecute(con,"ATTACH 'md:_share/contoso/5cd50a2d-d482-4160-b260-f10091290db9' as contoso")


tables_vec <- c("sales","product","customer","store","orders","orderrows","fx","date")

schema_options_vec <- c("100k"="small","1m"="medium","10m"="large")

schema_vec <- schema_options_vec[size_vec] |> unname()

sql_vec <- map(
  tables_vec
  ,.f=\(x)  DBI::Id("contoso",schema_vec,x)
)


sales_db <- dplyr::tbl(con,sql_vec[[1]])
product_db <- dplyr::tbl(con,sql_vec[[2]])
customer_db <- dplyr::tbl(con,sql_vec[[3]])
store_db <- dplyr::tbl(con,sql_vec[[4]])
orders_db <- dplyr::tbl(con,sql_vec[[5]])
orderrows_db <- dplyr::tbl(con,sql_vec[[6]])
fx_db <- dplyr::tbl(con,sql_vec[[7]])
date_db <- dplyr::tbl(con,sql_vec[[8]])


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
