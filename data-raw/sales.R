## code to prepare `sales` dataset goes here

## code to prepare `customer` dataset goes here
fpaR::create_data_raw()

dir <- "data-raw"

sales <- readr::read_csv(file.path(dir,"sales.csv"),name_repair = janitor::make_clean_names,show_col_types = FALSE) |>
    dplyr::mutate(
        revenue=quantity*unit_price
        ,cogs=quantity*unit_cost
        ,margin=revenue-cogs
        ,unit_margin=unit_price-unit_cost
    )


usethis::use_data(sales, overwrite = TRUE)
