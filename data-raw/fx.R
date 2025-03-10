## code to prepare `fx` dataset goes here
fpaR::create_data_raw()

dir <- "data-raw"

fx <- readr::read_csv(file.path(dir,"currencyexchange.csv"),name_repair = janitor::make_clean_names,show_col_types = FALSE)

usethis::use_data(fx, overwrite = TRUE)
