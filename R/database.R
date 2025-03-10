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
#' @param dir A string indicating the type of DuckDB database to create. The options are:
#' - `"temp"`: Creates a temporary database stored on disk in a temporary directory.
#' - `"in_memory"`: Creates an in-memory database that will not persist after the R session ends.
#' Default is `"temp"`.
#'
#' @return A list of `tbl` objects that are references to the Contoso datasets stored in the DuckDB database. The list contains the following tables:
#' - `sales`
#' - `product`
#' - `customer`
#' - `store`
#' - `fx`
#' @examples
#' # Create a DuckDB version of Contoso datasets stored in a temporary directory
#' create_contoso_duckdb(dir = "temp")
#'
#' # Create a DuckDB version of Contoso datasets stored in memory
#' create_contoso_duckdb(dir = "in_memory")
#' @export
create_contoso_duckdb <- function(dir="temp"){

 dir <-  match.arg(
    arg =dir
    ,choices = c("temp","in_memory")
  )


    if(dir=="temp"){
     dir <-   tempfile()
     con <- suppressWarnings(DBI::dbConnect(duckdb::duckdb(dir)))
    }else{
     con <- suppressWarnings(DBI::dbConnect(duckdb::duckdb()))
     }


  duckdb::duckdb_register(con,"sales"    ,contoso::sales,overwrite = TRUE)
  duckdb::duckdb_register(con,"product"  ,contoso::product,overwrite = TRUE)
  duckdb::duckdb_register(con,"customer" ,contoso::customer,overwrite = TRUE)
  duckdb::duckdb_register(con,"date"     ,contoso::date,overwrite = TRUE)
  duckdb::duckdb_register(con,"fx"       ,contoso::fx,overwrite = TRUE)
  duckdb::duckdb_register(con,"store"    ,contoso::store,overwrite = TRUE)
  duckdb::duckdb_register(con,"order"    ,contoso::order,overwrite = TRUE)
  duckdb::duckdb_register(con,"orderrows",contoso::orderrows,overwrite = TRUE)



  sales_db <- dplyr::tbl(con,dplyr::sql("select * from sales"))
  product_db <- dplyr::tbl(con,dplyr::sql("select * from product"))
  customer_db <- dplyr::tbl(con,dplyr::sql("select * from customer"))
  store_db <- dplyr::tbl(con,dplyr::sql("select * from store"))
  fx_db <- dplyr::tbl(con,dplyr::sql("select * from fx"))
  date_db <- dplyr::tbl(con,dplyr::sql("select * from date"))


  out <- list(
    sales=sales_db
    ,product=product_db
    ,customer=customer_db
    ,store=store_db
    ,fx=fx_db
    ,date=date_db
  )

  return(out)
}
