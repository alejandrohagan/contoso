## code to prepare `customer` dataset goes here

fpaR::create_data_raw()

dir <- "data-raw"

sales <- readr::read_csv(file.path(dir,"sales.csv"),name_repair = janitor::make_clean_names,show_col_types = FALSE) |>
    dplyr::select(customer_key)

customer <- sales |>
    dplyr::left_join(
    readr::read_csv(file.path(dir,"customer.csv"),name_repair = janitor::make_clean_names,show_col_types = FALSE)
    ,by=dplyr::join_by(customer_key)
    )

rm(sales)

usethis::use_data(customer, overwrite = TRUE)
