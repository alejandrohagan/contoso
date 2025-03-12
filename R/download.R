#' @title Create data-raw files
#' @name create_data_raw
#' @description
#' Creates the data-raw files of the 10K row size Contoso files if they
#' they do not already exists.
#'
#' If it exists it will return nothing
#'
#' @returns list of csv files
#'
#'
create_data_raw <- function(){

    dir <- "data-raw"
    fx <-  file.path(dir,"currencyexchange.csv")
    customer <-  file.path(dir,"customer.csv")
    date <-  file.path(dir,"date.csv")
    orderrows <-  file.path(dir,"orderrows.csv")
    orders <-  file.path(dir,"orders.csv")
    product <-  file.path(dir,"product.csv")
    sales <-  file.path(dir,"sales.csv")
    store <-  file.path(dir,"store.csv")


    dir_lst <- c(fx,customer,date,orderrows,orders,product,sales,store)

    if(all(purrr::map(dir_lst,file.exists) |> unlist())){

        return(invisible(""))
    }

    url <- "https://github.com/sql-bi/contoso-data-generator-v2-data/releases/download/ready-to-use-data/csv-10k.7z"
    destfile <- "contonso-10k"
    utils::download.file(url, destfile)

    extracted_dir <- "data-raw"
    archive::archive_extract(destfile, dir = extracted_dir)

    file.remove(destfile)

}


