## code to prepare `sales` dataset goes here

## code to prepare `customer` dataset goes here
fpaR::create_data_raw()

dir <- "data-raw"

sales <- readr::read_csv(file.path(dir,"sales.csv"),name_repair = janitor::make_clean_names,show_col_types = FALSE)


usethis::use_data(sales, overwrite = TRUE)
