## code to prepare `orderrows` dataset goes here
fpaR::create_data_raw()

dir <- "data-raw"

orderrows <- readr::read_csv(file.path(dir,"orderrows.csv"),name_repair = janitor::make_clean_names,show_col_types = FALSE)


usethis::use_data(orderrows, overwrite = TRUE)
