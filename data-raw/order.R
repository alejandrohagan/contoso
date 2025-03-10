## code to prepare `order` dataset goes here
fpaR::create_data_raw()

dir <- "data-raw"

order <- readr::read_csv(file.path(dir,"orders.csv"),name_repair = janitor::make_clean_names,show_col_types = FALSE)

usethis::use_data(order, overwrite = TRUE)
